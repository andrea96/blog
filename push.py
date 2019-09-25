#!/usr/bin/env python3

from ftpsync.targets import FsTarget
from ftpsync.ftp_target import FtpTarget
from ftpsync.synchronizers import BiDirSynchronizer
from git import Repo
from datetime import datetime
from ablog.commands import ablog_build as build
from credentials import user, password, host


try:
    build(sourcedir = "blog/")
finally:
    repo = Repo(".git")
    repo.git.add("*")
    repo.index.commit("Automatic commit - {}"\
                      .format(datetime.now().strftime("%d/%m/%Y - %H:%M:%S")))
    origin = repo.remote(name = "origin")
    origin.push()

    BiDirSynchronizer(FsTarget("blog/_website/"),
                      FtpTarget("/blog/",
                                host,
                                username = user,
                                password = password),
                      {"resolve": "delete-unmatched",
                       "verbose": 3}).run()
