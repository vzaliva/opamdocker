# opamdocker

Simple Docker container to build and run OCaml project using dependencies installed via OPAM

Usage:
  * Pace your sources into _'src'_ directory. 
  * Do build container use _'docker_build.sh'_ script. 
  * To run it use _'docker_run.sh'_.

Customization (by editing _'Dockerfile'_):
  * If you building outside Amazon AWS, comment out use of AWS repository
  * Customize list of system packages installed.
  * Customize list of OPAM packages installed.
  * If you are using other build system than _'omake'_ then customize build command.

(all customization locations are marked with comments in Docker file. Look for "CUSTOMIZE")
