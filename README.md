# Live Downloader

Download live streams from YouTube.

## Features

- URL guessing: this script will try it best to guess what you pass to it, the following URLs/URIs should all work:
  - https://www.youtube.com/channel/UC1opHUrw8rvnsadT-iGp7Cg/live
  - https://www.youtube.com/channel/UC1opHUrw8rvnsadT-iGp7Cg
  - https://www.youtube.com/watch?v=S3CAGeeMRvo
  - https://www.youtube.com/playlist?list=UU1opHUrw8rvnsadT-iGp7Cg
  - S3CAGeeMRvo
  - UC1opHUrw8rvnsadT-iGp7Cg
- Monitor your favorite YouTube channel and download streams when live starts
- Email/Slack notifications when stream starts or finish downloading
- Writing streamer metadata (author/channel name, description, year) via FFmpeg
- Embed YouTube thumbnail as video cover via ~~AtomicParsley~~ (now handled by FFmpeg)
- Download subtitles if available
- Keywords filter: only download streams that match specific keywords (or regular expressions) in title
- Convert TS to MP4 after downloading

## Dependencies

- aria2c
- bash
- exiv2
- ffmpeg
- jq
- streamlink
- youtube-dl
- yq (python-yq)

Tested on macOS 10.15, should be working on RHEL/CentOS 7 and Ubuntu.

## Usage

Run `./live-dl` without any parameter to print help message.

You can run this script in background:

```shell
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
