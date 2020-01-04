# function for new game to reset with password 
function newgame(){

$path = $env:temp
$null=new-item -path $path\acc.txt -ItemType file -force
$null=new-item -path $path\pass.txt -ItemType file -force
$null=new-item -path $path\highscore.txt -ItemType file -force
$null=new-item -path $path\name.txt -ItemType file -force


set-content -path $path\pass.txt -value z10n101
set-content -path $path\acc.txt -value 20000
set-content -path $path\highscore.txt -value "5000000"
set-content -path $path\name.txt -value "skysoft501"


$newpass=get-content -path $path\pass.txt

for ($i=2;$i -ge 0;$i--) {

write-host Enter Default Access Code -ForegroundColor Green
$readnewpass=read-host
if ($readnewpass -eq $newpass) {

[console]::beep(500,500)
[console]::beep(800,900)

write-host Access Granted! loading menu... -foregroundcolor yellow

start-sleep -Seconds 4

cls

menu


}

if ($readnewpass -ne $newpass) {
write-host you have $i more attempt -ForegroundColor Green

}

if ($i -eq 0) {

[console]::beep(800,500)
[console]::beep(500,500)
[console]::beep(400,900)

write-host program exiting -ForegroundColor Green
exit
}
}
}

# Introdution Login

function intro() {

$path = $env:temp
if ((test-path -Path $path\pass.txt) -ne 'True') {
newgame
}

$test=test-path -Path $path\pass.txt 
if ($test -eq 'true') {


$pass = get-content -path $path\pass.txt

for ($i=2;$i -ge 0;$i--) {

[console]::beep(400,500)
[console]::beep(800,900)

write-host Record Found Enter Access Code. You have $i attempts -ForegroundColor Green
$passw=read-host

if ($passw -eq $pass) {

write-host WELCOME...Loading Menu -ForegroundColor Yellow
start-sleep -seconds 7
cls
menu
}

}
}
}


# Main Gameplay

function engine {

[console]::beep(700,900)

$path = $env:temp
$acc = get-content -path $path\acc.txt
[int]$acc = [convert]::toint32($acc, 10)



do {

write-host
write-host you acc balance is $acc Bits -ForegroundColor magenta
start-sleep -Seconds 4
write-host bet must be either 2000 4000 8000 10000 Bits you cant bet more than your balance -ForegroundColor green



do { 

write-host enter Bet. Must be either 2000 4000 8000 10000 Bits you cant bet more than your balance -ForegroundColor cyan

$bet=read-host
[int]$bet = [convert]::toint32($bet, 10)

if (($bet -eq 2000) -or ($bet -eq 4000) -or ($bet -eq 8000) -or ($bet -eq 10000) -and ($acc -ge $bet) ) {

write-host bet successfully placed -ForegroundColor green
}
}

while (($bet -ne 2000) -and ($bet -ne 4000) -and ($bet -ne 8000) -and ($bet -ne 10000) -or ($acc -lt $bet) )

do {

start-sleep -Seconds 4

write-host you can only predict 1-6 -ForegroundColor magenta

[console]::beep(500,900)

write-host enter dice prediction
$dice=read-host

if (($dice -eq 1) -or ($dice -eq 2) -or ($dice -eq 3) -or ($dice -eq 4) -or ($dice -eq 5)-or ($dice -eq 6)) {


write-host Prediction Taken Processing Bet..Good luck

start-sleep -Seconds 6

}
}
while (($dice -ne 1) -and ($dice -ne 2) -and ($dice -ne 3) -and ($dice -ne 4) -and ($dice -ne 5)-and ($dice -ne 6))


$acc=$acc - $bet

set-content -path $path\acc.txt -value $acc -force

$rand=Get-Random -Maximum 7 -Minimum 1

if ($dice -eq $rand) {

$win = $bet * 10

$acc = $acc + $win
write-host

write-host CONGRATULATIONS!!! YOU WON $win Bits!!! -ForegroundColor green

[console]::beep(500,900)
[console]::beep(800,900)

set-content -path $path\acc.txt -value $acc -force

}

if ($acc -gt (get-content -path $path\highscore.txt)) {
write-host
write-host ========================================================= -foregroundcolor cyan
write-host NEW HIGH SCORE..GREAT JOB GEEK!!! YOU RULE THIS CASINO!!!
write-host ========================================================= -foregroundcolor cyan

[console]::beep(1000,9000)

set-content -path $path\highscore.txt -value $acc
set-content -path $path\name.txt -value $name

}

elseif($dice -ne $rand) {
write-host

write-host SORRY GEEK..YOU LOST $bet Bits -foregroundcolor red


[console]::beep(400,900)
[console]::beep(300,900)

}


}
while ($acc -ge 2000)

if ($acc -lt 2000) {

write-host insuffiecnt balance. You are not the one. logging out -ForegroundColor DarkRed
[console]::beep(400,900)
[console]::beep(300,9000)
exit

}
}

