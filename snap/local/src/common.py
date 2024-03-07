import os
import subprocess


def GetSnapPath() -> str:
    return os.environ["SNAP"]


def GetVersion() -> str:
    path = os.path.join(GetSnapPath(), "usr", "share",
                        "ubuntu-packaging-guide", "meta", "VERSION")
    with open(path, 'r') as file:
        return file.readline().rstrip()


def GetCommitHash() -> str:
    path = os.path.join(GetSnapPath(), "usr", "share",
                        "ubuntu-packaging-guide", "meta", "COMMIT-HASH")
    with open(path, 'r') as file:
        return file.readline().rstrip()


def SnapctlGet(key: str, defaultValue: str) -> str:
    value = subprocess.check_output(["snapctl", "get", key], text=True).strip()

    if value == "":
        return defaultValue

    return value


def GetHttpAddress() -> str:
    return SnapctlGet("http.address", "localhost")


def GetHttpPort() -> int:
    return int(SnapctlGet("http.port", "9000"))


def GetBasePath() -> str:
    return os.path.join(GetSnapPath(), "usr", "share",
                        "ubuntu-packaging-guide", "www")


def GetDeamonStatus() -> str:
    return subprocess.check_output("snapctl services "
                                   "| grep 'ubuntu-packaging-guide.deamon' "
                                   "| awk '{print $3}'",
                                   shell=True, text=True).strip()
