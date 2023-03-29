# ============================================================================
# FILE: file.py
# AUTHOR: Shougo Matsushita <Shougo.Matsu at gmail.com>
# License: MIT license
# ============================================================================

from pathlib import Path
from pynvim import Nvim
import copy
import importlib
import mimetypes
import shlex
import shutil
import subprocess
import re
import time
import typing

from defx.action import ActionAttr
from defx.action import ActionTable
from defx.base.kind import Base
from defx.clipboard import ClipboardAction
from defx.context import Context
from defx.defx import Defx
from defx.util import cd, cwd_input, confirm, error, Candidate
from defx.util import readable, fnamemodify
from defx.view import View

_action_table: typing.Dict[str, ActionTable] = {}

ACTION_FUNC = typing.Callable[[View, Defx, Context], None]


def action(name: str, attr: ActionAttr = ActionAttr.NONE
           ) -> typing.Callable[[ACTION_FUNC], ACTION_FUNC]:
    def wrapper(func: ACTION_FUNC) -> ACTION_FUNC:
        _action_table[name] = ActionTable(func=func, attr=attr)

        def inner_wrapper(view: View, defx: Defx, context: Context) -> None:
            return func(view, defx, context)
        return inner_wrapper
    return wrapper


class Kind(Base):

    def __init__(self, vim: Nvim) -> None:
        self.vim = vim
        self.name = 'file'

    def get_actions(self) -> typing.Dict[str, ActionTable]:
        actions = copy.copy(super().get_actions())
        actions.update(_action_table)
        return actions


def check_output(view: View, cwd: str, args: typing.List[str]) -> None:
    output = subprocess.check_output(args, cwd=cwd)
    if output:
        view.print_msg(output)


def check_overwrite(view: View, dest: Path, src: Path) -> Path:
    if not src.exists() or not dest.exists():
        return Path('')

    s_stat = src.stat()
    s_mtime = s_stat.st_mtime
    view.print_msg(f' src: {src} {s_stat.st_size} bytes')
    view.print_msg(f'      {time.strftime("%c", time.localtime(s_mtime))}')
    d_stat = dest.stat()
    d_mtime = d_stat.st_mtime
    view.print_msg(f'dest: {dest} {d_stat.st_size} bytes')
    view.print_msg(f'      {time.strftime("%c", time.localtime(d_mtime))}')

    choice: int = view._vim.call('defx#util#confirm',
                                 f'{dest} already exists.  Overwrite?',
                                 '&Force\n&No\n&Rename\n&Time\n&Underbar', 0)
    ret: Path = Path('')
    if choice == 1:
        ret = dest
    elif choice == 2:
        ret = Path('')
    elif choice == 3:
        ret = Path(view._vim.call(
            'defx#util#input',
            f'{src} -> ', str(dest),
            ('dir' if src.is_dir() else 'file')))
    elif choice == 4 and d_mtime < s_mtime:
        ret = src
    elif choice == 5:
        ret = Path(str(dest) + '_')
    return ret


def execute_job(view: View, args: typing.List[str]) -> None:
    view._vim.call('defx#util#close_async_job')

    if view._vim.call('has', 'nvim'):
        jobfunc = 'jobstart'
        jobopts = {}
    else:
        jobfunc = 'job_start'
        jobopts = {'in_io': 'null', 'out_io': 'null', 'err_io': 'null'}

    view._vim.vars['defx#_async_job'] = view._vim.call(jobfunc, args, jobopts)


def switch(view: View) -> None:
    windows = [x for x in range(1, view._vim.call('winnr', '$') + 1)
               if view._vim.call('getwinvar', x, '&buftype') == '']

    result = view._vim.call('choosewin#start', windows,
                            {'auto_choose': True, 'hook_enable': False})
    if not result:
        # Open vertical
        view._vim.command('noautocmd rightbelow vnew')


