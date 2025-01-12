FROM alpine:3.20

LABEL maintainer="braccae <braccae@ghomelabb.cc>"

# Build arguments
ARG ARIANG_VERSION=1.1.1

# Install required packages
RUN apk add --no-cache \
    aria2 \
    darkhttpd

# Set up working directories
RUN mkdir -p /aria2/conf /aria2/conf-temp /aria2/downloads /aria-ng

# Download and install AriaNg
RUN wget --no-check-certificate https://github.com/mayswind/AriaNg/releases/download/${ARIANG_VERSION}/AriaNg-${ARIANG_VERSION}.zip \
    && unzip AriaNg-${ARIANG_VERSION}.zip -d /aria-ng \
    && rm -f AriaNg-${ARIANG_VERSION}.zip

# Copy configuration files
COPY conf-temp /aria2/conf-temp/
COPY init.sh /aria2/init.sh
RUN chmod +x /aria2/init.sh

WORKDIR /
VOLUME ["/aria2/conf", "/aria2/downloads"]
EXPOSE 6800 80 8080

CMD ["/aria2/init.sh"]
