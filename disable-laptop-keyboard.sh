#!/bin/bash
# run xinput and put AT TRANS... into id var
# AT Translated Set 2 keyboard  
# Or the string itself. Sometimes id changes on boot

Icon="/PATH/TO/ICON_ON"
Icoff="/PATH_TO_ICON_OFF"
fconfig=".keyboard" 
id="AT Translated Set 2 keyboard" #21

if [ ! -f $fconfig ];
    then
        echo "Creating config file"
        echo "enabled" > $fconfig
        var="enabled"
    else
        read -r var< $fconfig
        echo "keyboard is : $var"
fi

if [ $var = "disabled" ];
    then
        notify-send -i $Icon "Enabling keyboard..." \ "ON - Keyboard connected !";
        echo "enable keyboard..."
        xinput enable $id
        echo "enabled" > $fconfig
    elif [ $var = "enabled" ]; then
        notify-send -i $Icoff "Disabling Keyboard" \ "OFF - Keyboard disconnected";
        echo "disable keyboard"
        xinput disable $id
        echo 'disabled' > $fconfig
fi
