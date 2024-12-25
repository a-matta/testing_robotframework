import pathlib
import subprocess
from importlib.metadata import version

from invoke import task

ROOT = pathlib.Path(__file__).parent.resolve().as_posix()
VERSION = version("testing_robot")


@task
def clean(context):
    """Clean the root folder. Remove all generated files/directories"""
    cmd = [
        "rm",
        "-rf",
        f"{ROOT}/.pytest_cache",
        f"{ROOT}/pytest.log",
        f"{ROOT}/report",
        f"{ROOT}/test-results",
    ]
    subprocess.run(" ".join(cmd), shell=True, check=False)


@task(pre=[clean])
def tests(context, headed=False, browser="chromium", slowmo="0", tracing=False, video=False, mark=""):
    """Run the tests in 'tests' directory.

    Args:
        headed: Run the tests in headed mode. Defaults to headless mode.
        browser: Browser to run the tests. Defaults to "chromium".
        slowmo: Whether to run the tests in slow motion. Disabled by default.
        tracing: Whether to record a trace for failing test. Disabled by default.
        video: Whether to record a video for failing test. Disabled by default.
        mark: Mark to select/deselect tests to be executed.


    For reference: see https://playwright.dev/python/docs/test-runners#cli-arguments
    """
    cmd = [
        "pytest",
        "--alluredir",
        "allure-results",
        "--headed" if headed else "",
        f"--browser {browser}",
        f"--slowmo={slowmo}",
        "--tracing=retain-on-failure" if tracing else "",
        "--video=retain-on-failure" if video else "",
        f'-m "{mark}"' if mark else "",
        f"{ROOT}/tests",
    ]
    subprocess.run(" ".join(cmd), shell=True, check=True)
