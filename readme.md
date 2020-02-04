# IMS
### Author: daniel zhang

# Readme

## Project Overview
This is a interactive music shell and has the following functions:

Help - display a simple help screen. This is a text message, multi line, that explains the available commands. Sort of like this list.
Exit - save state and exit. The effect of this is that when the app is run again, it is back to exactly where it was when you exited. What this amounts to is basically to make sure the tracks and artists and their info have all been saved.
Info - display a high level summary of the state. At minimum, the last 3 tracks played, and a count of the total number of tracks and the total number of artists. You can elaborate if you want.
Info track - Display info about a certain track by number
Info artist - Display info about a certain artist, by id
Add Artist - Adds a new artist to storage and assign an artist id. Default artist id is the initials of the artist. If this is ambiguous then another id is automatically assigned and displayed. e.g. add artist john osborne
Add Track - Add a new track to storage. add track watching the sky turn green by jo
Play Track - Record that an existing track was played at the current time, e.g. play track 13.
Count tracks - Display how many tracks are known by a certain artist, e.g. count tracks by jo
List tracks - Display the tracks played by a certain artist, e.g. list tracks by jo

## How to use
to use it, just run the ims.rb file in terminal. then you can type in command.

## YAML::Store
it's really a powerful tool which is easy to use when the size of data is not that large. 

