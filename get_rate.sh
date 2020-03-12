#!/bin/bash
read -r -d '' source << EOM
var system = require('system');
var page = require('webpage').create();

var url = system.args[1];
var destination = system.args[2];

page.settings.resourceTimeout = 1000;

setTimeout(function(){
    setInterval(function () {
var fs = require('fs');
var page = require('webpage').create();
page.open(url, function () {
    console.log(page.content);
try {
    fs.write(destination, page.content, 'w');
    } catch(e) {
        console.log(e);
    }
    phantom.exit();
});
    }, 2000);
}, 1);
EOM
echo $source > save.js
function finish {
    rm -f save.js page.html temp.txt 2>/dev/null
}
trap finish EXIT
export PATH="${PATH}:/home/justa/dev/go/bin:/usr/local/bin:/usr/bin:/usr/sbin:/bin"
rate=`phantomjs save.js https://www.walutomat.pl page.html 1>/dev/null 2>/dev/null && cat page.html | pup '.USD_PLN .buy' | head -n 2 | tail -n 1 | awk '{$1=$1};1'`
if [ -z "${rate}" ]
then
  echo "$0: error getting USD/PLN rate"
  exit 1
fi
MAIL_TO=lukaszgryglicki@o2.pl
echo "USD/PLN: ${rate}"
host=`hostname`
echo "From: usd_pln_rate_$$@${host}" > temp.txt
echo "To: ${MAIL_TO}" >> temp.txt
echo "Subject: USD/PLN rate ${rate}" >> temp.txt
echo '' >> temp.txt
echo "USD/PLN: ${rate}" >> temp.txt
sendmail $MAIL_TO < temp.txt
