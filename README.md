# Multi-arch image CI

One image tag contains `linux/amd64` and `linux/arm64`. Each node pulls the variant that matches its CPU.

The node OS image and the instance type fix that CPU. An amd64 node runs an amd64 image. An arm64 node, such as a Graviton instance, runs an arm64 image. The other variant fails at start with `exec format error`, because the kernel runs the container binary on that CPU.

## Pipeline

`gitci.yaml` is cloud-agnostic. The registry, the runners, and the cluster can sit anywhere.

Set these CI/CD variables:

- `REGISTRY`
- `IMAGE`
- `REGISTRY_USER`
- `REGISTRY_PASSWORD`

Point `IMAGE` at any OCI registry. Tag the runners `linux-amd64` and `linux-arm64` so each build job runs on a machine of that CPU. In GitLab, set the CI/CD configuration file path to `gitci.yaml`.

The manifest job publishes one tag from the two pushed variants. `docker buildx imagetools inspect` should list both platforms.

`TARGETARCH` in the Dockerfile is set by BuildKit to `amd64` or `arm64`. Use it when a build step downloads a binary. A base image must already publish both platforms.
