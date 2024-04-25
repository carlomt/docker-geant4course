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


## Preparing the Installation

### 1 Create a folder
First, you need to create a dedicated folder for the course materials on your computer. 
After creating this folder, navigate into it using the command line or PowerShell (Windows) with the `cd` command.

### 2 Downloading Required Files
Within this folder, download the necessary Docker configuration and environment setup files. The commands to download these files vary depending on your operating system:

#### For Linux and macOS 
Use the `curl` command with the `--output` option to specify the filename for the downloaded file.
- To download docker-compose.yml:
```bash
curl https://raw.githubusercontent.com/carlomt/docker-geant4course/main/docker-compose.yml --output docker-compose.yml
```
- To download the environment file for Linux:
```bash
curl https://raw.githubusercontent.com/carlomt/docker-geant4course/main/env_linux --output .env
```
- To download the environment file for macOS:
```bash
curl https://raw.githubusercontent.com/carlomt/docker-geant4course/main/env_mac --output .env
```

#### For Windows (PowerShell) 
Use Invoke-WebRequest with the -Uri parameter for the URL and -OutFile to specify the output file name.
- To download docker-compose.yml:
```powershell
Invoke-WebRequest -Uri https://raw.githubusercontent.com/carlomt/docker-geant4course/main/docker-compose.yml -OutFile docker-compose.yml
```
To download the environment file for Windows:
```powershell
Invoke-WebRequest -Uri https://raw.githubusercontent.com/carlomt/docker-geant4course/main/env_windows -OutFile .env
```

### 3 Preparing the Installation
After downloading the necessary files, you can prepare your environment by running the following Docker command:
```
docker compose run prepare
```

This step initializes the environment by creating required subfolders, downloading Geant4 datasets and the source code. Once completed, you should have the following structure in your folder:
```
geant4-datasets/
geant4-source/
geant4-exercises/
docker-home/
docker-compose.yml
```

It is recommended to work within the `geant4-exercises` folder. This folder, along with others, is mapped inside the Docker container for easy access.
The `geant4-source` folder contains the source code for the latest Geant4 version and is accessible within the Docker container at `/usr/local/geant4/geant4-v<GEEANT4 VERSION>`.
The Docker container's home directory is mapped to the docker-home folder on your host machine, ensuring that your bash history remains persistent across Docker sessions.

## Running 

To start working with the Geant4 environment in Docker, run:
```
docker compose run geant4
```

This command launches the Docker container with the Geant4 environment set up, allowing you to begin the course exercises or development work.

Remember, these instructions are tailored to the specific setup described in the repository provided, and slight variations may be necessary depending on updates or changes to the repository or Docker configurations and could be needed to adapt the commands to the host environment.

## Testing
To ensure everything is functioning correctly, you can:

- Verify that the forwarding of X11 is operational by executing this command from the directory where you stored the course materials:
```
docker compose run xeyes
```
You should see a pair of eyes following the mouse pointer.

- Confirm that 3D graphics acceleration is working with:
```
docker compose run gears
```
You should observe 3D gears in motion.

- Check if a Geant4 example compiles and displays its GUI by running:
```
docker compose run test
```
The Geant4 GUI should appear.

## Issues
If you see the Geant4 window but you don't see the geometry of your simulation it means you don't have 3D acceleration properly working. 
If you have a macOS host, check if you enabled `iglx`. 
If you have a linux host edit the file
 `/etc/X11/xorg.conf` adding the following lines:
```
Section "ServerFlags"  
    Option "AllowIndirectGLX" "on"  
    Option "IndirectGLX" "on"  
EndSection
```
