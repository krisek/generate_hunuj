#!/bin/bash

MIRROR="yes"

for i in "$@"
do
case $i in
    -m=*|--mirror=*)
    MIRROR="${i#*=}"
    shift # past argument=value
    ;;
    *)
            # unknown option
    ;;
esac
done



#=======================================================================================
echo -n "Függőségek ellenőrzése (wget, libsword-utils, p7zip-full, perl)..."

PERL=`which perl`
WGET=`which wget`
OSIS2MOD=`which osis2mod`
ZIP=`which 7z`
if [ -z $PERL ] || [ -z $WGET ] || [ -z $OSIS2MOD ] || [ -z $ZIP ]
then
	if [ -e "/etc/lsb-release" ]
	then
		echo "Debian alapú disztribúció, apt-get futtatása"
		sudo apt-get install wget libsword-utils perl p7zip-full
	else
		#todo: check other distros
		echo "Kérlek ellenőrizd, hogy a wget, osis2mod, perl és p7zip-full programok telepítve vannak."
		exit;
	fi
fi


PERL=`which perl`
WGET=`which wget`
OSIS2MOD=`which osis2mod`
ZIP=`which 7z`
if [ -z $PERL ] || [ -z $WGET ] || [ -z $OSIS2MOD ] || [ -z $ZIP ]
then
	echo "Sajnos nincs minden függőség telepítve."
	echo "perl: $PERL"
	echo "wget: $WGET"
	echo "osis2mod: $OSIS2MOD"
	echo "p7zip-full: $ZIP" 
	exit
fi
echo "ok."

if [ "$MIRROR" == "yes" ]
then
#=======================================================================================
#az Új fordítású revideált Biblia tükrözése az abibliamindenkie.hu oldalról
echo "Tükrözés az abibliamindenkie.hu oldalról (ez sokáig is eltarthat)..."
#FIGYELEM
#ha elsőre nem fut le a szkript, a további próbálkozásoknál a --mirror=no paraméter megadásával
#a tükrözés nem fog mégegyszer lefutni
        wget -q -r -l 2  --accept-regex uj  http://abibliamindenkie.hu
#FIGYELEM VÉGE
echo "ok."
fi
#=======================================================================================
echo -n "HMTL fájlok konvertásása OSIS/XML formátumba..."
perl gensword.pl
if [ -e  hunujr.osis.xml ] 
then
	echo "ok."
else
	echo "broken"
	exit
fi
#=======================================================================================
#prepare location
echo -n "Modulkönyvtár inicializálása..."
mkdir -p hunuj/modules/texts/ztext/hunuj
mkdir -p hunuj/mods.d
cp hunuj.conf hunuj/mods.d/
echo "ok."

#generate module
echo -n "Modulkönyvtár generálása..."
osis2mod  hunuj/modules/texts/ztext/hunuj hunujr.osis.xml -v German -z 2>/dev/null
if [ -e hunuj/modules/texts/ztext/hunuj/ot.bzz ]
then
	echo "ok."
else
	echo " "
fi

#package
echo -n "Modulkönyvtár csomagolása..."
cd hunuj
7z a ../hunuj.zip .
cd ..
echo "ok."
#=======================================================================================
