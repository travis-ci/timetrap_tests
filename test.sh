#!/usr/bin/env sh

#
# Test 1, killing a script that runs forever.
#

declare -i TIMEOUT=3

fail()
{
    echo "[failure]" $1
    exit 1
}

success()
{
    echo "[ok]" $1
}


rm -f /tmp/timetrap-tests-long-sleeper
./bin/timetrap -t $TIMEOUT ./scripts/long_delay.sh

if [ -f /tmp/timetrap-tests-long-sleeper ]; then
    fail "/tmp/timetrap-tests-long-sleeper exists while it shouldn't. Timetrap did not fire."
else
    success "/tmp/timetrap-tests-long-sleeper does not exist, that's good. Moving on."
fi


./bin/timetrap -t $TIMEOUT ./scripts/endless_printer.sh
success "Got past endless printer"


./bin/timetrap -t $TIMEOUT ./scripts/exits_with_0.sh
if [ $? == 0 ]; then
    success "Successful exit code"
else
    fail "Exit code returned by timetrap is not 0. Something is wrong."
fi



./bin/timetrap -t $TIMEOUT ./scripts/exits_with_1.sh
if [ $? == 1 ]; then
    success "Correct negative exit code (1)"
else
    fail "Exit code returned by timetrap is not 1. Something is wrong."
fi


./bin/timetrap -t $TIMEOUT ./scripts/exits_with_33.sh
if [ $? == 33 ]; then
    success "Correct negative exit code (33)"
else
    fail "Exit code returned by timetrap is not 33. Something is wrong."
fi
