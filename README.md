# unmined-cli

docker image for [unmined](https://unmined.net/) - a minecraft map renderer.

rebuilds weekly to pick up latest releases.

## usage

```bash
docker pull ghcr.io/molnia1311/unmined-cli:latest

docker run --rm \
  -v /path/to/world:/data/world:ro \
  -v /path/to/output:/data/output \
  ghcr.io/molnia1311/unmined-cli:latest \
  web render --world=/data/world --output=/data/output/webmap
```

open `output/webmap/unmined.index.html` in a browser to view the map.

## credits

[unmined](https://unmined.net/) is created by megasys.