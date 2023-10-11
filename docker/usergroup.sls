docker_group:
  group.present:
    - name: docker
    - onchanges:
      - pkg: docker_package  # Execute only if Docker was installed or changed

docker_user:
  user.present:
    - name: docker
    - groups:
      - docker
    - require:
      - group: docker_group
    - onchanges:
      - pkg: docker_package  # Execute only if Docker was installed or changed
