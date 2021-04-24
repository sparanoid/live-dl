[![Docker Pulls](https://img.shields.io/docker/pulls/sparanoid/live-dl.svg)](https://hub.docker.com/r/sparanoid/live-dl)

# Live Downloader

Monitor and download live streams from YouTube.

## Features

- URL guessing: this script will try its best to guess what you pass to it, the following URLs/URIs should all work:
  - https://www.youtube.com/channel/UC1opHUrw8rvnsadT-iGp7Cg/live
  - https://www.youtube.com/channel/UC1opHUrw8rvnsadT-iGp7Cg
  - https://www.youtube.com/watch?v=S3CAGeeMRvo
  - https://www.youtube.com/playlist?list=UU1opHUrw8rvnsadT-iGp7Cg
  - S3CAGeeMRvo
  - UC1opHUrw8rvnsadT-iGp7Cg
- Monitor your favorite YouTube channels and download streams when it starts
- Email/Slack notifications when the stream starts or finish downloading
- Writing streamer metadata (author/channel name, description, year) via FFmpeg
- Embed YouTube thumbnail as video cover via ~~AtomicParsley~~ (now handled by FFmpeg)
- Keywords filter: only download streams that match specific keywords (or regular expressions) in the title
- Download subtitles if available
- Convert TS to MP4 automatically after downloading

## System Requirements

Tested on macOS up to 11.2.3, should be working on Ubuntu and RHEL. Running live-dl inside a container is recommended.

## Run `live-dl` Inside a Container with Docker

The simplest way to use live-dl is executing it inside a container. The following command will print the help message of live-dl:

```bash
docker run --rm -it sparanoid/live-dl:latest
```

Run live-dl in interactive mode:

```bash
docker run --rm -it \
  sparanoid/live-dl:latest \
  'UC1opHUrw8rvnsadT-iGp7Cg'
```

Run live-dl as a Docker daemon:

```bash
docker run --rm -itd \
  sparanoid/live-dl:latest \
  'UC1opHUrw8rvnsadT-iGp7Cg'
```

Run live-dl with host volume mounted:

```bash
# Mount host volume for download directory:
docker run --rm -itd \
  -v $(pwd)/downloads:/opt/live-dl/downloads \
  sparanoid/live-dl:latest \
  'UC1opHUrw8rvnsadT-iGp7Cg'

# Mount host volume for custom config.yml:
docker run --rm -itd \
  -v $(pwd)/config.yml:/opt/live-dl/config.yml \
  sparanoid/live-dl:latest \
  'UC1opHUrw8rvnsadT-iGp7Cg'

# Mount host volume for custom cookies.txt:
docker run --rm -itd \
  -v $(pwd)/youtube.com_cookies.txt:/opt/live-dl/cookies.txt \
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
    - ./config.yml:/opt/live-dl/config.yml
    - ./youtube.com_cookies.txt:/opt/live-dl/cookies.txt
    - ./downloads:/opt/live-dl/downloads

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

## License

AGPL-3.0
