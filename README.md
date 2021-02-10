# cUrl build

To decrease image size: [Alpine Linux](https://www.alpinelinux.org) was used. 

cUrl has documentation on [dependencies](https://curl.se/docs/libs.html) and [installation instruction](https://curl.se/docs/install.html). 


## Getting latest version from git

Please note that in this particular case I am relying on `sort` and [version sort](https://www.gnu.org/software/coreutils/manual/html_node/Version-sort-is-not-the-same-as-numeric-sort.html) to grab latest tag info like `0a9a82d8a6d9cd42389569751fa22ad9f14a3320	refs/tags/curl-7_75_0` to split it with `cut` and get latest tag. 
```
# for git <=2.14
git \
	ls-remote \
	--refs \
	--tags https://github.com/curl/curl curl-\* | sort -t '/' -k 3 -V | tail -n1 | cut --delimiter='/' --fields=3
```

For newer version of git this approach is also suites purpose. 
```bash
# for git older than 2.14
git \
	-c 'versionsort.suffix=-' \
	ls-remote \
	--tags \
	--sort='v:refname' \
	https://github.com/curl/curl \
	curl-\* | tail --lines 1  | cut --delimiter='/' --fields=3 | tr -d '^{}'
```

## cUrl build

Git build based on [autotools](https://www.lrde.epita.fr/~adl/dl/autotools.pdf). 
To decrease binary size I am using static build and `strip` to remove unnecessary information from strippable files.

#### Notes 

1. [Issues · curl/curl-docker · GitHub](https://github.com/curl/curl-docker/issues)
2. [Docker Hub curlimage - 11.1MB](https://hub.docker.com/r/curlimages/curl)
3. [Docker: Use multi-stage builds | Docker Documentation](https://docs.docker.com/develop/develop-images/multistage-build/)
4. [Alpine Linux](https://www.alpinelinux.org)
5. [cUrl dependencies](https://curl.se/docs/libs.html)
6. [cUrl installation instruction](https://curl.se/docs/install.html)