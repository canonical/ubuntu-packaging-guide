#!/usr/bin/python3

import argparse
import subprocess

from common import *

___DESCRIPTION___ = ("This is a convenience tool to disply information of the "
                     "local version of the Ubuntu Packaging Guide and launch "
                     "a browser to the location of the HTTP file server.")

___EPILOG___ = ("Read more about this project:\n"
                "https://github.com/canonical/ubuntu-packaging-guide\n"
                "\n"
                "Set the HTTP port with:\n"
                "  $ snap set ubuntu-packaging-guide http.port=VALUE\n"
                "\n"
                "Set the HTTP address with:\n"
                "  $ snap set ubuntu-packaging-guide http.address=VALUE\n"
                "\n"
                "Stop the HTTP file server deamon:\n"
                "  $ snap stop ubuntu-packaging-guide.deamon\n"
                "\n"
                "Start the HTTP file server deamon:\n"
                "  $ snap start ubuntu-packaging-guide.deamon\n"
                "\n"
                "Restart the HTTP file server deamon:\n"
                "  $ snap restart ubuntu-packaging-guide.deamon\n")


def ParseArguments():
    parser = argparse.ArgumentParser(prog="ubuntu-packaging-guide",
                                     description=___DESCRIPTION___,
                                     epilog=___EPILOG___,
                                     formatter_class=argparse.RawTextHelpFormatter,  # noqa: E501
                                     add_help=False)

    parser.add_argument("-h", "--help",
                        action="help",
                        help="Display help, how to use this command.")

    parser.add_argument("-v", "--version",
                        action="version",
                        version="%(prog)s 2.0",
                        help="Display the local version of the "
                             "Ubuntu Packaging Guide.")

    commands = parser.add_subparsers(title="commands",
                                     dest="command",
                                     help="default: browse "
                                          "(if no command is specified)",
                                     required=False)
    commands.add_parser("info",
                        help="Display information about the local version of "
                             "the Ubuntu Packaging Guide and the HTTP file "
                             "server deamon.")
    commands.add_parser("browse",
                        help="Opens the Ubuntu Packaging Guide in a browser "
                             "(the HTTP file server deamon needs to be "
                             "running)")

    return parser.parse_args()


def LaunchBrowser(address):
    subprocess.check_call(["xdg-open", address])


def main():
    arguments = ParseArguments()

    match arguments.command:
        case "info":
            print("Ubuntu Packaging Guide\n"
                  f"  Version: {GetVersion()}\n"
                  f"  Commit: {GetCommitHash()}\n"
                  "\n"
                  "File Server:\n"
                  f"  HTTP Address: {GetHttpAddress()}\n"
                  f"  HTTP Port: {GetHttpPort()}\n"
                  f"  Root Path: {GetBasePath()}\n"
                  f"  Status: {GetDeamonStatus()}")

        # case "browse":
        case _:
            match GetDeamonStatus():
                case "active":
                    print("Lauching browser...")

                    address = f"http://{GetHttpAddress()}:{GetHttpPort()}"
                    LaunchBrowser(address)
                case _:
                    print("The HTTP file server deamon is not active. "
                          "To fix this:\n"
                          "\n"
                          " 1. Start the deamon:\n"
                          "   $ snap start ubuntu-packaging-guide.deamon\n"
                          " 2. Run this command again:\n"
                          "   $ ubuntu-packaging-guide browse\n")


if __name__ == '__main__':
    main()
