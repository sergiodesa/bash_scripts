#!/bin/bash
############### 8 Bit Color Codes ###############
# Standard Formatting
RESET="\e[0m";
BOLD="\e[1m";
UNDERLINE="\e[2m";
HIGHLIGHT="\e[3m";
SHADE="\e[5m";
DARKEN=$SHADE;          # Alias for SHADE
SHADOW=$SHADE;          # Alias for SHADE
CHMK="\xE2\x9C\x94"     # Makes a Checkmark

# Colors (Basic)
BLACK="\e[30m";
RED="\e[31m";
GREEN="\e[32m";
YELLOW="\e[33m";
BLUE="\e[34m";
MAGENTA="\e[35m";
PURPLE=$MAGENTA;        # Alias for MAGENTA
CYAN="\e[36m";
GREY="\e[37m";
GRAY=$GREY;

# Colors (Bright)
BBLACK="\e[90m";
BRED="\e[91m";
PINK=$BRED;             # [PINK] Alias for BRED
BGREEN="\e[92m";
MINT=$BGREEN;           # [MINT] Alias for BGREEN
BYELLOW="\e[93m";
BBLUE="\e[94m";
BGREEN="\e[95m";
BMAGENTA="\e[96m";
BPURPLE=$BMAGENTA;      # Alias for BMAGENTA
BCYAN="\e[96m";
BGREY="\e[96m";
BGRAY=$BGREY;
WHITE=$BGREY;           # [WHITE] Alias for BGREY

# Legacy Colors
BAD="\e[41m";           # White Text on Red Background;
DARKGREY="\e[1;30m";
DARKGRAY=$DARKGREY;

############### Short Codes ###############
# Short Standard Formatting
fR=$RESET;              # Alias for RESET
fB=$BOLD;               # Alias for BOLD
fU=$UNDERLINE;          # Alias for UNDERLINE
fH=$HIGHLIGHT;          # Alias for HIGHLIGHT
fS=$SHADE;              # Alias for SHADE

# Short Colors (Basic)
cR=$RESET;              # Alias for RESET
cN=$BLACK;              # Alias for BLACK (null/no color)
cG=$GREEN;              # Alias for GREEN
cY=$YELLOW;             # Alias for HIGHLIGHT
cB=$BLUE;               # Alias for BLUE
cM=$MAGENTA;            # Alias for MAGENTA
cP=$PURPLE;             # Alias for PURPLE
cC=$CYAN;               # Alias for CYAN

# Short Colors (Bright)
bR=$RESET;              # Alias for BRESET
bN=$BBLACK;             # Alias for BBLACK (null/no color)
bG=$BGREEN;             # Alias for BGREEN
bY=$BYELLOW;            # Alias for BHIGHLIGHT
bB=$BBLUE;              # Alias for BBLUE
bM=$BMAGENTA;           # Alias for BMAGENTA
bP=$BPURPLE;            # Alias for BPURPLE
bC=$BCYAN;              # Alias for BCYAN

# Short Legacy Colors
BD="\e[1m";             # BOLD
RS="\e[0;00m";          # RESET
H1="\e[1m\e[34m";       # BOLD and BLUE
H2="\e[1m\e[97m";       # BOLD and WHITE
SH1="\e[1m\e[36m";      # BOLD and CYAN
SH2="\e[1m\e[97m";      # BOLD and WHITE
CM1="\e[1m\e[95m";      # BOLD and MAGENTA
CM2="\e[1m\e[97m";      # BOLD and WHITE
W1="\e[1m\e[97m";       # BOLD and WHITE
#W1="\e[97m";           # WHITE
R1="\e[31m";            # RED
R2="\E[1;31m";          # SOFTER RED
Y1="\e[1;33m";          # YELLOW
G1="\e[1;32m";          # GREEN
B1="\e[34m";            # BLUE
C1="\e[36m";            # CYAN
M1="\e[95m";            # MAGENTA
G2="\e[90m";            # GRAY
BL="\e[0;30m";          # BLACK
DG="\e[1;30m";          # DARK GRAY

# Symbols
GCHMK="\e[32m\xE2\x9C\x94"; # Green Checkmark
GCK=$GCHMK;             # Short code for Green Checkmark

##### Reset Environment Variables

# 1=""
INPUTZ=""
CHECKACCOUNT=""
THEDOMAIN=""
THEACCOUNT=""
linenum=""
inodes=""
nobody=""
userskip=""
flag=""
flag2=""
grepip=""
digip=""
plan=""
location=""
line=""
month=""
day=""
today=""
host=""
digns=""

