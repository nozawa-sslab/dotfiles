#!/home/nozawa/.pyenv/shims/python
from contextlib import contextmanager
import click
import os
import subprocess as sb
import sys


@contextmanager
@click.command()
@click.option("--port", "-p", required=True)
def spawn_process(port: int):
    proc = sb.Popen(
        ["jupyter", "notebook", "--no-browser", "--port={}".format(port)],
        stdout=sb.PIPE,
        stderr=sb.STDOUT,
    )
    try:
        yield proc
    finally:
        proc.terminate()
        proc.kill()


def jpt(proc: sb.Popen) -> None:
    with open(os.path.join(os.environ["HOME"], ".jupyter_log"), "w") as f:
        while proc.poll() == None:
            line = proc.stdout.readline()
            if line != b"":
                print(line.decode("utf-8"), end="")
                f.write(line.decode("utf-8"))
        proc.wait()


if __name__ == "__main__":
    with spawn_process() as proc:
        jpt(proc)
