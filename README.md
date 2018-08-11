# PHP image

## Usage

### docker-compose

```yaml
version: '3'

services:
  php:
    image: 'bjouhaud/php'
    hostname: 'php'
    volumes:
      - '.:/app:rw'
      - '~/.composer:/home/dev/.composer:rw'
```