@action(name='cd')
def _cd(view: View, defx: Defx, context: Context) -> None:
    """
    Change the current directory.
    """
    source_name = defx._source.name
    is_parent = context.args and context.args[0] == '..'
    prev_cwd = Path(defx._cwd)

    if is_parent:
        path = prev_cwd.parent
    else:
        if context.args:
            if len(context.args) > 1:
                source_name = context.args[0]
                path = Path(context.args[1])
            else:
                path = Path(context.args[0])
        else:
            path = Path.home()
        path = prev_cwd.joinpath(path)
        if not readable(path):
            error(view._vim, f'{path} is invalid.')
        path = path.resolve()
        if source_name == 'file' and not path.is_dir():
            error(view._vim, f'{path} is invalid.')
            return

    view.cd(defx, source_name, str(path), context.cursor)
    if is_parent:
        view.search_file(prev_cwd, defx._index)


@action(name='change_vim_cwd', attr=ActionAttr.NO_TAGETS)
def _change_vim_cwd(view: View, defx: Defx, context: Context) -> None:
    """
    Change the current working directory.
    """
    cd(view._vim, defx._cwd)


@action(name='check_redraw', attr=ActionAttr.NO_TAGETS)
def _check_redraw(view: View, defx: Defx, context: Context) -> None:
    root = defx.get_root_candidate()['action__path']
    if not root.exists():
        return
    mtime = root.stat().st_mtime
    if mtime != defx._mtime:
        view.redraw(True)


@action(name='copy')
def _copy(view: View, defx: Defx, context: Context) -> None:
    if not context.targets:
        return

    message = 'Copy to the clipboard: {}'.format(
        str(context.targets[0]['action__path'])
        if len(context.targets) == 1
        else str(len(context.targets)) + ' files')
    view.print_msg(message)

    view._clipboard.action = ClipboardAction.COPY
    view._clipboard.candidates = context.targets


@action(name='drop')
def _drop(view: View, defx: Defx, context: Context) -> None:
    """
    Open like :drop.
    """
    cwd = view._vim.call('getcwd', -1)
    command = context.args[0] if context.args else 'edit'

    for target in context.targets:
        path = target['action__path']

        if path.is_dir():
            view.cd(defx, defx._source.name, str(path), context.cursor)
            continue

        bufnr = view._vim.call('bufnr', f'^{path}$')
        winids = view._vim.call('win_findbuf', bufnr)

        if winids:
            view._vim.call('win_gotoid', winids[0])
        else:
            # Jump to the last accessed window
            view._vim.command('wincmd p')

            if view._vim.call('win_getid') == view._winid:
                view._vim.command('wincmd w')

            if not view._vim.call('haslocaldir'):
                try:
                    path = path.relative_to(cwd)
                except ValueError:
                    pass

            view._vim.call('defx#util#execute_path', command, str(path))

        view.restore_previous_buffer(view._prev_bufnr)
    view.close_preview()


@action(name='execute_command', attr=ActionAttr.REDRAW)
def _execute_command(view: View, defx: Defx, context: Context) -> None:
    """
    Execute the command.
    """

    command = (context.args[0]
               if context.args and context.args[0]
               else view._vim.call('defx#util#input',
                                   'Command: ', '', 'shellcmd'))
    if not command:
        return
    is_async = len(context.args) >= 2 and context.args[1] == 'async'

    view._vim.command('redraw')

    command_args = shlex.split(command)
    if '*' in command_args:
        args = []
        for arg in command_args:
            if arg == '*':
                args += [str(x['action__path']) for x in context.targets]
            else:
                args.append(arg)

        if is_async:
            execute_job(view, args)
        else:
            check_output(view, defx._cwd, args)
        return

    def parse_argument(arg: str) -> str:
        if not arg.startswith('%'):
            return arg
        arg = arg[1:]
        m = re.match(r'((:.)*)(.*)', arg)
        target_path = str(target['action__path'])
        if not m:
            return target_path
        return fnamemodify(view._vim, target_path, m.group(2)) + m.group(3)

    for target in context.targets:
        args = [parse_argument(x) for x in command_args]

        if is_async:
            execute_job(view, args)
        else:
            check_output(view, defx._cwd, args)