apachecon(){

ApacheVer=$(/usr/sbin/httpd -v | awk -F'[./ ]' '/version/ {print $4$5$6}');
echo -e "$RS$M1 Apache version: $ApacheVer \n"
if [ "$ApacheVer" -lt 2423 ]; then
    ApacheCurrentOld;
    elif [[ "$ApacheVer" -ge 2423 && "$ApacheVer" -lt 2430 ]]; then
	ApacheCurrent2;
    elif [ "$ApacheVer" -ge 2430 ]; then
	ApacheCurrent3;
    else
        printf "Unknown Exception occurred\n"
        httpd -V;
fi;
MySQLCurrent;
}
###Pre Apache 2.4.23
ApacheCurrentOld(){
printf "$BL"
printf "-$RS$M1 Current Pre Apache 2.4.23 connections\n"

# Apache scoreboard sorted
	echo -e "      $BL-$RS$SH1 *Number of active Apache connections sorted scoreboard:$BL*$RS"; 
	echo -e "$BL~~~$RS"; 
	lynx -dump -width=5000 127.0.0.1/whm-server-status | sed -n '/requests currently being/,/Scoreboard Key/p' | awk '/\.|_|S|R|W|K|D|C|L|G|I/ && !/Scoreboard Key|PID|Sum/' | sed 's/.\{1\}/&\n/g' | sed '/^$/d' | sort | uniq -c | sort -rn |sed 's/\./\"\.\" /; s/_/\"_\" /; s/S/\"S\" /; s/R/\"R\" /; s/W/\"W\" /; s/K/\"K\" /; s/D/\"D\" /; s/C/\"C\" /; s/L/\"L\" /; s/G/\"G\" /; s/I/\"I\" /' | sed 's/"\." /\"\.\" Open Slot with no Current Process/; s/"\_" /\"\_\" Waiting for Connection/; s/\"S\" /\"S\" Starting up/; s/\"R\" /\"R\" Reading Request/; s/\"W\" /\"W\" Sending Reply/; s/\"K\" /\"K\" Keepalive (read)/; s/\"D\" /\"D\" DNS Lookup/; s/\"C\" /\"C\" Closing Connection/; s/\"L\" /\"L\" Logging/; s/\"G\" /\"G\" Gracefully Finishing/; s/\"I\" /\"I\" Idle Cleanup of Worker/'; 
		echo -e "$BL~~~$RS"; 

# By what domain is being hit
	echo -e "      $BL-$RS$SH1 *Sorted by what domain is getting hit:$BL*$RS"; 
	echo -e "$BL~~~$RS"; 
	lynx -dump -width=5000 127.0.0.1/whm-server-status | sed -n '/     Request/,/     ___________/p' | awk '!/_________/ && !/PID      Acc/' | egrep -v "$HOSTNAME" | awk '/NULL/ {print $12} /GET/ {print $12} /HEAD/ {print $12} /POST/ {print $12}' | sort | uniq -c | sort -rn | head; 
		echo -e "$BL~~~$RS"; 

# By what IP is hitting apache
	echo -e "      $BL-$RS$SH1 *Sorted IPs hitting Apache:$BL*$RS"; 
	echo -e "$BL~~~$RS"; 
	lynx -dump -width=5000 127.0.0.1/whm-server-status | sed -n '/ PID /,/     ___________/p' | awk '!/_________/ && !/ PID /' | egrep -v "$HOSTNAME" | awk '/NULL|GET|HEAD|POST/ {print $11}' | sort | uniq -c | sort -rn | head; 
		echo -e "$BL~~~$RS"; 

# By what IP is hitting sites
	echo -e "      $BL-$RS$SH1 *Sorted by what IP is hitting the same site:$BL*$RS"; 
	echo -e "$BL~~~$RS"; 	
	lynx -dump -width=5000 127.0.0.1/whm-server-status | sed -n '/ PID /,/     ___________/p' | awk '!/_________/ && !/ PID /' | egrep -v "$HOSTNAME" | egrep "NULL|GET|HEAD|POST" | awk '{print $11,$12}' | sort | uniq -c | sort -rn | head; 
		echo -e "$BL~~~$RS"; 
		
# By what IP is hitting each site file
	echo -e "      $BL-$RS$SH1 *Sorted by what IP is hitting the same site file:$BL*$RS";
	echo -e "$BL~~~$RS"; 
	lynx -dump -width=5000 127.0.0.1/whm-server-status | sed -n '/ PID /,/     ___________/p' | awk '!/_________/ && !/ PID /' | egrep -v "$HOSTNAME" | egrep "NULL|GET|HEAD|POST" | awk '{print $11,$12,$14,$15}' | sort | uniq -c | sort -rn| head; 
		echo -e "$BL~~~$RS"; 
		
# By what IP is hitting xmlrpc.php which is over 1 time concurrently
    if [[ -n $(lynx -dump -width=5000 localhost/whm-server-status | sed -n '/     Request/,/     ___________/p' | awk '!/_________/ && !/PID      Acc/ && /xmlrpc|wp-login|admin/ {print $11,$12}' | sort | uniq -c | awk '$1 > 1' | sort -n) ]]; then 
        echo -e "      $BL-$RS$SH1 *Possible attacks sorted:$BL*$RS"
	    echo -e "$BL~~~$RS"; 
	    lynx -dump -width=5000 127.0.0.1/whm-server-status | sed -n '/     Request/,/     ___________/p' | awk '!/_________/ && !/PID      Acc/ && /xmlrpc|wp-login|admin/ {print $11,$12}' | sort | uniq -c | awk '$1 > 1' | sort -n
		echo -e "$BL~~~$RS"; 
	fi;
}

