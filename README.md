# udp-log-receiver

Swift command line tool for receiving udp log output.

## Motivation

I'm doing most of my daily development work with Xcode. For several years now, the builtin iOS simulators have been so
_chatty_ that it's almost impossible to use anything that prints to the Xcode console, i.e. `os_log`, `print`, or similar
devices.

Moreover, due to screen size constraints, I often find the need to see log output on another computer. And while we're there,
how about colors?

## How to install

(to be written)

## How to use

### On the sender

Dump clear text debug output to the receiver's IP address. Choose a port of your liking and transmit.
If you're using the [CornucopiaCore](https://github.com/Cornucopia-Swift/CornucopiaCore) logger, it's as easy as setting
the `LOGSINK` environment variable, e.g.:
```sh
export LOGLEVEL=TRACE LOGINSK=192.168.1.27:5514
```

### On the receiver

Run `upd-log-receiver`. By default it is configured to listen to port `5514`.
