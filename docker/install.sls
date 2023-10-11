# Installation for AlmaLinux 9
{%- if grains['os'] == 'AlmaLinux' and grains['osmajorrelease'] == 9 %}
remove_podman_buildah:
  pkg.removed:
    - pkgs:
      - podman
      - buildah

add_docker_repo_almalinux:
  cmd.run:
    - name: 'dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo'
    - unless: 'dnf repolist | grep -q docker-ce-stable'

docker_package:  # Explicit state ID for Docker installation
  pkg.installed:
    - pkgs:
      - docker-ce
      - docker-ce-cli
      - containerd.io
      - docker-compose-plugin
    - refresh: True
    - require:
      - cmd: add_docker_repo_almalinux

docker_service_almalinux:
  service.running:
    - name: docker
    - enable: True
    - require:
      - pkg: docker_package
{%- endif %}

# Installation for Amazon Linux 2
{%- if grains['os'] == 'Amazon' and grains['osmajorrelease'] == 2 %}
amazon_install_docker:
  cmd.run:
    - name: 'amazon-linux-extras install docker -y'
    - creates: /usr/bin/docker

docker_service_amazon:
  service.running:
    - name: docker
    - enable: True
    - require:
      - cmd: amazon_install_docker
{%- endif %}

# Installation for Ubuntu 22.04 and 20.04
{%- if grains['os'] == 'Ubuntu' and grains['osrelease'] in ['22.04', '20.04'] %}
add_docker_gpg_ubuntu:
  cmd.run:
    - name: 'curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -'
    - unless: 'apt-key list | grep -q Docker'

add_docker_repo_ubuntu:
  cmd.run:
    - name: 'add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"'
    - unless: 'cat /etc/apt/sources.list.d/docker.list | grep -q docker.com'
    - require:
      - cmd: add_docker_gpg_ubuntu

docker_package:  # Explicit state ID for Docker installation
  pkg.installed:
    - pkgs:
      - docker-ce
      - docker-ce-cli
      - containerd.io
    - refresh: True
    - require:
      - cmd: add_docker_repo_ubuntu

docker_service_ubuntu:
  service.running:
    - name: docker
    - enable: True
    - require:
      - pkg: docker_package
{%- endif %}