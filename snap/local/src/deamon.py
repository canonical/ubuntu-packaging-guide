#!/usr/bin/python3

import os
import http.server
import socketserver

from common import *


def main():
    os.chdir(GetBasePath())

    handler = http.server.SimpleHTTPRequestHandler
    server_address = (GetHttpAddress(), GetHttpPort())

    with socketserver.TCPServer(server_address, handler) as httpd:
        httpd.serve_forever()


if __name__ == '__main__':
    main()
