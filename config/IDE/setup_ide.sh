#!/bin/sh

# This script copies the configuration XML files to the .idea folders.
# It expects a predefined location for the source files based on the project repository.

echo "-- DISCLAIMER --"
echo "This script might try to override some configuration files on .idea folder"
echo "It will prompt you to chose when it's trying to replace an existing config file."
echo "If you are afraid to lose any existing configuration, check the prompted files before accepting."
echo ""

echo "Continue? (y/n)"
read CONTINUE
if [[ "$CONTINUE" != "y" ]]
then
  echo "Finishing..."
  exit 0
fi

ANDROID_STUDIO_VERSION="3.3"

# Get the directory of the script file
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo "Source IDE directory is: ${DIR}"

# Copy copyright files
echo "Setting up Copyright"
file_orig="${DIR}/copyright/"
file_dest="${DIR}/../../.idea/copyright/"
# Make sure destination exists
mkdir -p "${file_dest}"

# Copy copyright template
file_name="Adyen_MIT.xml"
cp "${file_orig}${file_name}" "${file_dest}${file_name}"
# Copy project settings to use template
file_name="profiles_settings.xml"
cp -i "${file_orig}${file_name}" "${file_dest}${file_name}"

# Copy CodeStyle profile
echo "Setting up CodeStyle"
file_orig="${DIR}/codeStyle/"
file_dest="/Users/${USER}/Library/Preferences/AndroidStudio${ANDROID_STUDIO_VERSION}/codestyles/"
file_name="AdyenAndroidStyle.xml"

cp "${file_orig}${file_name}" "${file_dest}${file_name}"
COPY_RESULT=$?

if [ "${COPY_RESULT}" -ne "0" ];
then
  echo
  echo "Unable to copy CodeStyle to Android Studio folder at:"
  echo "${file_dest}"
  echo "FAILED"
  exit 0
fi

# Copy CodeStyle config
file_dest="${DIR}/../../.idea/codeStyles/"
file_name="codeStyleConfig.xml"

mkdir -p "${file_dest}"
cp -i "${file_orig}${file_name}" "${file_dest}${file_name}"

echo ""
echo "SUCCESS - All done :)"
