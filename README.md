#gen_hunuj.sh

Ez a shell/Perl alkalmazás páros SWORD modult készít a http://bibliamindenkie.hu oldalon található Revideált Újfordítású Biblia szövegéből.

A modul elkészítése négy munkafázisból áll. 

1. függőségek ellenőrzése, telepítése
2. a forrás HTML fájlok letöltése
3. Osis/XML előállítása a HTML fájlokból
4. Sword modul fordítása, csomagolása az OSIS dokumentum alapján

Az egyes munkafázisok a gen_hunuj.sh fájlban kerültek implementálásra, kivéve az Osis/XML dokumentum elkészítését, amelyért a gensword.pl Perl alakalmazás felel.

A modul elkészítése egyszerű, csak a gen_hunuj.sh parancsot kell lefuttatnunk, amikor ez végzett, a munkakönyvtárban egy hunuj.zip nevű állományban található a Sword modul. 

Amennyiben valamilyen okból a szkriptet többször szeretnénk futtatni, a forrás HTML fájlok letöltése a --mirror=no paraméter megadásával kikapcsolható.

Az elkészült modult ezután kézzel kell telepíteni valamilyen Sword formátumot támogató Biblia olvasó alkalmazásba.

> TIPP1: Andbible TODO

> A legtöbb Linuxos alkalmazásnak elég, ha a $HOME/.sword könyvtárba bemásoljuk a modulból a modules és mods.d könyvtárak tartalmát (mkdir $HOME/.sword; cp -a hunuj/* $HOME/.sword/).

##Figyelmeztetés
A progam futtatásából származó bárminemű kárért semmilyen felelőséget nem vállalok!