@action(name='execute_system')
def _execute_system(view: View, defx: Defx, context: Context) -> None:
    """
    Execute the file by system associated command.
    """
    for target in context.targets:
        view._vim.call('defx#util#open', str(target['action__path']))


@action(name='link')
def _link(view: View, defx: Defx, context: Context) -> None:
    if not context.targets:
        return

    message = 'Link to the clipboard: {}'.format(
        str(context.targets[0]['action__path'])
        if len(context.targets) == 1
        else str(len(context.targets)) + ' files')
    view.print_msg(message)

    view._clipboard.action = ClipboardAction.LINK
    view._clipboard.candidates = context.targets


@action(name='move')
def _move(view: View, defx: Defx, context: Context) -> None:
    if not context.targets:
        return

    message = 'Move to the clipboard: {}'.format(
        str(context.targets[0]['action__path'])
        if len(context.targets) == 1
        else str(len(context.targets)) + ' files')
    view.print_msg(message)

    view._clipboard.action = ClipboardAction.MOVE
    view._clipboard.candidates = context.targets


@action(name='new_directory')
def _new_directory(view: View, defx: Defx, context: Context) -> None:
    """
    Create a new directory.
    """
    candidate = view.get_cursor_candidate(context.cursor)
    if not candidate:
        return

    if candidate['is_opened_tree'] or candidate['is_root']:
        cwd = str(candidate['action__path'])
    else:
        cwd = str(Path(candidate['action__path']).parent)

    new_filename = cwd_input(
        view._vim, cwd,
        'Please input a new directory name: ', '', 'file')
    if not new_filename:
        return
    filename = Path(cwd).joinpath(new_filename)

    if not filename:
        return
    if filename.exists():
        error(view._vim, f'{filename} already exists')
        return

    filename.mkdir(parents=True)
    view.redraw(True)
    view.search_recursive(filename, defx._index)


@action(name='new_file')
def _new_file(view: View, defx: Defx, context: Context) -> None:
    """
    Create a new file and it's parent directories.
    """
    candidate = view.get_cursor_candidate(context.cursor)
    if not candidate:
        return

    if candidate['is_opened_tree'] or candidate['is_root']:
        cwd = str(candidate['action__path'])
    else:
        cwd = str(Path(candidate['action__path']).parent)

    new_filename = cwd_input(
        view._vim, cwd,
        'Please input a new filename: ', '', 'file')
    if not new_filename:
        return
    isdir = new_filename[-1] == '/'
    filename = Path(cwd).joinpath(new_filename)

    if not filename:
        return
    if filename.exists():
        error(view._vim, f'{filename} already exists')
        return

    if isdir:
        filename.mkdir(parents=True)
    else:
        filename.parent.mkdir(parents=True, exist_ok=True)
        filename.touch()

    view.redraw(True)
    view.search_recursive(filename, defx._index)


@action(name='new_multiple_files')
def _new_multiple_files(view: View, defx: Defx, context: Context) -> None:
    """
    Create multiple files.
    """
    candidate = view.get_cursor_candidate(context.cursor)
    if not candidate:
        return

    if candidate['is_opened_tree'] or candidate['is_root']:
        cwd = str(candidate['action__path'])
    else:
        cwd = str(Path(candidate['action__path']).parent)

    save_cwd = view._vim.call('getcwd')
    cd(view._vim, cwd)

    str_filenames: str = view._vim.call(
        'input', 'Please input new filenames: ', '', 'file')
    cd(view._vim, save_cwd)

    if not str_filenames:
        return None

    for name in shlex.split(str_filenames):
        is_dir = name[-1] == '/'

        filename = Path(cwd).joinpath(name)
        if filename.exists():
            error(view._vim, f'{filename} already exists')
            continue

        if is_dir:
            filename.mkdir(parents=True)
        else:
            if not filename.parent.exists():
                filename.parent.mkdir(parents=True)
            filename.touch()

    view.redraw(True)
    view.search_recursive(filename, defx._index)