###Apache 2.4.23 - 2.4.30
ApacheCurrent2(){
	echo -e "$BL\n-$RS$M1 Current Apache 2.4.23 - 2.4.30 connections"
# Apache scoreboard sorted
	echo -e "      $BL-$RS$SH1 *Number of active Apache connections sorted scoreboard:$BL*$RS"; 
	echo -e "$BL~~~$RS"; 

	lynx -dump -width=5000 localhost/whm-server-status | sed -n '/requests currently being/,/Scoreboard Key/p' | awk '/\.|_|S|R|W|K|D|C|L|G|I/ && !/Scoreboard Key|PID|Sum/' | sed 's/.\{1\}/&\n/g' | sed '/^$/d' | sort | uniq -c | sort -rn |sed 's/\./\"\.\" /; s/_/\"_\" /; s/S/\"S\" /; s/R/\"R\" /; s/W/\"W\" /; s/K/\"K\" /; s/D/\"D\" /; s/C/\"C\" /; s/L/\"L\" /; s/G/\"G\" /; s/I/\"I\" /' | sed 's/"\." /\"\.\" Open Slot with no Current Process/; s/"\_" /\"\_\" Waiting for Connection/; s/\"S\" /\"S\" Starting up/; s/\"R\" /\"R\" Reading Request/; s/\"W\" /\"W\" Sending Reply/; s/\"K\" /\"K\" Keepalive (read)/; s/\"D\" /\"D\" DNS Lookup/; s/\"C\" /\"C\" Closing Connection/; s/\"L\" /\"L\" Logging/; s/\"G\" /\"G\" Gracefully Finishing/; s/\"I\" /\"I\" Idle Cleanup of Worker/'; 
		echo -e "$BL~~~$RS"; 

# By what domain is being hit	
	echo -e "      $BL-$RS$SH1 *Sorted by what domain is getting hit:$BL*$RS"; 
	echo -e "$BL~~~$RS"; 

	lynx -dump -width=5000 localhost/whm-server-status | sed -n '/     Request/,/     ___________/p' | awk '!/_________/ && !/PID      Acc/' | egrep -v "$HOSTNAME" | awk '/NULL|GET|HEAD|POST/ {print $13}' | sort | uniq -c | sort -rn | head; 
		echo -e "$BL~~~$RS"; 

# By what IP is hitting apache
	echo -e "      $BL-$RS$SH1 *Sorted IPs hitting Apache:$BL*$RS"; 
	echo -e "$BL~~~$RS"; 

	lynx -dump -width=5000 localhost/whm-server-status | sed -n '/ PID /,/     ___________/p' | awk '!/_________/ && !/ PID /' | egrep -v "$HOSTNAME" | awk '/NULL|GET|HEAD|POST/ {print $11}' | sort | uniq -c | sort -rn | head; 
		echo -e "$BL~~~$RS"; 

# By what IP is hitting sites
	echo -e "      $BL-$RS$SH1 *Sorted by what IP is hitting the same site:$BL*$RS"; 
	echo -e "$BL~~~$RS"; 	
	lynx -dump -width=5000 localhost/whm-server-status | sed -n '/ PID /,/     ___________/p' | awk '!/_________/ && !/ PID /' | egrep -v "$HOSTNAME" | awk '/NULL|GET|HEAD|POST/ {print $11,$13}' | sort | uniq -c | sort -rn | head; 
		echo -e "$BL~~~$RS"; 
		
# By what IP is hitting each site file
	echo -e "      $BL-$RS$SH1 *Sorted by what IP is hitting the same site file:$BL*$RS";
	echo -e "$BL~~~$RS"; 
	lynx -dump -width=5000 localhost/whm-server-status | sed -n '/ PID /,/     ___________/p' | awk '!/_________/ && !/ PID /' | egrep -v "$HOSTNAME" | awk '/NULL|GET|HEAD|POST/ {print $11,$13,$15,$16}' | sort | uniq -c | sort -rn| head; 
		echo -e "$BL~~~$RS"; 
		
# By what IP is attacking which is over 1 time concurrently
	if [[ -n $(lynx -dump -width=5000 localhost/whm-server-status | sed -n '/     Request/,/     ___________/p' | awk '!/_________/ && !/PID      Acc/ && /xmlrpc|wp-admin|admin/ {print $11,$13}' | sort | uniq -c | awk '$1 > 1' | sort -n) ]]; then
		echo -e "      $BL-$RS$SH1 *Possible attacks sorted:$BL*$RS"
	    echo -e "$BL~~~$RS"; 
	    lynx -dump -width=5000 localhost/whm-server-status | sed -n '/     Request/,/     ___________/p' | awk '!/_________/ && !/PID      Acc/ && /xmlrpc|wp-admin|admin/ {print $11,$13}' | sort | uniq -c | awk '$1 > 1' | sort -rn
		echo -e "$BL~~~$RS"; 
	fi;
};

