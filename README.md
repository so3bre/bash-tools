# Bash Tools 🛠️
A collection of modular Bash functions for system package management and security audits.

## Installation
Clone this repository to your home folder:

```bash
git clone https://github.com/so3bre/bash-tools.git && cd bash-tools 
```

## Setup (Recommended)
To load all tools automatically, add this to your ~/.bashrc:

```bash
source ~/bash-tools/load.sh
```
After adding this line, restart your terminal or run source ~/.bashrc.  

## Available Tools
Once loaded, you can use these commands:

* **lic** — Check DNF package licenses (system/RPM packages).
* **flic** — Check Flatpak application licenses from Flathub.
* **bt-help** — Show all available commands and utility information.

## Architecture
This project uses a modular design for easy maintenance:

* **load.sh** — The main entry point that automatically sources all modules.
* **src/00-config.sh** — Global license definitions.
* **src/checkers/** — Modular logic for different package managers.

## Advanced Usage
If you prefer to load specific tools instead of the full suite, you must load the configuration first to define the required variables:

```Bash
# 1. Load the shared config
source ~/bash-tools/src/00-config.sh  

# 2. Then, load any specific module you need
source ~/bash-tools/src/checkers/10-dnf.sh
```  

## License
MIT