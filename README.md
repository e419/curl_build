# Curl docker image

[Installation instruction](https://curl.se/docs/install.html)
[cUrl dependencies](https://curl.se/docs/libs.html)

## Getting latest version from git

```bash
git \
	-c 'versionsort.suffix=-' \
	ls-remote \
	--tags \
	--sort='v:refname' \
	https://github.com/curl/curl \
	curl-\* | tail --lines 1  | cut --delimiter='/' --fields=3 | tr -d '^{}'
```

