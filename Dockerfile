FROM debian:buster-slim

LABEL maintainer "Chaojun Tan <https://github.com/tcjj3>"

RUN export DIR_TMP="$(mktemp -d)" \
  && cd ${DIR_TMP} \
  && sed -i "s/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list \
  && sed -i "s/security.debian.org/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list \
  && apt-get update \
  || echo "continue..." \
  && apt-get install --no-install-recommends -y wget \
                                                ca-certificates \
                                                curl \
                                                kmod \
                                                procps \
                                                psmisc \
                                                net-tools \
  && if [ "$(dpkg --print-architecture)" = "amd64" ]; then \
        ARCH="x86_64"; \
     else \
        ARCH=$(dpkg --print-architecture); \
     fi \
  && cd ${DIR_TMP} \
  && curl -fsSL https://www.virtualhere.com/sites/default/files/usbclient/vhclient${ARCH} -o /usr/local/bin/vhclient${ARCH} \
  && chmod +x /usr/local/bin/vhclient${ARCH} \
  && ln -s vhclient${ARCH} /usr/local/bin/vhclient \
  && ln -s /usr/local/bin/vhclient${ARCH} /vhclient${ARCH} \
  && ln -s vhclient${ARCH} /vhclient \
  && rm -rf ${DIR_TMP}