@action(name='open')
def _open(view: View, defx: Defx, context: Context) -> None:
    """
    Open the file.
    """
    cwd = view._vim.call('getcwd', -1)
    command = context.args[0] if context.args else 'edit'
    choose = command == 'choose' and (
        view._vim.call('exists', 'g:loaded_choosewin')
        or view._vim.call('hasmapto', '<Plug>(choosewin)', 'n'))
    previewed_buffers = view._vim.vars['defx#_previewed_buffers']
    for target in context.targets:
        path = target['action__path']

        if path.is_dir():
            view.cd(defx, defx._source.name, str(path), context.cursor)
            continue

        if not view._vim.call('haslocaldir'):
            try:
                path = path.relative_to(cwd)
            except ValueError:
                pass

        if choose:
            switch(view)

        view._vim.call('defx#util#execute_path',
                       'edit' if choose else command, str(path))

        bufnr = str(view._vim.call('bufnr', str(path)))
        if bufnr in previewed_buffers:
            previewed_buffers.pop(bufnr)
            view._vim.vars['defx#_previewed_buffers'] = previewed_buffers

        view.restore_previous_buffer(view._prev_bufnr)
    view.close_preview()


@action(name='open_directory')
def _open_directory(view: View, defx: Defx, context: Context) -> None:
    """
    Open the directory.
    """
    if context.args:
        path = Path(context.args[0])
    else:
        for target in context.targets:
            path = target['action__path']

    if path.is_dir():
        view.cd(defx, 'file', str(path), context.cursor)


@action(name='paste', attr=ActionAttr.NO_TAGETS)
def _paste(view: View, defx: Defx, context: Context) -> None:
    candidate = view.get_cursor_candidate(context.cursor)
    if not candidate:
        return

    if candidate['is_opened_tree'] or candidate['is_root']:
        cwd = str(candidate['action__path'])
    else:
        cwd = str(Path(candidate['action__path']).parent)

    action = view._clipboard.action
    dest = None
    for index, candidate in enumerate(view._clipboard.candidates):
        path = candidate['action__path']
        dest = Path(cwd).joinpath(path.name)
        if dest.exists():
            overwrite = check_overwrite(view, dest, path)
            if overwrite == Path(''):
                continue
            dest = overwrite

        if not path.exists() or path == dest:
            continue

        view.print_msg(
            f'[{index + 1}/{len(view._clipboard.candidates)}] {path}')

        if dest.exists() and action != ClipboardAction.MOVE:
            # Must remove dest before
            if not dest.is_symlink() and dest.is_dir():
                shutil.rmtree(str(dest))
            else:
                dest.unlink()

        if action == ClipboardAction.COPY:
            if path.is_dir():
                shutil.copytree(str(path), dest)
            else:
                shutil.copy2(str(path), dest)
        elif action == ClipboardAction.MOVE:
            shutil.move(str(path), cwd)

            # Check rename
            if not path.is_dir():
                view._vim.call('defx#util#buffer_rename',
                               view._vim.call('bufnr', str(path)), str(dest))
        elif action == ClipboardAction.LINK:
            # Create the symbolic link to dest
            dest.symlink_to(path, target_is_directory=path.is_dir())

        view._vim.command('redraw')
    if action == ClipboardAction.MOVE:
        # Clear clipboard after move
        view._clipboard.candidates = []
    view._vim.command('echo')

    view.redraw(True)
    if dest:
        view.search_recursive(dest, defx._index)


@action(name='preview')
def _preview(view: View, defx: Defx, context: Context) -> None:
    candidate = view.get_cursor_candidate(context.cursor)
    if not candidate or candidate['action__path'].is_dir():
        return

    filepath = str(candidate['action__path'])
    guess_type = mimetypes.guess_type(filepath)[0]
    if (guess_type and guess_type.startswith('image/') and
            shutil.which('ueberzug') and shutil.which('bash')):
        _preview_image(view, defx, context, candidate)
        return

    _preview_file(view, defx, context, candidate)


