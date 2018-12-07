# Usage

## clone

git clone https://github.com/Tee0125/docker-acme-challenge.git
git submodule init
git submodule update --recursive

## build

```
docker build . -t acme-challenge
```

## run

```
mkdir dehydrated
docker run \
    -e "CF_EMAIL={cloud flare email} \
    -e "CF_APIKEY={colud flare apikey} \
    -v`pwd`/dehydrated:/var/lib/dehydrated \
    acme-challenge
```
