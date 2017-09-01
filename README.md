# My personal blog
To update the blog use the following command:
```hugo```

```hugodeploy push```

Note that hugodeploy needs a config file called hugodepoy.yaml (not in this repo because of the .gitignore).
The template of hugodeploy.yaml is this:

```
# HugoDeploy Configuration File

# Connection settings for deployment target (FTP only)
ftp:
  host: ftp.andreaciceri.altervista.org
  port: 21
  user: ***
  pwd: ***
  rootdir: /blog/

# Connection settings for deployment target (SFTP only)
sftp:
  host: ftp.andreaciceri.altervista.org
  port: 22
  user: ***
  pwd: ***
  rootdir: /blog/

# Location of files to publish. For hugo static sites this is PublishDir and defaults to public
sourcedir: public

# Skip files or directories which match the following patterns
skipfiles:
  - .DS_Store
  - .git
  - /tmp

# Location of directory used for tracking what has been deployed
deployRecordDir: deployed

# Want lots of messages? [Default false]
#verbose: true

# Disable minification? [Default false]
#DontMinify: true
```
