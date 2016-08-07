# SteamCache

A docker container for running a Steam downloads caching service.
Designed to be used alongside other docker containers on the same
machine.

## Usage

Build the image:

`docker build -t outlaw11a/steamcache .`

Start the SteamCache container (Don't forget the directory for storing
the cached files):

`docker run -dt -v /cache/:/var/www/ outlaw11a/steamcache`

Get the private IP from the container:

`docker inspect .....`

Start any containers that you want to make use of the cache with the DNS
flag set to the cache's private IP:

`docker run --dns=.....`