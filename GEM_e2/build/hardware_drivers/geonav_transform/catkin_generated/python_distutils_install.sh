#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/gem/cuberts_484/src/hardware_drivers/geonav_transform"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/gem/cuberts_484/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/gem/cuberts_484/install/lib/python3/dist-packages:/home/gem/cuberts_484/build/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/gem/cuberts_484/build" \
    "/usr/bin/python3" \
    "/home/gem/cuberts_484/src/hardware_drivers/geonav_transform/setup.py" \
     \
    build --build-base "/home/gem/cuberts_484/build/hardware_drivers/geonav_transform" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/gem/cuberts_484/install" --install-scripts="/home/gem/cuberts_484/install/bin"