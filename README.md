## docker-readarr
[![docker hub](https://img.shields.io/badge/docker_hub-link-blue?style=for-the-badge&logo=docker)](https://hub.docker.com/repository/docker/vcxpz/readarr) ![docker image size](https://img.shields.io/docker/image-size/vcxpz/readarr?style=for-the-badge&logo=docker) [![auto build](https://img.shields.io/badge/docker_builds-automated-blue?style=for-the-badge&logo=docker?color=d1aa67)](https://github.com/hydazz/docker-readarr/actions?query=workflow%3A"Auto+Builder+CI")

Fork of [linuxserver/docker-readarr](https://github.com/linuxserver/docker-readarr/)

[Radarr](https://readarr.video/) - A fork of Sonarr to work with movies à la Couchpotato.

## Version Information
![alpine](https://img.shields.io/badge/alpine-edge-0D597F?style=for-the-badge&logo=alpine-linux) ![s6 overlay](https://img.shields.io/badge/s6_overlay-2.1.0.2-blue?style=for-the-badge) ![readarr](https://img.shields.io/badge/readarr-3.0.1.4359-blue?style=for-the-badge)

**[See here for a list of packages](https://github.com/hydazz/docker-readarr/blob/main/package_versions.txt)**

## Usage
```
docker run -d \
  --name=readarr \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Australia/Melbourne \
  -e UMASK_SET=022 `#optional` \
  -e DEBUG=true/false `#optional` \
  -p 7878:7878 \
  -v <path to appdata>:/config \
  -v <path to movies>:/movies \
  -v <path to downloads>:/downloads \
  --restart unless-stopped \
  vcxpz/readarr
```
[![template](https://img.shields.io/badge/unraid_template-ff8c2f?style=for-the-badge&logo=docker?color=d1aa67)](https://github.com/hydazz/docker-templates/blob/main/hydaz/readarr.xml)

## New Environment Variables
### Debug
| Name | Description | Default Value |
|-|-|-|
| `DEBUG` | set `true` to display errors in the Docker logs. When set to `false` the Docker log is completely muted. | `false` |

**See other variables on the official [README](https://github.com/linuxserver/docker-readarr/)**

## Upgrading Radarr
To upgrade, all you have to do is pull our latest Docker image. We automatically check for Radarr updates daily so there may be some delay when an update is released to when the image is updated.

## Credits
* [spritsail/readarr](https://github.com/spritsail/readarr) for the `HEALTHCHECK` command
* [hotio](https://github.com/hotio) for the `redirect_cmd` function
