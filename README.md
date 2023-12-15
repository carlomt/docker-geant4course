# docker-alghero

you can download these containers with:
```
docker pull carlomt/alghero-geant4:latest
```

## Compose

To simplify the use of these images we developed a Docker Compose file, to use it donwload it to a folder from

https://raw.githubusercontent.com/carlomt/docker-alghero/main/docker-compose.yml

if you want to use curl from the terminal:
```
curl https://raw.githubusercontent.com/carlomt/docker-alghero/main/docker-compose.yml --output docker-compose.yml
```

in the same folder, download one of the following files accordingly to your operating system
- https://raw.githubusercontent.com/carlomt/docker-alghero/main/env_linux
- https://raw.githubusercontent.com/carlomt/docker-alghero/main/env_windows
- https://raw.githubusercontent.com/carlomt/docker-alghero/main/env_mac
and rename it .env :

`mv env_<YOU_OPERATING_SYSTEM> .env`
or, using curl (run only one of these commands, accordingly to your operating system):

- linux:
```
curl https://raw.githubusercontent.com/carlomt/docker-alghero/main/env_linux --output .env
```
- windows:
```
curl https://raw.githubusercontent.com/carlomt/docker-alghero/main/env_windows --output .env
```
- mac: 
```
curl https://raw.githubusercontent.com/carlomt/docker-alghero/main/env_mac --output .env
```

run:
`docker compose run prepare`

it will create the subfolders, download the Geant4 datasets and source code. Once it has finished, you can run the Geant4 container:

`docker compose run geant4`

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


## Jupyter

to run jupyter:
```
docker compose run --service-ports jupyter
```
