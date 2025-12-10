#Requires AutoHotkey v2.0
#SingleInstance Force

#Hotstring SE K10   ; use SendEvent + small key delay for reliability [web:60][web:63]
#HotIf WinActive("ahk_exe Obsidian.exe")  ; only when Obsidian is focused [web:92][web:100]

:*?::cb::
{
    SendInput "``````{Enter}{Enter}``````"
    SendInput "{Up 2}"
}

:*?::code::
{
    SendInput "````"
    SendInput "{Left}"
}

:*?::lb::
{
    SendInput "$${Enter}{Enter}$$"
    SendInput "{Up}"
}

:*?::ll::
{
    SendInput "$$"
    SendInput "{Left}"
}

:*?::%::
{
    SendInput "%%{Enter}{Enter}%%"
    SendInput "{Up}"
}

:*?::flow::
{
    SendInput "``````mermaid{Enter}flowchart{Enter}``````"
    SendInput "{Up}{End} "
}

:*?::seq::
{
    SendInput "``````mermaid{Enter}sequenceDiagram{Enter}{Enter}``````"
    SendInput "{Up}"
}


:*?::char::
{
    SendInput "{#}{#} Characteristic{Enter}{Enter}"
}
:*?::def::
{
    SendInput "{#}{#} Definition{Enter}{Enter}"
}


#HotIf  ; end context, later hotkeys/hotstrings work everywhere [web:89][web:101]
