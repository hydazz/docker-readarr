ARG TAG
FROM vcxpz/baseimage-alpine-arr:${TAG}

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Readarr version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="hydaz"

# environment settings
ARG BRANCH

RUN \
   echo "**** install build packages ****" && \
   apk add --no-cache --virtual=build-dependencies \
     curl && \
   echo "**** install fpcalc ****" && \
   curl --silent -o \
     /tmp/fpcalc.tar.gz -L \
     "https://github.com/acoustid/chromaprint/releases/download/v1.5.0/chromaprint-fpcalc-1.5.0-linux-x86_64.tar.gz" && \
   tar xzf \
     /tmp/fpcalc.tar.gz -C \
     /tmp/ --strip-components=2 && \
   mv /tmp/fpcalc /usr/local/bin && \
   echo "**** install readarr ****" && \
   mkdir -p /app/readarr/bin && \
   ARCH=$(curl -sSL https://raw.githubusercontent.com/hydazz/scripts/main/docker/archer.sh | bash) && \
   curl --silent -o \
     /tmp/readarr.tar.gz -L \
     "https://readarr.servarr.com/v1/update/${BRANCH}/updatefile?version=${VERSION}&os=linuxmusl&runtime=netcore&arch=${ARCH}" && \
   tar xzf \
     /tmp/readarr.tar.gz -C \
     /app/readarr/bin --strip-components=1 && \
   printf "UpdateMethod=docker\nBranch=${BRANCH}\n" > /app/readarr/package_info && \
   echo "**** cleanup ****" && \
   apk del --purge \
     build-dependencies && \
   rm -rf \
     /app/readarr/bin/Readarr.Update \
     /tmp/*

# copy local files
COPY root/ /

# readarr healthcheck
HEALTHCHECK --start-period=10s --timeout=5s \
   CMD wget -qO /dev/null 'http://localhost:8787/api/system/status' \
     --header "x-api-key: $(xmlstarlet sel -t -v '/Config/ApiKey' /config/config.xml)"

# ports and volumes
EXPOSE 8787
VOLUME /config
