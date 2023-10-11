# Docker Formula

This SaltStack formula provides an automated solution to install Docker on various Linux distributions and manage a dedicated `docker` user and group. Please ignore timestamps of code being uploaded. I schedule code pushes quite often. If you find this to be a pain, use checkout tags that I will be including.

## Supported Distributions

- AlmaLinux 9
- Amazon Linux 2
- Ubuntu 22.04
- Ubuntu 20.04

## Structure

- `docker/init.sls`: Main entry point.
- `docker/install.sls`: Handles the installation of Docker based on the operating system.
- `docker/usergroup.sls`: Manages the `docker` user and group, ensuring the user is a member of the group.

## Local Usage

1. **Clone the repository:**

```git clone https://github.com/jarildson/docker-formula.git```

2. **Navigate to the directory:**

```cd docker-formula```

3. **Apply the state:**

```salt-call --local state.apply docker```


## Features

- Detects the specific OS and version for targeted installations.
- Removes potential conflicting packages like `podman` and `buildah` for AlmaLinux 9.
- Adds the required Docker repositories based on the OS.
- Installs Docker, ensuring the service is running post-installation.
- Creates a `docker` user and group. The user is only created after a successful Docker installation.

## Notes

- Granting a user access to the `docker` group provides them the ability to manage Docker. This comes with potential security implications; ensure you understand the risks in your specific environment.
- Always test new changes in a safe, non-production environment before rolling them out broadly.

## Contributing

Contributions are welcome! Please submit Pull Requests or create issues for any enhancements, bug fixes, or discussions.
