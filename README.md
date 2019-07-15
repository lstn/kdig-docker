# kdig-docker

Knot DNS dig command-line tool inside a distroless image.

## Running

```bash
docker run --rm -it lestienne/kdig:latest @1.1.1.1 knot-dns.cz SOA +dnssec
```

Or create an alias:
```bash
echo `alias whois="docker run --rm -it lestienne/kdig:latest" | sudo tee -a ~/.bashrc`
source ~/.bashrc
kdig @1.1.1.1 knot-dns.cz SOA +dnssec
```

## Versions

- `lestienne/kdig:2.7.6`, `lestienne/kdig:2.7.6-2`, `lestienne/kdig:latest`
- `lestienne/kdig:2.4.0`, `lestienne/kdig:2.4.0-3`
