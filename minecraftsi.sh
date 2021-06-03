#! /bin/bash
DIALOG=${DIALOG=dialog}
tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
trap "rm -f $tempfile" 0 1 2 5 15

tempfile2=`tempfile2 2>/dev/null` || tempfile2=/tmp/test$$
trap "rm -f $tempfile2" 0 1 2 5 15

trap "exit" trapcmds

trapcmds(){
  rm -f $tempfile
  rm -f $tempfile2
}
title="Server install script version 2021.6.007"
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
        "1.12.2"    "" \
        "1.11.2"    "" \
        "1.10.2"    "" \
        "1.9.4"    "" \
        "1.8"    "" \
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
if [ $choice == "1.14.4" ]; then
  echo "Downloading 1.14.4 Paper jar..."
  curl -L https://papermc.io/api/v2/projects/paper/versions/1.14.4/builds/243/downloads/paper-1.14.4-243.jar > $directory/paper-1.14.4-243.jar
fi
if [ $choice == "1.13.2" ]; then
  echo "Downloading 1.13.2 Paper jar..."
  curl -L https://papermc.io/api/v2/projects/paper/versions/1.13.2/builds/655/downloads/paper-1.13.2-655.jar > $directory/paper-1.13.2-655.jar
fi
if [ $choice == "1.12.2" ]; then
  echo "Downloading 1.12.2 Paper jar..."
  curl -L https://papermc.io/api/v2/projects/paper/versions/1.12.2/builds/1618/downloads/paper-1.12.2-1618.jar > $directory/paper-1.12.2-1618.jar
fi
if [ $choice == "1.11.2" ]; then
  echo "Downloading 1.11.2 Paper jar..."
  curl -L https://papermc.io/api/v2/projects/paper/versions/1.11.2/builds/1104/downloads/paper-1.11.2-1104.jar > $directory/paper-1.11.2-1104.jar
fi
if [ $choice == "1.10.2" ]; then
  echo "Downloading 1.10.2 Paper jar..."
  curl -L https://papermc.io/api/v2/projects/paper/versions/1.10.2/builds/916/downloads/paper-1.10.2-916.jar > $directory/paper-1.10.2-916.jar
fi
if [ $choice == "1.9.4" ]; then
  echo "Downloading 1.9.4 Paper jar..."
  curl -L https://papermc.io/api/v2/projects/paper/versions/1.9.4/builds/773/downloads/paper-1.9.4-773.jar > $directory/paper-1.9.4-773.jar
fi
if [ $choice == "1.8" ]; then
  echo "Downloading 1.8.8 Paper jar..."
  curl -L https://papermc.io/api/v2/projects/paper/versions/1.8.8/builds/443/downloads/paper-1.8.8-443.jar > $directory/paper-1.8.8-443.jar
fi
fi
if [ $choice == "SpongeVanilla" ]; then
      $DIALOG --backtitle "$title" \
	      --title "Select Version" --clear \
        --menu "Use space and arrow keys" 20 61 5 \
        "1.12.2" "" \
        "1.11.2" "" \
        "1.10.2" "" \
        "1.8.9" "" \
        "1.8" "" \
        2> $tempfile
      version=`cat $tempfile`
      selectDir
      if [ $version == "1.12.2" ]; then
        echo "Downloading 1.12.2 Sponge jar"
        curl -L https://repo.spongepowered.org/maven/org/spongepowered/spongevanilla/1.12.2-7.3.0/spongevanilla-1.12.2-7.3.0.jar > $directory/spongevanilla-1.12.2-7.3.0.jar
      fi
      if [ $version == "1.11.2" ]; then
        echo "Downloading 1.11.2 Sponge jar"
        curl -L https://repo.spongepowered.org/maven/org/spongepowered/spongevanilla/1.11.2-6.1.0-BETA-27/spongevanilla-1.11.2-6.1.0-BETA-27.jar > $directory/spongevanilla-1.11.2-6.1.0-BETA-27.jar
      fi
      if [ $version == "1.10.2" ]; then
        echo "Downloading 1.10.2 Sponge jar"
        curl -L https://repo.spongepowered.org/maven/org/spongepowered/spongevanilla/1.10.2-5.2.0-BETA-403/spongevanilla-1.10.2-5.2.0-BETA-403.jar > $directory/spongevanilla-1.10.2-5.2.0-BETA-403.jar
      fi    
      if [ $version == "1.8.9" ]; then
        echo "Downloading 1.8.9 Sponge jar"
        curl -L https://repo.spongepowered.org/maven/org/spongepowered/spongevanilla/1.8.9-4.2.0-BETA-352/spongevanilla-1.8.9-4.2.0-BETA-352.jar > $directory/spongevanilla-1.8.9-4.2.0-BETA-352.jar
      fi    
