# docker-vscode-hack-osx
Work-Around and Discussion for https://github.com/microsoft/vscode-remote-release/issues/24

## Preamble

This repository was made to provide files and instructions for implementing the work-around for
VSCode Remote-SSH installation on OSX. Currently, an [issue](https://github.com/microsoft/vscode-remote-release/issues/24)
exists tracking an official solution.

Please keep all questions regarding this work-around here in this repository so that the official
issue is not clogged like a forum thread.

Please create an Issue here to ask your question.  Please check Closed Issues before asking your question.

## Instructions

### Remote Host

1. Install [Docker](https://hub.docker.com/?overlay=onboarding).
1. Open **Terminal**
1. ```mkdir vscode-hack```
1. ```cd vscode-hack```
1. ```vi Dockerfile```
1. ```docker build -t ssh .```
1. ```docker run -d -p 2222:22 --name ssh -v ${HOME}:/opt --restart unless-stopped ssh```

### Local Host

Within VSCode:

1. Click Remote Explorer
1. Click Settings
1. Edit .ssh/vscode.config

**vscode.config**
```
Host OSX
    HostName IP.AD.DR.ESS
    User root
    Port 2222
    StrictHostKeyChecking no
    UserKnownHostsFile=/dev/null
```

## Caveats

In the `docker run` statement above, I am mapping my home directory to `/opt` on the Remote Host.  This may or
may not be what you want, depending on your development environment.   If you map to `/opt`, upon first connection,
**Docker** will attempt to enumerate all directories and prompt you for access.  If you have mapped to your
home directory, Docker may prompt for additional permissions ("Documents", "Desktop", "Downloads", etc) on the 
remote.

```
"Docker" would like to access files in your Documents folder.
                           [ Don't Allow ]         [ OK ]
```

If you click `[ Don't Allow ]`, you will not be able to remotely see files in that folder.