###Apache 2.4.30 and newer (EA4)
ApacheCurrent3(){
	echo -e "$BL\n-$RS$M1 Current Apache 2.4.30 and newer connections"
# Apache scoreboard sorted
	echo -e "      $BL-$RS$SH1 *Number of active Apache connections sorted scoreboard:$BL*$RS"; 
	echo -e "$BL~~~$RS"; 

	lynx -dump -width=5000 localhost/whm-server-status | sed -n '/requests currently being/,/Scoreboard Key/p' | awk '/\.|_|S|R|W|K|D|C|L|G|I/ && !/Scoreboard Key|PID|Sum/' | sed 's/.\{1\}/&\n/g' | sed '/^$/d' | sort | uniq -c | sort -rn |sed 's/\./\"\.\" /; s/_/\"_\" /; s/S/\"S\" /; s/R/\"R\" /; s/W/\"W\" /; s/K/\"K\" /; s/D/\"D\" /; s/C/\"C\" /; s/L/\"L\" /; s/G/\"G\" /; s/I/\"I\" /' | sed 's/"\." /\"\.\" Open Slot with no Current Process/; s/"\_" /\"\_\" Waiting for Connection/; s/\"S\" /\"S\" Starting up/; s/\"R\" /\"R\" Reading Request/; s/\"W\" /\"W\" Sending Reply/; s/\"K\" /\"K\" Keepalive (read)/; s/\"D\" /\"D\" DNS Lookup/; s/\"C\" /\"C\" Closing Connection/; s/\"L\" /\"L\" Logging/; s/\"G\" /\"G\" Gracefully Finishing/; s/\"I\" /\"I\" Idle Cleanup of Worker/'; 
		echo -e "$BL~~~$RS"; 

# By what domain is being hit	
	echo -e "      $BL-$RS$SH1 *Sorted by what domain is getting hit:$BL*$RS"; 
	echo -e "$BL~~~$RS"; 

	lynx -dump -width=5000 localhost/whm-server-status | sed -n '/     Request/,/     ___________/p' | awk '!/_________/ && !/PID      Acc/' | egrep -v "$HOSTNAME" | awk '/NULL|GET|HEAD|POST/ {print $14}' | sort | uniq -c | sort -rn | head; 
		echo -e "$BL~~~$RS"; 

# By what IP is hitting apache
	echo -e "      $BL-$RS$SH1 *Sorted IPs hitting Apache:$BL*$RS"; 
	echo -e "$BL~~~$RS"; 

	lynx -dump -width=5000 localhost/whm-server-status | sed -n '/ PID /,/     ___________/p' | awk '!/_________/ && !/ PID /' | egrep -v "$HOSTNAME" | awk '/NULL|GET|HEAD|POST/ {print $12}' | sort | uniq -c | sort -rn | head; 
		echo -e "$BL~~~$RS"; 

# By what IP is hitting sites
	echo -e "      $BL-$RS$SH1 *Sorted by what IP is hitting the same site:$BL*$RS"; 
	echo -e "$BL~~~$RS"; 	
	lynx -dump -width=5000 localhost/whm-server-status | sed -n '/ PID /,/     ___________/p' | awk '!/_________/ && !/ PID /' | egrep -v "$HOSTNAME" | awk '/NULL|GET|HEAD|POST/ {print $12,$14}' | sort | uniq -c | sort -rn | head; 
		echo -e "$BL~~~$RS"; 
		
# By what IP is hitting each site file
	echo -e "      $BL-$RS$SH1 *Sorted by what IP is hitting the same site file:$BL*$RS";
	echo -e "$BL~~~$RS"; 
	lynx -dump -width=5000 localhost/whm-server-status | sed -n '/ PID /,/     ___________/p' | awk '!/_________/ && !/ PID /' | egrep -v "$HOSTNAME" | awk '/NULL|GET|HEAD|POST/ {print $12,$14,$16,$17}' | sort | uniq -c | sort -rn| head; 
		echo -e "$BL~~~$RS"; 
		
# By what IP is attacking which is over 1 time concurrently
	if [[ -n $(lynx -dump -width=5000 localhost/whm-server-status | sed -n '/     Request/,/     ___________/p' | awk '!/_________/ && !/PID      Acc/ && /xmlrpc|wp-admin|admin/ {print $12,$14}' | sort | uniq -c | awk '$1 > 1' | sort -n) ]]; then
		echo -e "      $BL-$RS$SH1 *Possible attacks sorted:$BL*$RS"
	    echo -e "$BL~~~$RS"; 
	    lynx -dump -width=5000 localhost/whm-server-status | sed -n '/     Request/,/     ___________/p' | awk '!/_________/ && !/PID      Acc/ && /xmlrpc|wp-admin|admin/ {print $12,$14}' | sort | uniq -c | awk '$1 > 1' | sort -rn
		echo -e "$BL~~~$RS"; 
	fi;
}

MySQLCurrent(){
    mysql -BNe 'SHOW PROCESSLIST;' | grep -v "SHOW PROCESSLIST" | cut -d$'\t' -f2- | column -ts $'\t'
};
port (){
    x=10
        netstat -nA inet | awk '/^[ut]/{split($5,a,":");print a[1]}' | sort | uniq -c | sort -n -r | head -n $x | while IFS= read -r line || [ -n "$line" ]; do
        count=`echo $line | awk '{split($0,b," ");print b[1]}'`
        ip=`echo $line | awk '{split($0,b," ");print b[2]}'`
        country=`whois $ip | grep -E -m 1 'country|Country' | awk '{split($0,b," ");print b[2]}'`
        if [ $ip = '127.0.0.1' ]
        then
                country='--'
        fi
	if [ -z $country  ]
	then
		country='??'
	fi
	if [ $country == "PT" ] || [ $country == "--"  ]
       	then
               	echo "     $count $ip (${country:0:2})"
        else
                echo -e "\033[31m     $count $ip (${country:0:2}) \e[0m"
       	fi
	done
}
cpu (){
        set -v
        ps axo pcpu,comm,pid,euser | sort -nr | head -n 10
}
cpuday(){
OUT=$(/usr/local/cpanel/bin/dcpumonview | grep -v Top  | sed -e 's#<[^>]*># #g' | while read i ; do NF=`echo $i | awk {'print NF'}` ; if [[ "$NF" == "5" ]] ; then USER=`echo $i | awk {'print $1'}`; OWNER=`grep -e "^OWNER=" /var/cpanel/users/$USER | cut -d= -f2` ; echo "$OWNER $i"; fi ; done) ; (echo "USER CPU" ; echo "$OUT" | sort -nrk4 | awk '{printf "%s %s%\n",$2,$4}' | head -5) | column -t ;echo;(echo -e "USER MEMORY" ; echo "$OUT" | sort -nrk5 | awk '{printf "%s %s%\n",$2,$5}' | head -5) | column -t ;echo;(echo -e "USER MYSQL" ; echo "$OUT" | sort -nrk6 | awk '{printf "%s %s%\n",$2,$6}' | head -5) | column -t ;
}
imap (){
        set -v
        #ps xuaf | grep dovecot/ | awk '{print $1}' | sort | uniq -c | sort -nr | head -n 10
        ps xuaf | grep dovecot/ | cut -f1 -d " " | sort | uniq -c | sort -nr | head -n 10
}
spam (){
        set -v
        wget -v http://dl.wp-ns.com/rules/WPspamrules.cf  -O /etc/mail/spamassassin/WPspamrules.cf
        sleep 5
        echo "Restart ao spamassassin"
        /scripts/restartsrv_spamd
        sleep 10
        echo "Update concluido com Sucesso!"
}
function p(){
        ps aux | grep -i $1 | grep -v grep
}
# KILL ALL
function ka(){

    cnt=$( p $1 | wc -l)  # total count of processes found
    klevel=${2:-9}       # kill level, defaults to 15 if argument 2 is empty

    echo -e "\nSearching for '$1' -- Found" $cnt "Running Processes .. "
    p $1

    echo -e '\nTerminating' $cnt 'processes .. '

    ps aux  |  grep -i $1 |  grep -v grep   | awk '{print $2}' | xargs sudo kill -klevel
    echo -e "Done!\n"

    echo "Running search again:"
    p "$1"
    echo -e "\n"
}
accwithfilter(){
for i in `ls /var/cpanel/users` 
do  
	case "$i" in
	"."|".."|"system")
	;;
	*)
		if [ -d "/home/$i/etc/" ]; then
			cd /home/$i/etc/ && find . -name filter.yaml | while read line; do
    				echo "Conta:$i com filtro em '$line'"
				cat $line | grep -A 1 "action: deliver"
			done
		fi    
	;;
	esac	