fi
if [ $choice == "Vanilla" ]; then
      $DIALOG --backtitle "$title" \
	      --title "Select Version" --clear \
        --menu "Use space and arrow keys" 20 61 5 \
        "1.16.5/1.16.4" "Latest" \
        "1.15.2" "" \
        "1.14.4" "" \
        "1.13.2" "" \
        "1.12.2" "" \
        "1.11.2" "" \
        "1.10.2" "" \
        "1.9.4" "" \
        "1.8.8" "" \
        "1.7.10" "" \
        2> $tempfile
      version=`cat $tempfile`
      selectDir
      if [ $version == "1.16.5/1.16.4" ]; then
        echo "Downloading vanilla 1.16.5 jar"
        curl -L https://launcher.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar > $directory/server-1.16.5.jar
      fi
      if [ $version == "1.15.2" ]; then
        echo "Downloading vanilla 1.15.2 jar"
        curl -L https://launcher.mojang.com/v1/objects/bb2b6b1aefcd70dfd1892149ac3a215f6c636b07/server.jar > $directory/server-1.15.2.jar
      fi
      if [ $version == "1.14.4" ]; then
        echo "Downloading vanilla 1.14.4 jar"
        curl -L https://launcher.mojang.com/v1/objects/3dc3d84a581f14691199cf6831b71ed1296a9fdf/server.jar > $directory/server-1.14.4.jar
      fi
      if [ $version == "1.13.2" ]; then
        echo "Downloading vanilla 1.13.2 jar"
        curl -L https://launcher.mojang.com/v1/objects/3737db93722a9e39eeada7c27e7aca28b144ffa7/server.jar > $directory/server-1.13.2.jar
      fi
      if [ $version == "1.12.2" ]; then
        echo "Downloading vanilla 1.12.2 jar"
        curl -L https://launcher.mojang.com/v1/objects/886945bfb2b978778c3a0288fd7fab09d315b25f/server.jar > $directory/server-1.12.2.jar
      fi
      if [ $version == "1.11.2" ]; then
        echo "Downloading vanilla 1.11.2 jar"
        curl -L https://launcher.mojang.com/v1/objects/f00c294a1576e03fddcac777c3cf4c7d404c4ba4/server.jar > $directory/server-1.11.2.jar
      fi
      if [ $version == "1.10.2" ]; then
        echo "Downloading vanilla 1.10.2 jar"
        curl -L https://launcher.mojang.com/v1/objects/3d501b23df53c548254f5e3f66492d178a48db63/server.jar > $directory/server-1.10.2.jar
      fi
      if [ $version == "1.9.4" ]; then
        echo "Downloading vanilla 1.9.4 jar"
        curl -L https://launcher.mojang.com/v1/objects/edbb7b1758af33d365bf835eb9d13de005b1e274/server.jar > $directory/server-1.9.4.jar
      fi
      if [ $version == "1.8.8" ]; then
        echo "Downloading vanilla 1.8.8 jar"
        curl -L https://launcher.mojang.com/v1/objects/5fafba3f58c40dc51b5c3ca72a98f62dfdae1db7/server.jar > $directory/server-1.8.8.jar
      fi
      if [ $version == "1.7.10" ]; then
        echo "Downloading vanilla 1.7.10 jar"
        curl -L https://launcher.mojang.com/v1/objects/952438ac4e01b4d115c5fc38f891710c4941df29/server.jar > $directory/server-1.7.10.jar
      fi
fi
if [ $choice == "Spigot" ]; then
      $DIALOG --backtitle "$title" \
	--title "Select Version" --clear \
        --menu "Use space and arrow keys" 20 61 5 \
        "1.16.5"  "Latest"  \
        "1.15.2"    ""  \
        "1.14.4"    ""  \
        "1.13.2"    "" \
        "1.12.2"    "" \
        "1.11.2"    "" \
        "1.10.2"    "" \
        "1.9.4"    "" \
        "1.8"    "" \
        2> $tempfile
        version=`cat $tempfile`
        selectDir
      echo "Attempting to download $version Spigot jar"
      curl -L https://cdn.getbukkit.org/spigot/spigot-$version.jar > $directory/spigot-$version.jar
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