def _preview_file(view: View, defx: Defx,
                  context: Context, candidate: Candidate) -> None:
    filepath = str(candidate['action__path'])

    has_preview = bool(view._vim.call('defx#util#_get_preview_window'))
    if (has_preview and view._previewed_target and
            view._previewed_target == candidate):
        view._vim.command('pclose!')
        return

    prev_id = view._vim.call('win_getid')

    listed = view._vim.call('buflisted', filepath)

    view._previewed_target = candidate
    view._vim.call('defx#util#preview_file',
                   context._replace(targets=[])._asdict(), filepath)
    view._vim.current.window.options['foldenable'] = False

    if not listed:
        bufnr = str(view._vim.call('bufnr', filepath))
        previewed_buffers = view._vim.vars['defx#_previewed_buffers']
        previewed_buffers[bufnr] = 1
        view._vim.vars['defx#_previewed_buffers'] = previewed_buffers

    view._vim.call('win_gotoid', prev_id)


def _preview_image(view: View, defx: Defx,
                   context: Context, candidate: Candidate) -> None:
    filepath = str(candidate['action__path'])

    if filepath == view._previewed_img:
        view._previewed_img = ''
        return

    preview_image_sh = Path(__file__).parent.parent.joinpath(
        'preview_image.sh')

    wincol = context.wincol + view._vim.call('winwidth', 0)
    if wincol + context.preview_width > view._vim.options['columns']:
        wincol -= 2 * context.preview_width
    args = ['bash', str(preview_image_sh), filepath,
            wincol, 1, context.preview_width]

    execute_job(view, args)
    view._previewed_img = filepath


@action(name='remove', attr=ActionAttr.REDRAW)
def _remove(view: View, defx: Defx, context: Context) -> None:
    """
    Delete the file or directory.
    """
    if not context.targets:
        return

    force = context.args[0] == 'force' if context.args else False
    if not force:
        message = 'Are you sure you want to delete {}?'.format(
            str(context.targets[0]['action__path'])
            if len(context.targets) == 1
            else str(len(context.targets)) + ' files')
        if not confirm(view._vim, message):
            return

    for target in context.targets:
        path = target['action__path']

        if path.is_dir():
            shutil.rmtree(str(path))
        else:
            path.unlink()

        view._vim.call('defx#util#buffer_delete',
                       view._vim.call('bufnr', str(path)))


@action(name='remove_trash', attr=ActionAttr.REDRAW)
def _remove_trash(view: View, defx: Defx, context: Context) -> None:
    """
    Delete the file or directory.
    """
    if not context.targets:
        return

    if not importlib.util.find_spec('send2trash'):
        error(view._vim, '"Send2Trash" is not installed')
        return

    force = context.args[0] == 'force' if context.args else False
    if not force:
        message = 'Are you sure you want to delete {}?'.format(
            str(context.targets[0]['action__path'])
            if len(context.targets) == 1
            else str(len(context.targets)) + ' files')
        if not confirm(view._vim, message):
            return

    import send2trash
    for target in context.targets:
        send2trash.send2trash(str(target['action__path']))

        view._vim.call('defx#util#buffer_delete',
                       view._vim.call('bufnr', str(target['action__path'])))


@action(name='rename')
def _rename(view: View, defx: Defx, context: Context) -> None:
    """
    Rename the file or directory.
    """

    if len(context.targets) > 1:
        # ex rename
        view._vim.call('defx#exrename#create_buffer',
                       [{'action__path': str(x['action__path'])}
                        for x in context.targets],
                       {'buffer_name': 'defx'})
        return

    for target in context.targets:
        old = target['action__path']
        new_filename = cwd_input(
            view._vim, defx._cwd,
            f'Old name: {old}\nNew name: ', str(old), 'file')
        view._vim.command('redraw')
        if not new_filename:
            return
        new = Path(defx._cwd).joinpath(new_filename)
        if not new or new == old:
            continue
        if str(new).lower() != str(old).lower() and new.exists():
            error(view._vim, f'{new} already exists')
            continue

        if not new.parent.exists():
            new.parent.mkdir(parents=True)
        old.rename(new)

        # Check rename
        # The old is directory, the path may be matched opened file
        if not new.is_dir():
            view._vim.call('defx#util#buffer_rename',
                           view._vim.call('bufnr', str(old)), str(new))

        view.redraw(True)
        view.search_recursive(new, defx._index)
