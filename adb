#!/bin/sh

# Copyright 2012 Roman Nurik
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Bash completion for adb
function _adb() {
  local result_names
  local result_xpat
  local adbcmd=${COMP_WORDS[0]}
  local word=${COMP_WORDS[COMP_CWORD]}
  local next

  local ind=1

  # Look for adb options
  if [[ ${COMP_WORDS[$ind]} == "-s" ]]; then
    if [[ ${COMP_CWORD} == 2 ]]; then
      # We're completing for a device serial number
      local devices=$(${adbcmd} devices | sed '1d' | tr -s '\t ' ' ' | cut -f 1 -d " ")
      COMPREPLY=($(compgen -W "${devices}" -- "${word}"))
      if [[ ${COMPREPLY} == '' ]]; then
        COMPREPLY=""
        echo 
        echo 'No devices found. Run "adb devices" for a sanity check.'
      fi
      return
    else
      # We've already completed a device serial number.
      let 'ind += 2'
    fi
  fi

  # Complete a package name.
  function _package_name() {
    if [[ ${COMP_CWORD} -le $ind ]]; then
      result_names=$(${adbcmd} shell pm list packages -3 | sed s/package://g | tr -d '\r')
    fi
  }

  # adb ___
  function _root() {
    # Primary command flow
    if [[ ${COMP_CWORD} -le $ind ]]; then
      read -r -d '' result_names <<EOF
shell devices install uninstall push pull logcat forward bugreport start-server
kill-server root reboot reboot-bootloader remount
EOF
    else
      next=${COMP_WORDS[$ind]}
      let 'ind += 1'

      case "${next}" in
      shell)
        _shell
        ;;

      install)
        result_xpat='!*.apk'
        ;;

      uninstall)
        _package_name
        ;;

      *)
        result_names=''
        ;;
      esac
    fi
  }

  # adb shell ___
  function _shell() {
    if [[ ${COMP_CWORD} -le $ind ]]; then
      result_names="pm am dumpsys"
    else
      next=${COMP_WORDS[$ind]}
      let 'ind += 1'
      case "${next}" in
        pm)
          _shell_pm
          ;;

        am)
          _shell_am
          ;;

        dumpsys)
          _shell_dumpsys
          ;;
      esac
    fi
  }

  # adb shell pm ___
  function _shell_pm() {
    if [[ ${COMP_CWORD} -le $ind ]]; then
      result_names="list clear enable disable"
    else
      next=${COMP_WORDS[$ind]}
      let 'ind += 1'
      case "${next}" in
        list)
          _shell_pm_list
          ;;
      esac
    fi
  }

  # adb shell pm list ___
  function _shell_pm_list() {
    if [[ ${COMP_CWORD} -le $ind ]]; then
      result_names="packages permission-groups permissions features libraries"
    fi
  }

  # adb shell am ___
  function _shell_am() {
    if [[ ${COMP_CWORD} -le $ind ]]; then
      read -r -d '' result_names <<EOF
start startservice broadcast force-stop kill kill-all instrument
profile dumpheap monitor display-size to-uri to-intent-uri
EOF
    else
      next=${COMP_WORDS[$ind]}
      let 'ind += 1'
      case "${next}" in
        force-stop|kill)
          _package_name
          ;;
      esac
    fi
  }

  # adb shell dumpsys ___
  function _shell_dumpsys() {
    if [[ ${COMP_CWORD} -le $ind ]]; then
      read -r -d '' result_names <<EOF
SurfaceFlinger accessibility account activity alarm appwidget audio backup
battery batteryinfo bluetooth bluetooth_a2dp clipboard connectivity
content country_detector cpuinfo device_policy devicestoragemonitor
diskstats drm.drmManager dropbox entropy gfxinfo hardware input_method
iphonesubinfo isms location media.audio_flinger media.audio_policy
media.camera media.player meminfo mount netpolicy netstats
network_management nfc notification package permission phone power
samplingprofiler search sensorservice simphonebook sip statusbar
telephony.registry textservices throttle uimode usagestats usb vibrator
wallpaper wifi wifip2p window
EOF
    fi
  }

  # Kick off command flow matching
  _root

  if [[ -n "${result_xpat}" ]]; then
    COMPREPLY=($(compgen -f -X "${result_xpat}" -- "${word}"))
  else
    COMPREPLY=($(compgen -W "${result_names}" -- "${word}"))
  fi
}

complete -o default -F _adb adb

