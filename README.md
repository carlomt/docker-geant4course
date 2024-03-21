# docker-geant4course

Docker multiarch image for Geant4 courses

Once you i
To use it install Docker on your machine (follow that [link](https://docs.docker.com/get-docker/) )

## GUI

To have the graphic user interface you should prepare your operating system host

### Linux
Add local connections to X11 access control list:
```
xhost local:root
```

such a command has to be executed every time you reboot your computer

### Windows
If you don't have X11 already installed (it should be on the latest versions of Windows 11), download XMing from

https://sourceforge.net/projects/xming/

use the Powershell terminal to launch docker compose

### Mac
Install XQuartz

https://www.xquartz.org/

start XQuartz:
```
open -a XQuartz
```

go to XQuartz->Settings and in the `Security` panel enable `Allow connections from network clients`

restart XQuartz:

Check where the XQuartz config file, or domain, is located with:
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
To have GLX acceleration you must enable it with:
```
defaults write org.xquartz.X11 enable_iglx -bool true
```
restart XQuartz again. You can check if GLX is now enabled again with:
```
defaults read org.xquartz.X11
```
Finally, you have to allow X11 forwarding to local containers:
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

In ` geant4-source` you will have the source code of the last Geant4 version, that directory will also mapped to the Docker in the path
`/usr/local/geant4/geant4-v<GEEANT4 VERSION>`.

The home in the Docker is mapped in the directory `docker-home`, in this way the bash history is persistant and will be kept even if you close and open again the Docker.

## Running 

Finally you can run the Geant4 container:
```
docker compose run geant4
```

