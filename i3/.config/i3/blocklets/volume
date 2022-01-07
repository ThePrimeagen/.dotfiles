#!/usr/bin/env bash
# Copyright (C) 2014 Julien Bonjean <julien@bonjean.info>
# Copyright (C) 2014 Alexander Keller <github@nycroth.com>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

#------------------------------------------------------------------------

# The second parameter overrides the mixer selection
# For PulseAudio users, eventually use "pulse"
# For Jack/Jack2 users, use "jackplug"
# For ALSA users, you may use "default" for your primary card
# or you may use hw:# where # is the number of the card desired
if [[ -z "$MIXER" ]] ; then
    MIXER="default"
    if command -v pulseaudio >/dev/null 2>&1 && pulseaudio --check ; then
        # pulseaudio is running, but not all installations use "pulse"
        if amixer -D pulse info >/dev/null 2>&1 ; then
            MIXER="pulse"
        fi
    fi
    [ -n "$(lsmod | grep jack)" ] && MIXER="jackplug"
    MIXER="${2:-$MIXER}"
fi

# The instance option sets the control to report and configure
# This defaults to the first control of your selected mixer
# For a list of the available, use `amixer -D $Your_Mixer scontrols`
if [[ -z "$SCONTROL" ]] ; then
    SCONTROL="${BLOCK_INSTANCE:-$(amixer -D $MIXER scontrols |
                      sed -n "s/Simple mixer control '\([^']*\)',0/\1/p" |
                      head -n1
                    )}"
fi

# The first parameter sets the step to change the volume by (and units to display)
# This may be in in % or dB (eg. 5% or 3dB)
if [[ -z "$STEP" ]] ; then
    STEP="${1:-5%}"
fi

# AMIXER(1):
# "Use the mapped volume for evaluating the percentage representation like alsamixer, to be
# more natural for human ear."
NATURAL_MAPPING=${NATURAL_MAPPING:-0}
if [[ "$NATURAL_MAPPING" != "0" ]] ; then
    AMIXER_PARAMS="-M"
fi

#------------------------------------------------------------------------

capability() { # Return "Capture" if the device is a capture device
  amixer $AMIXER_PARAMS -D $MIXER get $SCONTROL |
    sed -n "s/  Capabilities:.*cvolume.*/Capture/p"
}

volume() {
  amixer $AMIXER_PARAMS -D $MIXER get $SCONTROL $(capability)
}

format() {
  
  perl_filter='if (/.*\[(\d+%)\] (\[(-?\d+.\d+dB)\] )?\[(on|off)\]/)'
  perl_filter+='{CORE::say $4 eq "off" ? "MUTE" : "'
  # If dB was selected, print that instead
  perl_filter+=$([[ $STEP = *dB ]] && echo '$3' || echo '$1')
  perl_filter+='"; exit}'
  output=$(perl -ne "$perl_filter")
  echo "$LABEL$output"
}

#------------------------------------------------------------------------

case $BLOCK_BUTTON in
  3) amixer $AMIXER_PARAMS -q -D $MIXER sset $SCONTROL $(capability) toggle ;;  # right click, mute/unmute
  4) amixer $AMIXER_PARAMS -q -D $MIXER sset $SCONTROL $(capability) ${STEP}+ unmute ;; # scroll up, increase
  5) amixer $AMIXER_PARAMS -q -D $MIXER sset $SCONTROL $(capability) ${STEP}- unmute ;; # scroll down, decrease
esac

volume | format
