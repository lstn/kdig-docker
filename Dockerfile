FROM cznic/knot:2.7 as kdig-builder

RUN apt-get update -qq && apt-get install -y binutils
RUN which kdig
RUN readelf -d /bin/kdig  | grep 'NEEDED'

FROM gcr.io/distroless/base

COPY --from=kdig-builder /bin/kdig /bin/kdig
COPY --from=kdig-builder ["/lib/x86_64-linux-gnu/libc*", \
         "/lib/x86_64-linux-gnu/libtinfo*", \
         "/lib/x86_64-linux-gnu/libpthread*", \ 
         "/lib/x86_64-linux-gnu/libidn*", \
         "/lib/x86_64-linux-gnu/libm.*", \  
         "/lib/x86_64-linux-gnu/liblmdb*", \
         "/lib/x86_64-linux-gnu/libbsd*", \
         "/lib/x86_64-linux-gnu/libncurses*", \
         "/lib/x86_64-linux-gnu/libz*", \
         "/lib/x86_64-linux-gnu/"]
COPY --from=kdig-builder ["/lib/libdnssec*", \
         "/lib/libknot*", \
         "/lib/"]

COPY --from=kdig-builder ["/usr/lib/x86_64-linux-gnu/liblmdb*", \
         "/usr/lib/x86_64-linux-gnu/libgnutls*", \
         "/usr/lib/x86_64-linux-gnu/libedit*", \
         "/usr/lib/x86_64-linux-gnu/libp11-kit*", \
         "/usr/lib/x86_64-linux-gnu/libtasn1*", \
         "/usr/lib/x86_64-linux-gnu/libnettle*", \
         "/usr/lib/x86_64-linux-gnu/libhogweed*", \
         "/usr/lib/x86_64-linux-gnu/libgmp*", \
         "/usr/lib/x86_64-linux-gnu/libffi*", \
         "/usr/lib/x86_64-linux-gnu/"]

ENTRYPOINT ["/bin/kdig"]
CMD ["--help"]

############  0x0000000000000001 (NEEDED)             Shared library: [libbsd.so.0]
#############  0x0000000000000001 (NEEDED)             Shared library: [libc.so.6]
###########  0x0000000000000001 (NEEDED)             Shared library: [libdnssec.so.6]
####################  0x0000000000000001 (NEEDED)             Shared library: [libedit.so.2]
###########  0x0000000000000001 (NEEDED)             Shared library: [libgnutls.so.30]
#################  0x0000000000000001 (NEEDED)             Shared library: [libknot.so.8]
##############  0x0000000000000001 (NEEDED)             Shared library: [liblmdb.so.0]
###############  0x0000000000000001 (NEEDED)             Shared library: [libpthread.so.0]
###########  0x0000000000000001 (NEEDED)             Shared library: [libm.so.6]
# ######## 0x0000000000000001 (NEEDED)             Shared library: [libidn.so.11]
#  0x0000000000000001 (NEEDED)             Shared library: [libncurses.so.5]
#$$$$$  0x0000000000000001 (NEEDED)             Shared library: [libtinfo.so.5]


