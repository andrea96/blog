#!/usr/bin/env python3

from ftpsync.targets import FsTarget
from ftpsync.ftp_target import FtpTarget
from ftpsync.synchronizers import UploadSynchronizer
from git import Repo
from credentials import user, password, host

repo = Repo(".git")
repo.git.add("*")
repo.index.commit("Automatic commit")
origin = repo.remote(name = "origin")
origin.push()

UploadSynchronizer(FsTarget("blog/_website/"),
                   FtpTarget("/blog/",
                             host,
                             username = user,
                             password = password),
                   {"force": False,
                    "delete_unmatched": True,
                    "verbose": 3}).run()
