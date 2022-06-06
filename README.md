# live-dl

[![Docker Pulls](https://img.shields.io/docker/pulls/sparanoid/live-dl.svg)](https://hub.docker.com/r/sparanoid/live-dl)

Monitor and download live streams from YouTube.

- [Docker Hub](https://hub.docker.com/r/sparanoid/live-dl)
- [ghcr.io](https://github.com/users/sparanoid/packages/container/package/live-dl)

## Features

- Monitor your favorite YouTube channels and download streams when it starts
- Email/Slack notifications when the stream starts or finish downloading
- Writing streamer metadata (author/channel name, description, year) via FFmpeg
- Keywords filter: only download streams that match specific keywords (or regular expressions) in the title
- Download subtitles if available
- Convert TS to MP4 automatically after downloading
- URL guessing: this script will try its best to guess what you pass to it, the following URLs/URIs should all work:
  - https://www.youtube.com/channel/UC1opHUrw8rvnsadT-iGp7Cg/live
  - https://www.youtube.com/channel/UC1opHUrw8rvnsadT-iGp7Cg
  - https://www.youtube.com/watch?v=S3CAGeeMRvo
  - https://www.youtube.com/playlist?list=UU1opHUrw8rvnsadT-iGp7Cg
  - S3CAGeeMRvo
  - UC1opHUrw8rvnsadT-iGp7Cg

## System Requirements

Tested on macOS up to 11.2.3, should be working on Ubuntu and RHEL. Running live-dl inside a container is recommended.

## Available Tags

- `latest`: the latest tagged release
- `nightly`: the nightly build with latest youtube-dl and streamlink bundles

## Run `live-dl` Inside a Container with Docker

The simplest way to use live-dl is executing it inside a container. The following command will print the help message of live-dl:

```bash
docker run --rm -it sparanoid/live-dl:latest
```

Run live-dl in interactive mode:

```bash
docker run --rm -it --init \
  -v $(pwd)/downloads:/app/downloads \
  sparanoid/live-dl:latest \
  'UC1opHUrw8rvnsadT-iGp7Cg'
```

Run live-dl as a Docker daemon:

```bash
docker run --rm -itd --init \
  -v $(pwd)/downloads:/app/downloads \
  sparanoid/live-dl:latest \
  'UC1opHUrw8rvnsadT-iGp7Cg'
```

Run live-dl with host volume mounted:

```bash
# Mount host volume for custom config.yml:
docker run --rm -itd --init \
  -v $(pwd)/downloads:/app/downloads \
  -v $(pwd)/config.yml:/app/config.yml \
  sparanoid/live-dl:latest \
  'UC1opHUrw8rvnsadT-iGp7Cg'

# Mount host volume for custom cookies.txt:
docker run --rm -itd --init \
  -v $(pwd)/downloads:/app/downloads \
  -v $(pwd)/youtube.com_cookies.txt:/app/cookies.txt \
  sparanoid/live-dl:latest \
  'UC1opHUrw8rvnsadT-iGp7Cg'
```

You can extract your current cookies simply via [Get cookies.txt](https://chrome.google.com/webstore/detail/bgaddhkoddajcdgocldbbfleckgcbcid) Google Chrome extension.

## Run `live-dl` with Docker Compose

```yaml
version: '3'

x-defaults: &defaults
  image: sparanoid/live-dl:latest
  restart: always
  volumes:
    - ./config.yml:/app/config.yml
    - ./youtube.com_cookies.txt:/app/cookies.txt
    - ./downloads:/app/downloads

services:
  minatoaqua:
    <<: *defaults
    command: https://www.youtube.com/channel/UC1opHUrw8rvnsadT-iGp7Cg --debug

  uruharushia:
    <<: *defaults
    command: https://www.youtube.com/channel/UCl_gCybOJRIgOXw6Qb4qJzQ --debug
```

## Run `live-dl` Locally

Run `./live-dl` without any parameter to print help message.

You can run this script in background with `nohup`:

```bash
# Start process
nohup bash live-dl https://www.youtube.com/channel/UC1opHUrw8rvnsadT-iGp7Cg &>/tmp/live-dl-minatoaqua.log &

# View processes
ps aux | grep live-dl
501 94552   964   0  9:38PM ttys009    0:00.06 bash live-dl https://www.youtube.com/channel/UC1opHUrw8rvnsadT-iGp7Cg
501 94765   964   0  9:39PM ttys009    0:00.00 grep live-dl

# Stop process
kill 94552
```

## Configurations

All configurations are defined in `config.yml` file. Some options can be overwritten by command line arguments.

Run `./live-dl` without any parameter to print the help message.

## Contributing

It's recommended to use Docker for development and testing. You should simply mount all your files to the container.

```bash
# Method 1: Use compose file
docker compose up [--build]

# Method 2: Use Dockerfile
docker build -t sparanoid/live-dl:local .
docker run -it -v $(pwd):/app sparanoid/live-dl:local
```

If you'd like to run it locally. You need to install all the dependencies defined in `live-dl`.

## License

AGPL-3.0
