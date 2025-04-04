#!/usr/bin/env expect
# Expect script that runs xdmod-upgrade to upgrade an already installed Open
# XDMoD instance.

#-------------------------------------------------------------------------------
# Helper functions

source [file join [file dirname [info script]] helper-functions.tcl]

proc confirmUpgrade { } {
    expect {
        timeout { send_user "\nFailed to get prompt\n"; exit 1 }
        -re "\nAre you sure you want to continue .*\\\] "
    }
    send yes\n
}

proc confirmResourceSpecs { } {
    expect {
        timeout { send_user "\nFailed to get prompt\n"; exit 1 }
        -re "\nAre you ready to continue? .*\\\] "
    }
    send yes\n
}

#-------------------------------------------------------------------------------
# main body

set timeout 180
spawn "xdmod-upgrade"
confirmUpgrade
confirmResourceSpecs

expect {
    timeout {
        send_user "\nFailed to get prompt\n"; exit 1
    }
    "Upgrade Complete" {
        lassign [wait] pid spawnid os_error_flag value
    }
}

exit $value
