# email-usd-pln-rate

Get USD/PLN walutomat.pl exchange rate using phantomjs/pup and send periodic email using cronjob/sendmail


# Requirements

- Linux (other OSes may work too, never tested).
- [phantomjs](https://gist.github.com/julionc/7476620) - headless [version](https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2) not requiring X server.
- [pup](https://github.com/ericchiang/pup): `go get github.com/ericchiang/pup`.
- Installed & configured `sendmail`.

# Run

- `./get_rate.sh`.

# Cronjob

- `cp get_rate.sh /usr/local/bin`.
- Copy `get_rate.crontab` file then edit crontab via `crontab -e` and paste contents.

