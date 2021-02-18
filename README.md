## docker-readarr

[![docker hub](https://img.shields.io/badge/docker_hub-link-blue?style=for-the-badge&logo=docker)](https://hub.docker.com/r/vcxpz/readarr) ![docker image size](https://img.shields.io/docker/image-size/vcxpz/readarr?style=for-the-badge&logo=docker) [![auto build](https://img.shields.io/badge/docker_builds-automated-blue?style=for-the-badge&logo=docker?color=d1aa67)](https://github.com/hydazz/docker-readarr/actions?query=workflow%3A"Auto+Builder+CI") [![codacy branch grade](https://img.shields.io/codacy/grade/6df098f605074ee780f9f2fe472b52c4/main?style=for-the-badge&logo=codacy)](https://app.codacy.com/gh/hydazz/docker-readarr)

[Readarr](https://https://readarr.com//) is a ebook (and maybe eventually magazine/audiobook) collection manager for Usenet and BitTorrent users. It can monitor multiple RSS feeds for new books from your favourite authors and will grab, sort and rename them.

## Usage

```bash
docker run -d \
  --name=readarr \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Australia/Melbourne \
  -e DEBUG=true/false #optional \
  -p 8787:8787 \
  -v <path to appdata>:/config \
  -v <path to books>:/books \
  -v <path to downloads>:/downloads \
  --restart unless-stopped \
  vcxpz/readarr
```

[![template](https://img.shields.io/badge/unraid_template-ff8c2f?style=for-the-badge&logo=docker?color=d1aa67)](https://github.com/hydazz/docker-templates/blob/main/hydaz/readarr.xml)

## Upgrading Readarr

To upgrade, all you have to do is pull the latest Docker image. We automatically check for Readarr updates daily so there may be some delay when an update is released to when the image is updated.

## Credits

- [hotio](https://github.com/hotio) for the `redirect_cmd` function

## Fixing Appdata Permissions

If you ever accidentally screw up the permissions on the appdata folder, run `fix-perms` within the container. This will restore most of the files/folders with the correct permissions.
