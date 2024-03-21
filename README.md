# docker-geant4course

This repository provides a Docker multi-architecture image for Geant4 and it's designed for the INFN Geant4 courses. It includes all necessary configurations to run Geant4 simulations with a graphical user interface (GUI) across different operating systems.

Docker is a powerful platform for developing, shipping, and running applications in isolated environments called containers. These containers allow for the packaging of an application with all of its dependencies into a single unit, ensuring that it runs consistently across different computing environments. By 'host operating system', or simply 'host', we refer to the operating system installed on the machine that runs Docker and hosts these containers. By leveraging Docker, you can develop and run code using Geant4 without the need to install Geant4 and its dependencies directly on your host system.

First, ensure Docker is installed on your machine. You can find installation instructions [here](https://docs.docker.com/get-docker/).


## GUI

To enable the Graphic User Interface, you should prepare your host operating system accordingly.

### Linux
Add local connections to the X11 access control list:
```
xhost local:root
```
This command must be executed every time you reboot your computer.


### Windows
If you don't have X11 installed already (it should be included in the latest versions of Windows 11), download XMing from:
https://sourceforge.net/projects/xming/

Use the Powershell terminal to launch Docker Compose.


### Mac
Install XQuartz from:
https://www.xquartz.org/

Start XQuartz:
```
open -a XQuartz
```

Go to XQuartz -> Settings and in the `Security` panel, enable `Allow connections from network clients`.

Restart XQuartz:

Check the location of the XQuartz config file, or domain, with:
```
quartz-wm --help
```
which should output:
```
usage: quartz-wm OPTIONS
Aqua window manager for X11.

--version                 Print the version string
--prefs-domain <domain>   Change the domain used for reading preferences
                          (default: org.xquartz.X11
```
The last line shows the default domain, in this case `org.xquartz.X11`. Before XQuartz 2.8.0 the default domain was: `org.macosforge.xquartz.X11`.
You can check the default domain  with:
```
defaults read org.xquartz.X11
```
To enable GLX acceleration, you must activate it with:
```
defaults write org.xquartz.X11 enable_iglx -bool true
```
Restart XQuartz again. You can verify if GLX is enabled with:
```
defaults read org.xquartz.X11
```
Finally, allow X11 forwarding to local containers:
```
xhost +localhost
```
the latter command has to be executed every time XQuartz is restarted.


## Preparing the installation

Create a folder for the course and from that folder donwload from this repository the `docker-compose.yml` file:
```
curl https://raw.githubusercontent.com/carlomt/docker-geant4course/main/docker-compose.yml --output docker-compose.yml
```

in the same folder, download one of the following files accordingly to your operating system

- linux:
```
curl https://raw.githubusercontent.com/carlomt/docker-geant4course/main/env_linux --output .env
```
- windows:
```
curl https://raw.githubusercontent.com/carlomt/docker-geant4course/main/env_windows --output .env
```
- mac: 
```
curl https://raw.githubusercontent.com/carlomt/docker-geant4course/main/env_mac --output .env
```

then, to prepare your installation, run:
`docker compose run prepare`

it will create the subfolders, download the Geant4 datasets and source code. Once it has finished, you should see these files and subfolders:
```
 geant4-datasets/
 geant4-source/
 geant4-exercises/
 docker-home/
 docker-compose.yml
```

we suggest you to work in the `geant4-exercises` folder, in the Docker you will find it inside your home
(in the Docker you will be `root`, so your home will be `/root`).
You can edit the file both, from the host operating system and from the Docker.

In `geant4-source` you will have the source code of the last Geant4 version, that directory will also mapped to the Docker in the path
`/usr/local/geant4/geant4-v<GEEANT4 VERSION>`.

The home in the Docker is mapped in the directory `docker-home`, in this way the bash history is persistant and will be kept even if you close and open again the Docker.

## Running 

To start the Geant4 container, execute:
```
docker compose run geant4
```

