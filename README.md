# Root Directory

This repository serves as a root directory for a setup.

## On non-Linux environments, with VSCode, Vagrant and VirtualBox installed:

(* This step can be skipped in Linux or WSL2 environments)

- Run:

```shell
vagrant up
vagrant ssh-config > ssh_config
```

- In VSCode, execute `Ctrl+Shift+P` -> `Remote-SSH: Open Configuration File...` -> `Settings`.

- In the settings page, paste the full path to the `ssh_config` file generated by `vagrant ssh-config`. _You can right-click the file in the Explorer and choose `Copy Path`._

- In VSCode, execute `Ctrl+Shift+P` -> `Remote-SSH: Connect to Host...` and choose the host of the ssh configuration file you added (`dockerhost` in this case).

- Open the Folder `/lrd` in VSCode inside the VM.

## Prepare the environment

- Run:

```shell
./setup.sh
```

_This will clone the controller (ctl) repository and run the script ./run script there to clone the `env-main` repository (which has the projects that will be used by the controller) and prepare the environment._
