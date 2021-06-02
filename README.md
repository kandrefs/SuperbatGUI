# SuperbatGUI
Batch files and GUI interface for specific video archival purposes.

Made for Windows 10 Pro - Might work on other windows based systems, but is not extensively tested.


Takes uncompressed .mov files from an ingested videotape and creates .mkv, .mp4, qctools .xml, mediainfo .xml, and mediatrace .xml for archiving. Also creates checksums for these files.
All files are sorted into URN specific naming, folder and files share the same URN name. All finished folders are placed into one shared directory in which they are later automatically harvested by a linux server for storage.
The finished folders are invisible to the linux server up until a video.done file is placed in each folder. This can be done manually, or through the GUI interface. (Creates for ALL folders).

I have included a batch script to check if video.done is included in the folder or not. It also checks for other missing files in the folders for troubleshooting purposes.

The P1-P4.bat files can be run manually or through GUI, but needs to be built/placed in the correct structure either way. In the future I plan on building an installer, but for now these scripts are intended for a very specific environment and it is not recommended to run outside this environment.

Has dependencies outside .bat files and .au3 (needs to be compiled as .exe)
  - MediaConch (cli)
  - fsum (cli)
  - ffmpeg (cli)
  - ffprobe (cli)
  - ffplay (cli)
  - Graphics for GUI
  - QcTools
  - VirtualDub 2

Instructions on how to build will be posted at a later time. The files are intended for a specific environment. It is a work in progress and is continually being worked on.
In the future, it is intended to drop the .mov to .mkv (FFV1) conversion entirely as there are plans for ingesting directly to FFV1.

//kandrefs
