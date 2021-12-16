FROM python:3.8.5-alpine

RUN apk update -f \
    && apk add --no-cache -f \
    bash \
    curl \
    # coreutils used by numfmt
    coreutils \
    # gcc and libc-dev used by streamlink
    gcc \
    libc-dev \
    libxml2-dev \
    libxslt-dev \
    openssl \
    perl \
    aria2 \
    exiv2 \
    ffmpeg \
    jq \
    && rm -rf /var/cache/apk/*

RUN pip install --no-cache-dir --upgrade streamlink yq yt-dlp

COPY ./live-dl /app/
COPY ./config.example.yml /app/config.yml
RUN chmod a+x /app/live-dl

VOLUME /app/

ENTRYPOINT ["/app/live-dl"]
