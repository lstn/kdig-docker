FROM debian:stretch-20190708 as kdig-builder

ENV KNOT_DNSUTILS_VERSION=2.7.6-2~bpo9+1

RUN echo deb http://http.debian.net/debian stretch-backports main contrib non-free | \ 
    tee /etc/apt/sources.list.d/stretch-backports.list && \
    apt-get update -qq && apt-get install -y knot-dnsutils=$KNOT_DNSUTILS_VERSION

#RUN readelf -d /usr/bin/kdig  | grep 'NEEDED'

FROM gcr.io/distroless/base

COPY --from=kdig-builder /usr/bin/kdig /usr/bin/kdig
COPY --from=kdig-builder ["/lib/x86_64-linux-gnu/libc*", \
         "/lib/x86_64-linux-gnu/libpthread*", \ 
         "/lib/x86_64-linux-gnu/libidn*", \
         "/lib/x86_64-linux-gnu/libz*", \
         "/lib/x86_64-linux-gnu/"]

COPY --from=kdig-builder ["/usr/lib/x86_64-linux-gnu/libgnutls*", \
         "/usr/lib/x86_64-linux-gnu/libdnssec*", \
         "/usr/lib/x86_64-linux-gnu/libknot*", \
         "/usr/lib/x86_64-linux-gnu/liblmdb*", \
         "/usr/lib/x86_64-linux-gnu/libatomic*", \
         "/usr/lib/x86_64-linux-gnu/libnettle*", \
         "/usr/lib/x86_64-linux-gnu/libjansson*", \
         "/usr/lib/x86_64-linux-gnu/libp11-kit*", \
         "/usr/lib/x86_64-linux-gnu/libtasn1*", \
         "/usr/lib/x86_64-linux-gnu/libhogweed*", \
         "/usr/lib/x86_64-linux-gnu/libgmp*", \
         "/usr/lib/x86_64-linux-gnu/libffi*", \
         "/usr/lib/x86_64-linux-gnu/libfstrm*", \
         "/usr/lib/x86_64-linux-gnu/libprotobuf-c*", \
         "/usr/lib/x86_64-linux-gnu/"]


ENTRYPOINT ["/usr/bin/kdig"]
CMD ["--help"]