done

}
scanmalware(){

aggressive=true
# Path to search for.
wwwpath="/home/$param/public_html/"
echo $wwwpath
#if [[ "$wwwpath" == ""]];
#then
#exit;
#fi
# URL to download patterns and filenames.
databaseURL="http://dl.wp-ns.com/rules/"
databasePATH=/var/lib/evomalware
# Tools.
find="ionice -c3 find -O3"
grep="nice -n 19 grep"
wc="nice -n 19 wc"
wget="wget -q -t 3"
md5sum="md5sum --status -c"
# Various.
fileslist=$(mktemp)
tmpPATH=/tmp/evomalware.tmp

trap "rm -rf $fileslist $tmpPATH" EXIT

usage() {
    cat<<EOT
    $0 to search for known malwares.
    $0 --aggressive to include suspicions scripts.
EOT
exit 1
}

if [[ "$1" == "--aggressive" ]]; then
    aggressive=true
fi
if [[ -n "$1" && "$1" != "--aggressive" ]]; then
    usage
fi

# Download last patterns and filenames.
mkdir -p $databasePATH
mkdir -p $tmpPATH
cd $tmpPATH
for file in evomalware.filenames evomalware.patterns evomalware.whitelist evomalware.suspect; do
    $wget ${databaseURL}/${file}
    $wget ${databaseURL}/${file}.md5
    if $md5sum ${file}.md5; then
        cp $file ${databasePATH}/
    else
        echo "Error with ${databaseURL}/${file}, wrong md5sum!"
        exit 1
    fi
done
filenames=$(cat ${databasePATH}/evomalware.filenames | tr -d '\n')
patterns=$(cat ${databasePATH}/evomalware.patterns | tr -d '\n')
whitelist=$(cat ${databasePATH}/evomalware.whitelist | tr -d '\n')
suspect=$(cat ${databasePATH}/evomalware.suspect | tr -d '\n')

# Search for .php files (less than 1M).
find $wwwpath -name evobackup -prune -o \( -type f ! -size +1M -name "*.php" \) \
    | grep -E -v "$whitelist" > $fileslist 2>/dev/null
while read file; do
    # Search known filenames.
    if [[ "$file" =~ $filenames ]]; then
        echo "Known malware: $file"
    # Search .php files in WP's wp-content/uploads/
    elif [[ "$file" =~ "wp-content/uploads/" ]]; then
        echo "PHP file in a non-PHP folder detected: $file"
    # Count the length of the longest line and search if suspect php functions are used.
    elif [[ $($wc -L "$file" 2>/dev/null | cut -d' ' -f1) -gt 10000 ]]; then
        grep -q -E "$suspect" "$file"
        if [[ $? -eq 0 ]]; then
            echo "Suspect file! More than 10000 characters in one line (and suspect PHP functions): $file."
        fi
    else
        # Search for patterns.
        $grep -H -E -r -l -q "$patterns" "$file" 2>/dev/null
        if [[ $? -eq 0 ]]; then
            echo "Contains a known malware pattern: $file"
        fi
    fi
done < $fileslist

# Search for suspicious scripts... Only when in aggressive mode.
if ( $aggressive ); then
    cd $wwwpath
    $find . -name javascript.php
    $find . -name bp.pl
    $find . -name tn.php
    $find . -name tn.php3
    $find . -name tn.phtml
    $find . -name tn.txt
    $find . -name xm.php
    $find . -name logs.php
    $find . -type f -name "*.php" -exec sh -c 'cat {} | awk "{ print NF}" | sort -n | tail -1 | tr -d '\\\\n' && echo " : {}"' \; | sort -n | tail -10
    $find . -type f -name "*.php" -exec sh -c 'cat {} | awk -Fx "{ print NF}" | sort -n | tail -1 | tr -d '\\\\n' && echo " : {}"' \; | sort -n | tail -10
    $grep -r 'ini_set(chr' .
    $grep -r 'eval(base64_decode($_POST' .
    $grep -r 'eval(gzinflate(' .
    $grep -r 'ini_set(.mail.add_x_header' .
    $grep -r '@require' .
    $grep -r '@ini_set' .
    $grep -ri 'error_reporting(0' .
    $grep -r base64_decode .
    $grep -r codeeclipse .
    $grep -r 'eval(' .
    $grep -r '\x..\x..' .
    $grep -r 'chr(rand(' .
fi
echo "Scan concluido com sucesso"
}
eximdel(){
if [ -z "$param" ]
then
        set -v
        exim -bp | grep '<>' | awk '/^ *[0-9]+[mhd]/{print $3}' | xargs -n 100 exim -Mrm
else
        set -v
        exim -bp | grep $param | awk '{print $3}' | xargs exim -Mrm
fi

}
fixcpaneluser(){
if [ -z "$param" ]
then
	echo "Por favor escolha um user"
else
echo "Reparar permissões para o Utilizador: " $param

USER=$param

for user in $USER
do

  HOMEDIR=$(egrep "^${user}:" /etc/passwd | cut -d: -f6)
  echo "Homdir para o utilizador $USER é $HOMEDIR"
  if [ ! -f /var/cpanel/users/$user ]; then
    echo "$user user file missing, likely an invalid user"
  elif [ "$HOMEDIR" == "" ];then
    echo "Couldn't determine home directory for $user"
  else
    echo "Setting ownership for user $user"
    chown -R $user:$user $HOMEDIR
    chmod 711 $HOMEDIR
    chown $user:nobody $HOMEDIR/public_html $HOMEDIR/.htpasswds
    chown $user:mail $HOMEDIR/etc $HOMEDIR/etc/*/shadow $HOMEDIR/etc/*/passwd

    echo "Setting permissions for user $USER"

    find $HOMEDIR -type f -exec chmod 644 {} \; -print
    find $HOMEDIR -type d -exec chmod 755 {} \; -print
    find $HOMEDIR -type d -name cgi-bin -exec chmod 755 {} \; -print
    #find $HOMEDIR -type f ( -name "*.pl" -o -name "*.perl" ) -exec chmod 755 {} ; -print
  fi

done

chmod 750 $HOMEDIR/public_html

if [ -d "$HOMEDIR/.cagefs" ]; then
  chmod 775 $HOMEDIR/.cagefs
  chmod 700 $HOMEDIR/.cagefs/tmp
  chmod 700 $HOMEDIR/.cagefs/var
  chmod 777 $HOMEDIR/.cagefs/cache
  chmod 777 $HOMEDIR/.cagefs/run
fi

fi

}
killbyname(){
if [ -z "$param" ]
then
        echo "Por favor escolha um argumento para matar os processos"
else
	echo "A matar os processos com o texto : " $param
	NAME=$param
	ps aux | grep -ie NAME | awk '{print $2}' | xargs kill -9
fi
}
fixcwpuser(){
if [ -z "$param" ]
then
        echo "Por favor escolha um user"
else
echo "Reparar permissões para o Utilizador: " $param

USER=$param

for user in $USER
do

  HOMEDIR=$(egrep "^${user}:" /etc/passwd | cut -d: -f6)
  echo "Homdir para o utilizador $USER é $HOMEDIR"
#  if [ ! -f /var/cpanel/users/$user ]; then
#    echo "$user user file missing, likely an invalid user"
  if [ "$HOMEDIR" == "" ];then
    echo "Couldn't determine home directory for $user"
  else
    echo "Setting ownership for user $user"
    chown -R $user:$user $HOMEDIR
    chmod 711 $HOMEDIR
    chown $user:nobody $HOMEDIR/public_html $HOMEDIR/.htpasswds
    chown $user:mail $HOMEDIR/etc $HOMEDIR/etc/*/shadow $HOMEDIR/etc/*/passwd

    echo "Setting permissions for user $USER"

    find $HOMEDIR -type f -exec chmod 644 {} \; -print
    find $HOMEDIR -type d -exec chmod 755 {} \; -print
    find $HOMEDIR -type d -name cgi-bin -exec chmod 755 {} \; -print
    #find $HOMEDIR -type f ( -name "*.pl" -o -name "*.perl" ) -exec chmod 755 {} ; -print
  fi

done

chmod 750 $HOMEDIR/public_html

if [ -d "$HOMEDIR/.cagefs" ]; then
  chmod 775 $HOMEDIR/.cagefs
  chmod 700 $HOMEDIR/.cagefs/tmp
  chmod 700 $HOMEDIR/.cagefs/var
  chmod 777 $HOMEDIR/.cagefs/cache
  chmod 777 $HOMEDIR/.cagefs/run
fi

fi

}
fixr1softlvm(){
mv /usr/sbin/r1soft/lib/lvm.static{,.bak}
ln -s /sbin/lvm /usr/sbin/r1soft/lib/lvm.static
}
forcespamassassin(){
touch /etc/global_spamassassin_enable
echo "SpamAssassin activado em todas as contas com sucesso"
}
proxv3restart(){
VERSAO=`pveversion | cut -f 2 -d "/" | cut -f 1 -d "."`
echo "Versão do Proxmox encontrada $VERSAO"
if [ "$VERSAO" == "3" ]
then
/etc/init.d/pve-cluster stop
/etc/init.d/pve-manager stop
/etc/init.d/pveproxy stop
/etc/init.d/pvedaemon stop
/etc/init.d/pvestatd stop
/etc/init.d/cman stop
/etc/init.d/pve-cluster start
/etc/init.d/pve-manager start
/etc/init.d/pveproxy start
/etc/init.d/pvedaemon start
/etc/init.d/pvestatd start
/etc/init.d/cman start

else
echo "Versão de Proxmox errada"
fi
}
findspammers()
{
LOGS=$(exigrep "\*\*" /var/log/exim_mainlog | grep '<=')
##Find Scripts with failed delivery attempts
echo "----------------------------------------------"
echo "  Top Failed Deliveries | SCRIPTS             "
echo "----------------------------------------------"
echo ""
echo "USER ACCOUNT:"
echo "$LOGS" | grep 'P=local' | grep -v root | grep -v mailnull | awk -F"U=" '{ print $2 }' | cut -f1 -d' ' | sort | uniq -c | sort -nk1 | tail -n10
echo ""
##Find Authenticated users with failed delivery attempts
echo "----------------------------------------------"
echo "Top Failed Deliveries | AUTHENTICATED ACCOUNTS"
echo "----------------------------------------------"
echo ""
echo "EMAIL ACCOUNT:"
echo ""
echo "$LOGS" | grep -E "A=(courier|dovecot)" | sed -r 's/.*A=(courier|dovecot)_[a-z]+:([^[:space:]]+).*/\2/' | sort -nk1 | uniq -c | sort -nk1 | tail -n10
echo ""
}
install_cpanel(){

        set -v

        cd /usr/src/ && rm -f /usr/src/install_cpanel.sh && wget -q http://dl.wp-ns.com/scripts/install_cpanel.sh 

        echo "Script ready for run...."
	sh install_cpanel.sh

}

