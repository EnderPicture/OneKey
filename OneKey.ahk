#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
loop {
    if(FileExist("C:\Users\donny\Documents\Processing\sketch_180512a\key.txt"))
    {
        FileRead, ToType, C:\Users\donny\Documents\Processing\sketch_180512a\key.txt
        Formatted := SubStr(ToType,1,1)
        SendInput %Formatted%
        FileDelete, C:\Users\donny\Documents\Processing\sketch_180512a\key.txt
    }
}

