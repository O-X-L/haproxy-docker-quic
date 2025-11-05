# HAProxy (Community) Docker Images with QUIC/HTTP3 & AWS-LC support

These images are derived from [haproxytech/haproxy-docker-debian-quic](https://github.com/haproxytech/haproxy-docker-debian-quic) and [haproxytech/haproxy-docker-alpine-quic](https://github.com/haproxytech/haproxy-docker-alpine-quic).

**Changes**:

* The `dataplaneapi` was stripped.
* Compiling HAProxy was moved to a dedicated build-stage
* AWS-LC or OpenSSL

## Pull

[Docker Hub](https://hub.docker.com/r/oxlorg/haproxy)

* `docker image pull oxlorg/haproxy:debian-quic-latest` | Last version with AWS-LC
* `docker image pull oxlorg/haproxy:debian-quic-${VERSION}-awslc` | See: [AWS-LC cryptographic library](https://github.com/aws/aws-lc) & [HAProxy Blog](https://www.haproxy.com/blog/state-of-ssl-stacks)
* `docker image pull oxlorg/haproxy:debian-quic-${VERSION}-openssl`

Alpine will be added later on.

It might take a while for me to add new versions or re-build existing ones. You can notify me by opening an issue or [sending an email](mailto:contact+haproxy@oxl.at)

## Build

* Build it: `bash scripts/build.sh 3.2 debian`
* Add your overrides - for an example see: `Dockerfile_overrides`
* Test it: `docker run --rm --network=host -it --name haproxy-local haproxy:3.2-quic`

## Testing

See: `bash scripts/test.sh`
