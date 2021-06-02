#! /bin/sh
DIALOG=${DIALOG=dialog}
tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
trap "rm -f $tempfile" 0 1 2 5 15

tempfile2=`tempfile2 2>/dev/null` || tempfile2=/tmp/test$$
trap "rm -f $tempfile2" 0 1 2 5 15

trap "exit" trapcmds

trapcmds(){
  rm -f $tempfile
  rm -rf 
}
title="Server install script version 2021.6.005"
selectDir(){
      $DIALOG --backtitle "$title" \
    --title "Directory path" \
    --inputbox "Directory path" 0 0 2>$tempfile2
  directory=`cat $tempfile2`
  mkdir $directory
  # /get good
}

eulaNotice(){
  $DIALOG --backtitle "$title" \
  --title "Do you accept the Minecraft server EULA?" \
  --menu "Yes or no" 0 0 0 \
  "Yes" "" \
  "No" "" 2> $tempfile
  choice=`cat $tempfile`
  echo "$choice"
  if [ $choice == "Yes" ]; then
    touch $directory/eula.txt
    echo "eula=true" > $directory/eula.txt
  fi

}

$DIALOG --backtitle "$title" \
	--title "Select Software" --clear \
        --menu "Use space and arrow keys" 0 0 0 \
        "Paper"  "Recommended" \
        "Spigot"    ""  \
        "CanaryMod" "Discontinued"  \
        "SpongeVanilla"    ""  \
        "Purpur" "" \
        "Vanilla"       ""   2> $tempfile

retval=$?

choice=`cat $tempfile`

if [ $choice == "Paper" ]; then
    $DIALOG --backtitle "$title" \
	--title "Select Version" --clear \
        --menu "Use space and arrow keys" 20 61 5 \
        "1.16.5/1.16.4"  "Latest"  \
        "1.15.2"    ""  \
        "1.14.4"    ""  \
        "1.13.2"    "" \
        2> $tempfile
choice=`cat $tempfile`
selectDir
echo "Dir: $directory"
echo $choice
if [ $choice == "1.16.5/1.16.4" ]; then
  echo "Downloading 1.16.5 Paper jar..."
  curl -L https://papermc.io/api/v2/projects/paper/versions/1.16.5/builds/748/downloads/paper-1.16.5-748.jar > $directory/paper-1.16.5-748.jar
  #echo "For debugging purposes the download part has been left out"
fi
if [ $choice == "1.15.2" ]; then
  echo "Downloading 1.15.2 Paper jar..."
  curl -L https://papermc.io/api/v2/projects/paper/versions/1.15.2/builds/391/downloads/paper-1.15.2-391.jar > $directory/paper-1.15.2-391.jar
fi
fi
if [ $choice == "SpongeVanilla" ]; then
      $DIALOG --backtitle "$title" \
	--title "Select Version" --clear \
        --menu "Use space and arrow keys" 20 61 5 \
        "1.12.2" "" # ill do this later, ok?
fi
eulaNotice

case $retval in
  1)
    echo "Aborted";
    rm -rf ~/.mctemp;;
  255)
    echo "ESC pressed.";
    rm -rf ~/.mctemp;;
esac
