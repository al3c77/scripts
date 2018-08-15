#!/bin/sh

# Copyright (c) 2018 Slawomir Wojciech Wojtczak (vermaden)
# All rights reserved.
#
# THIS SOFTWARE USES FREEBSD LICENSE (ALSO KNOWN AS 2-CLAUSE BSD LICENSE)
# https://www.freebsd.org/copyright/freebsd-license.html
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that following conditions are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS 'AS IS' AND ANY
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
# THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# ------------------------------
# DESKTOP BATTERY WARNING
# ------------------------------
# vermaden [AT] interia [DOT] pl
# https://vermaden.wordpress.com

export DISPLAY=:0

export PATH=${PATH}:/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin

# FREEBSD FIRST USES bat1 THEN bat0 SO USING -i 0 IS SUFFICIENT HERE
STATE=$( acpiconf -i 0 | awk '/^Remaining capacity/ { sub(/%/,""); print $3; }' )

case ${STATE} in
  (''|*[!0-9]*)
    exit 0
    ;;
esac

[ ${STATE} -lt 6 ] && [ $( sysctl -n hw.acpi.acline ) -eq 0 ] && {
  zenity --title "WARNING!" \
    --warning \
    --text="BATTERY: 5%" \
    1> /dev/null 2> /dev/null
}

echo '1' >> ~/scripts/stats/${0##*/}
