#! /bin/sh
DIALOG=${DIALOG=dialog}
tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
trap "rm -f $tempfile" 0 1 2 5 15

$DIALOG --backtitle "Minecraft Server Script" \
	--title "Select Software" --clear \
        --radiolist "Use space and arrow keys" 20 61 5 \
        "Spigot"  "" off \
        "PaperSpigot"    "Recommended" ON \
        "CanaryMod" "Discontinued" off \
        "SpongeVanilla"    "" off 2> $tempfile

retval=$?

choice=`cat $tempfile`

if [ $choice == "PaperSpigot" ]; then
    $DIALOG --backtitle "Minecraft Server Script" \
	--title "Select Version" --clear \
        --radiolist "Use space and arrow keys" 20 61 5 \
        "1.16.5"  "Latest" ON \
        "1.16.4"    "" off \
        "1.16.3" "" off \
        "1.16.2"    "" off 2> $tempfile

choice=`cat $tempfile`
if [ $choice == "1.16.5" ]; then
    echo "Installing Paper 1.16.5"
    mkdir ~/.mctemp # aaa bash
    touch ~/.mctemp/paper.jar
    curl -L https://papermc.io/api/v2/projects/paper/versions/1.16.5/builds/748/downloads/paper-1.16.5-748.jar > ~/.mctemp/paper.jar
    $DIALOG --backtitle "Minecraft Server Script" \
	--title "Select directory to install server in" \
        --inputbox "Directory name (WITHOUT ~/)" 8 40 2 > $tempfile
    choice=`cat $tempfile`
    mkdir $choice
    mv ~/.mctemp/paper.jar $choice/paper-1.16.5-758.jar
fi
fi

case $retval in
  1)
    echo "Aborted";
    rm -rf ~/.mctemp;;
  255)
    echo "ESC pressed.";
    rm -rf ~/.mctemp;;
esac
