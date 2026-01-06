# HAProxy (Community) Docker Images with QUIC/HTTP3 & AWS-LC support

These images are derived from [haproxytech/haproxy-docker-debian-quic](https://github.com/haproxytech/haproxy-docker-debian-quic) and [haproxytech/haproxy-docker-alpine-quic](https://github.com/haproxytech/haproxy-docker-alpine-quic).

**Changes**:

* The `dataplaneapi` was stripped.
* Compiling HAProxy was moved to a dedicated build-stage
* [AWS-LC](https://github.com/aws/aws-lc) or OpenSSL as cryptographic library | See: [HAProxy Blog](https://www.haproxy.com/blog/state-of-ssl-stacks)

## Pull

[Docker Hub](https://hub.docker.com/r/oxlorg/haproxy)

* `docker image pull oxlorg/haproxy:debian-quic` | Last version with AWS-LC
* `docker image pull oxlorg/haproxy:${VERSION}-debian-quic-awslc`
* `docker image pull oxlorg/haproxy:${VERSION}-debian-quic-openssl`

Alpine will be added later on.

It might take a while for me to add new versions or re-build existing ones. You can notify me by opening an issue or [sending an email](mailto:contact+haproxy@oxl.at)

## Build

* Build it: `bash scripts/build.sh 3.2 debian`
* Add your overrides - for an example see: `Dockerfile_overrides`

  ```
  docker build -f Dockerfile_overrides -t 'haproxy-custom:3.2-quic' --network=host --no-cache .
  ```

* Test it: `docker run --rm --network=host -it --name haproxy haproxy-custom:3.2-quic`

## Testing

See: `bash scripts/test.sh`
