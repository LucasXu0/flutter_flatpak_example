#!/bin/bash


# Convert the archive of the Flutter app to a Flatpak.


# Exit if any command fails
set -e

# Echo all commands for debug purposes
set -x


# No spaces in project name.
projectName=FlutterApp
projectId=com.example.FlutterApp
executableName=flutter_flatpak_example


# ------------------------------- Build Flatpak ----------------------------- #

# Extract portable Flutter build.
mkdir -p $projectName
tar -xf $projectName-Linux-Portable.tar.gz -C $projectName

# Copy the portable app to the Flatpak-based location.
cp -r $projectName /app/
chmod +x /app/$projectName/$executableName
mkdir -p /app/bin
ln -s /app/$projectName/$executableName /app/bin/$executableName

# Install the icon.
iconDir=/app/share/icons/hicolor/scalable/apps
mkdir -p $iconDir
cp -r assets/icons/$projectId.svg $iconDir/

# Install the desktop file.
desktopFileDir=/app/share/applications
mkdir -p $desktopFileDir
cp -r packaging/linux/$projectId.desktop $desktopFileDir/

# Install the AppStream metadata file.
metadataDir=/app/share/metainfo
mkdir -p $metadataDir
cp -r packaging/linux/$projectId.metainfo.xml $metadataDir/

# Install the D-Bus service file.
dbusDir=/app/share/dbus-1/services
mkdir -p $dbusDir
cp -r packaging/linux/$projectId.service $dbusDir/

# Install the launcher.sh
chmod +x packaging/linux/launcher.sh
cp -r packaging/linux/launcher.sh /app/bin/launcher.sh

# Install launcher desktop file.
launcherDesktopFileDir=/app/share/applications
mkdir -p $launcherDesktopFileDir
cp -r packaging/linux/$projectId.launcher.desktop $launcherDesktopFileDir/