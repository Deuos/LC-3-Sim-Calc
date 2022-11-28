#!/bin/sh
java "-Dsun.java2d.uiScale=1.5" -jar PennSim.jar -s run.txt
rm -f *.obj *.sym