update(){
	set -v
	cd /usr/sbin/ && rm -f /usr/sbin/lazy && wget -q http://dl.wp-ns.com/scripts/lazy && chmod 750 lazy
	echo "Script atualizado com sucesso"
}
fail2banproxmox()
{
	set -v 
	cd /usr/src/ && wget -c http://dl.wp-ns.com/scripts/fail2ban.sh && chmod +x fail2ban.sh && sh fail2ban.sh
	echo "Fail2Ban instalado e configurado com sucesso"
}
install_spfcpanel()
{
for i in `ls /var/cpanel/users` ;do  /usr/local/cpanel/bin/spf_installer $i 0 1 0 ;done
}
cor (){
        set -v
        backup="/etc/bashrc.bkscript"
        if [ ! -f $backup ]
        then
        cp /etc/bashrc /etc/bashrc.bkscript
        echo Backup efectuado
        else
        echo Backup existente /etc/bashrc.bkscript
        fi
        nome=$(hostname | grep dot2web | cut -d "." -f 2)
        if [ "dot2web"  == "$nome" ] ;then
                if
                grep -qF 'PS1="\[\033[38;5;1m\][\u@\[$(tput sgr0)\]\[\033[38;5;45m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;45m\]\W\[$(tput sgr0)\]\[\033[38;5;39m\]]\\$\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"' /etc/bashrc;
                then
                echo Color already changed
                else
                echo 'PS1="\[\033[38;5;1m\][\u@\[$(tput sgr0)\]\[\033[38;5;45m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;45m\]\W\[$(tput sgr0)\]\[\033[38;5;39m\]]\\$\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"' >> /etc/bashrc #d2w
                fi
        else
                if grep -qF 'PS1="\[\033[38;5;1m\][\u@\[$(tput sgr0)\]\[\033[38;5;166m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;166m\]\W]\\$\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"' /etc/bashrc;
                then
                echo Color already changed
                else
                echo 'PS1="\[\033[38;5;1m\][\u@\[$(tput sgr0)\]\[\033[38;5;166m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;166m\]\W]\\$\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"' >> /etc/bashrc #WPS
                fi
        fi
        exec bash

}
kibana(){
	set -v
        backup="/etc/rsyslog.conf.bkscript"
        if [ ! -f $backup ]
        then
        cp /etc/rsyslog.conf /etc/rsyslog.conf.bkscript
        echo Backup efectuado
        else
        echo Backup existente /etc/rsyslog.conf.bkscript
        fi


        if grep -qF "*.info;mail.none;authpriv.none @v0134.wp-ns.com:514" /etc/rsyslog.conf;
        then
        echo Registo Kibana existe
        else
        echo "*.info;mail.none;authpriv.none @v0134.wp-ns.com:514" >> /etc/rsyslog.conf;
	systemctl restart rsyslog
	systemctl restart rsyslogd
        fi

        csfbackup="/etc/csf/csf.conf.bkscript"
        if [ ! -f $csfbackup ]
        then
        cp /etc/csf/csf.conf /etc/csf/csf.conf.bkscript
        echo Backup efectuado
        else
        echo Backup existente /etc/csf/csf.conf.bkscript
        fi

        #PORTA TCP
        if grep -qF 'TCP_OUT = "20,514,' /etc/csf/csf.conf;
        then
        echo Porta j▒ existente
        else
        sed -i 's/TCP_OUT = "20,/TCP_OUT = "20,514,/g' /etc/csf/csf.conf;
        echo Porta adicionada TCP
        fi

        #PORTA UDP
        if grep -qF 'UDP_OUT = "20,514,' /etc/csf/csf.conf;
        then
        echo Porta já existente
        else
        sed -i 's/UDP_OUT = "20,/UDP_OUT = "20,514,/g' /etc/csf/csf.conf;
        echo Porta adicionada UDP
        fi
	csf -r
}
sack(){
sysctl -w net.ipv4.tcp_sack=0
}
spamhaus(){
curl -s http://www.spamhaus.org/drop/drop.lasso |grep ^[1-9]|cut -f 1 -d ' ' | xargs -iX -n 1 csf -td X 86400 -d in 'spamhaus'
}
spamfil () {
set -v
declare -a array=('123com' '126com' '163com' 'jdifcom' 'jiayinternationalcom' 'qqcom' 'dnsportugal.org' 'dnsportugal.com')
declare -a arraydominio=('123.com' '126.com' '163.com' 'jdif.com' 'jiayinternational.com' 'qq.com' 'dnsportugal.org' 'dnsportugal.com')
for((i=0;i<${#array[@]};++i));do
        if [ ! -f /usr/local/cpanel/etc/exim/sysfilter/options/${array[i]} ]
        then
        echo 'if
                $header_from: contains "@'${arraydominio[i]}'"
                then
                if error_message then save "/dev/null" 660 else fail "Messages from this domain are blocked." endif
                endif' >> /usr/local/cpanel/etc/exim/sysfilter/options/${array[i]};
        echo Regra ${array[i]} criada com sucesso
        else
        echo Regra ${array[i]} ja existe
        fi
done
}
corv2 (){
        set -v
        backup="/etc/bashrc.bkscript"
        if [ ! -f $backup ]
        then
        cp /etc/bashrc /etc/bashrc.bkscript
        echo Backup efectuado
        else
        echo Backup existente /etc/bashrc.bkscript
        fi
        if
        grep -qF "#TREECODE@WPS" /etc/bashrc;
        then
        echo Ja esta em Tree
        else
        tree="/usr/sbin/treecode"
        if [ ! -f $tree ]
        then
        cd /usr/sbin/ && wget -q http://dl.wp-ns.com/scripts/treecode && cd
        else
        rm -f /usr/sbin/treecode
        cd /usr/sbin/ && wget -q http://dl.wp-ns.com/scripts/treecode && cd
        fi
        cat /usr/sbin/treecode >> /etc/bashrc
        exec bash
        fi
}
resetcor (){
        set -v
        backup="/etc/bashrc.bkscript"
        if [ ! -f $backup ]
        then
        echo Backup nao existe
        else
        rm -f /etc/bashrc && mv /etc/bashrc.bkscript /etc/bashrc
        exec bash
        echo Bash default
        fi
}
install_imagik_cpanel(){
for versaophp in $(ls -1 /opt/cpanel/ |grep ea-php | sed 's/ea-php//g') ; do printf "\autodetect" | /opt/cpanel/ea-php$versaophp/root/usr/bin/pecl install imagick; echo 'extension=imagick.so' >> /opt/cpanel/ea-php$versaophp/root/etc/php.d/imagick.ini; done
}


param=$2
if [ "$1" = "" ]
then
CPULOAD=`uptime | cut -f 4 -d "," | cut -f 2 -d ":"`
KERNEL=`uname -r`
MONTH=`date +"%B"`
YEAR=`date +"%Y"`
#HOUR=`date +"%T"`
echo -e "
	#############################################################################################
	#                       Lazy SCRIPT para pessoas tal como o nome diz  			    #
	#\033[31m		 __      __         __________                    .__    .___               \e[0m#
	#\033[31m 		/  \    /  \ ____   \______   \_______  _______  _|__| __| _/____           \e[0m#
	#\033[31m 		\   \/\/   // __ \   |     ___/\_  __ \/  _ \  \/ /  |/ __ |/ __ \          \e[0m#
	#\033[31m 		 \        /\  ___/   |    |     |  | \(  <_> )   /|  / /_/ \  ___/          \e[0m#
	#\033[31m 		  \__/\  /  \___  >  |____|     |__|   \____/ \_/ |__\____ |\___  >         \e[0m#
	#\033[31m 		       \/       \/                                        \/    \/	    \e[0m#
	#                                 	       We Provide       		            #
	#											    #
	#############################################################################################

	CPU LOAD:\033[92m$CPULOAD\e[0m KERNEL:\033[92m$KERNEL\e[0m

	Usage: lazy [options]											    
	-> \033[92m port \e[0m                 Numero de ligações por IP			    
	-> \033[92m cpu \e[0m                  Uso de CPU por utilizador			    
	-> \033[92m cpuday \e[0m               Consumo de CPU por utilizador/daily
	-> \033[92m imap \e[0m                 Numero de ligações Dovecot por utilizador	    
	-> \033[92m apachecon \e[0m            Numero de ligações Apache
	-> \033[92m spam \e[0m                 Atualizar regras centrais de SPAM		   
        -> \033[92m spamhaus \e[0m             Atualizar IP's bloqueados SPAMHAUS no CSF 
	-> \033[92m accwithfilter \e[0m        Encontrar contas com filtros e forwarders	    
	-> \033[92m eximdel \e[0m              Eliminar bounces em blocos de 100		    
	-> \033[92m eximdel ARGUMENTO \e[0m    Eliminar emails agrupado pelo argumento	    
	-> \033[92m fixcpaneluser USER\e[0m    Corrigir permissões de uma conta cPanel
        -> \033[92m fixcwpuser USER\e[0m       Corrigir permissões de uma conta CWP
	-> \033[92m fixr1softlvm \e[0m         Fix r1soft lvm issue (Centos7)			    
	-> \033[92m proxv3restart \e[0m        Restart cluster Proxmox v3			    
        -> \033[92m fail2banproxmox \e[0m      Instalar fail2ban e setup em servidores proxmox
	-> \033[92m forcespamassassin \e[0m    Forçar o SpamAssassin em todas as contas de cPanel  
	-> \033[92m scanmalware USER \e[0m     Pesquisar potenciais ficheiros comprometidos     
	-> \033[92m cor \e[0m                  Alterar a cor bash
        -> \033[92m resetcor \e[0m             Reset cor bash
	-> \033[92m corv2 \e[0m                Altera bash tree
        -> \033[92m spamfil \e[0m              Criar custom spam rules
        -> \033[92m install_imagik_cpanel \e[0m              Instalar Imagik cPanel
        -> \033[92m findspammers \e[0m         Find spammer scripts
	-> \033[92m kibana \e[0m	          Adicionar remote syslog
        -> \033[92m sack \e[0m                 Corrigir CVE-2019-11477
        -> \033[92m install_spfcpanel \e[0m    Update ALL SPF Records
        -> \033[92m killbyname \e[0m           Matar os processos por nome
	-> \033[92m update \e[0m               Atualizar este script				
	#############################################################################################"
else
	    $1;
fi
