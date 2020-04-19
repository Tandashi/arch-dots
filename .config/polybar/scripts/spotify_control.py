#!/bin/python3
# Created by Tandashi

import sys
import dbus
import argparse

parser = argparse.ArgumentParser()
group = parser.add_mutually_exclusive_group(required=True)
group.add_argument(
    '--next',
    action='store_true'
)
group.add_argument(
    '--previous',
    action='store_true'
)
group.add_argument(
    '--playpause',
    action='store_true'
)
group.add_argument(
    '--pause',
    action='store_true'
)
group.add_argument(
    '--play',
    action='store_true'
)

args = parser.parse_args()

try:
    session_bus = dbus.SessionBus()
    spotify_bus = session_bus.get_object(
        'org.mpris.MediaPlayer2.spotify',
        '/org/mpris/MediaPlayer2'
    )

    spotify_methods = dbus.Interface(
        spotify_bus,
        'org.mpris.MediaPlayer2.Player'
    )

    if (args.next):
        spotify_methods.Next()

    if (args.previous):
        spotify_methods.Previous()

    if (args.play):
        spotify_methods.Play()

    if (args.pause):
        spotify_methods.Pause()

    if (args.playpause):
        spotify_methods.PlayPause()

except Exception as e:
    if isinstance(e, dbus.exceptions.DBusException):
        print('')
    else:
        print(e)
