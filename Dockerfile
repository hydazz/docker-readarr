FROM vcxpz/baseimage-alpine-arr:latest

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Readarr version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="hydaz"
ARG CHROMAPRINT_VERSION="1.5.0"

# environment settings
ARG BRANCH

RUN \
	echo "**** install build packages ****" && \
	apk add --no-cache --virtual=build-dependencies \
		curl && \
	echo "**** install fpcalc ****" && \
	curl --silent -o \
		/tmp/fpcalc.tar.gz -L \
		"https://github.com/acoustid/chromaprint/releases/download/v${CHROMAPRINT_VERSION}/chromaprint-fpcalc-${CHROMAPRINT_VERSION}-linux-x86_64.tar.gz" && \
	tar xzf \
		/tmp/fpcalc.tar.gz -C \
		/tmp/ --strip-components=2 && \
	mv /tmp/fpcalc /usr/local/bin && \
	echo "**** install readarr ****" && \
	if [ -z ${VERSION+x} ]; then \
		VERSION=$(curl -sL "https://readarr.servarr.com/v1/update/nightly/changes?os=linuxmusl" | jq -r ".[0].version"); \
	fi && \
	mkdir -p /app/readarr/bin && \
	ARCH=$(curl -sSL https://raw.githubusercontent.com/hydazz/docker-utils/main/docker/archer.sh | bash) && \
	curl --silent -o \
		/tmp/readarr.tar.gz -L \
		"https://readarr.servarr.com/v1/update/${BRANCH}/updatefile?version=${VERSION}&os=linuxmusl&runtime=netcore&arch=${ARCH}" && \
	tar xzf \
		/tmp/readarr.tar.gz -C \
		/app/readarr/bin --strip-components=1 && \
	printf "UpdateMethod=docker\nBranch=${BRANCH}\n" >/app/readarr/package_info && \
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
	CMD wget -qO /dev/null 'http://localhost:8787/api/v1/system/status' \
	--header "x-api-key: $(xmlstarlet sel -t -v '/Config/ApiKey' /config/config.xml)"

# ports and volumes
EXPOSE 8787
VOLUME /config
