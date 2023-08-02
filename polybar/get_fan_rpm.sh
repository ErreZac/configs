#!/bin/sh
RPM="$(sensors | grep cpu_fan | awk '{print $2}')"
echo " $RPM rpm"