# menu choice

function menu () {


write-host "                                         ========================================================" -foregroundcolor green
write-host "                                         =     Menu                                       Press = " -foregroundcolor green
write-host "                                         =                                                      = " -foregroundcolor green
write-host "                                         =     Reset Game                                   1   = " -foregroundcolor green
write-host "                                         =                                                      = " -foregroundcolor green
write-host "                                         =     Load Game                                    2   = " -foregroundcolor green
write-host "                                         =                                                      = " -foregroundcolor green
write-host "                                         =     High Score                                   3   = " -foregroundcolor green
write-host "                                         =                                                      = " -foregroundcolor green
write-host "                                         =     Change Access Code                           4   = " -foregroundcolor green
write-host "                                         =                                                      = " -foregroundcolor green
write-host "                                         =     Log Out                                      5   = " -foregroundcolor green
write-host "                                         ========================================================" -foregroundcolor green

[console]::beep(700,900)
[console]::beep(700,900)
[console]::beep(700,2000)
write-host Choose Option -foregroundcolor magenta
$choice=read-host 

if ($choice -eq 1) {
newgame
}

if ($choice -eq 2) {
engine
}

if ($choice -eq 3) {



write-host CASINO CHAMPION -ForegroundColor Cyan
write-host ======================== -ForegroundColor Yellow
get-content -path $path\name.txt
get-content -path $path\highscore.txt
write-host ======================== -ForegroundColor Yellow
[console]::beep(400,500)
[console]::beep(500,500)
[console]::beep(800,3000)
pause
cls
menu

}


if ($choice -eq 4) {
access
}


if ($choice -eq 5) {
write-host Logging You Out -ForegroundColor yellow
write-host Disconnecting......... -ForegroundColor Red
[console]::beep(400,2000)
exit
}

if (($choice -ne 1) -and ($choice -ne 2) -and ($choice -ne 3) -and ($choice -ne 4) -and ($choice -ne $5) ) {

cls
menu
}
}

# Password Login

function access() {

$path = $env:temp
$existpass = get-content -path $path\pass.txt

write-host Enter Old Access Code -ForegroundColor Cyan
$oldpass=read-host

if ($oldpass -eq $existpass) {

write-host Enter New Access Code
$newpass=read-host

set-content -path $path\pass.txt -value $newpass -force

write-host Access Code Succcessfuly Changed -foregroundcolor yellow
[console]::beep(2000,900)
cls
menu

}

if ($oldpass -ne $existpass) {

write-host Incorrect Access code..Redirecting You Back To Menu -ForegroundColor green
[console]::beep(500,900)
cls
menu
}
}












































$host.ui.rawui.windowtitle="© BIOS-COUNTY"
add-type -assemblyname system.speech
$speaker=new-object system.speech.synthesis.speechsynthesizer
$date=get-date
write-host Welcome To BIOS County Casino..The Low Level Land Of Geeks -ForegroundColor Cyan

[console]::beep(400,500)
[console]::beep(500,500)
[console]::beep(800,900)

write-host
write-host Name? -ForegroundColor Magenta
$name=read-host
intro