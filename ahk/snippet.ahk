#Requires AutoHotkey v2.0
#SingleInstance Force

#Hotstring SE K10   ; use SendEvent + small key delay for reliability [web:60][web:63]

; --- PART 1: Static Snippets (Simple Hotstrings) ---
; Syntax: ::trigger::replacement
; NOTE: The trigger requires a space/enter/punctuation after it to fire, 
; which is the standard AHK behavior and similar to Espanso's default.

:*?::email::webbacillus@gmail.com
:*?::name::Pasit Khumsena
:*?::tname::พสิษฐ์ คำเสนา
:*?::phone::0918683540
:*?::sid::6633162221
:*?::cid::1449900785007
:*?::address::38 ซอยเกษมสันต์1 แขวงวังใหม่ เขตปทุมวัน กรุงเทพมหานคร 10330

; --- PART 2: Snippet with Cursor Position ---
; The '$' option prevents the script from sending a final space/enter after replacement.

:*?::center::<center></center>{Left 8}

; ; --- PART 3: Dynamic Snippets (Date/Time & Shell) ---
; ; For dynamic content, we use a Hotstring that runs a block of code.
;
; ; 1. Print the current date (:today)
; ; Espanso format: "%d %b %Y, %A" -> Example: 23 Nov 2025, Sunday
; :: :today::
; {
;     date := A_DD . " " . A_MMMM . " " . A_YYYY
;     SendText(date)
;     return
; }
;
; ; 2. Print the current time (:now)
; ; Espanso format: "%H:%M" -> Example: 09:44
; :: :now::
; {
;     ; H: 24-hour format, M: minute
;     SendInput %FormatTime(A_Now, "HH:mm")%
;     Return
; }
;
:*?::rand::
{
    ; --- Configuration ---
    BytesToGenerate := 6 ; Requesting 6 cryptographically strong bytes
    hProv := 0           ; Initialize provider handle

    ; --- 1. Acquire Cryptographic Context (CryptAcquireContext) ---
    pProv := Buffer(8, 0) ; Buffer to hold the provider handle (64-bit size)

    ; Call CryptAcquireContext (advapi32.dll)
    ; dwProvType = 1 (PROV_RSA_FULL)
    ; dwFlags = 0xF0000000 (CRYPT_VERIFYCONTEXT - best for simple random generation)
    Result := DllCall("advapi32\CryptAcquireContext",
        "Ptr", pProv, 
        "Ptr", 0, 
        "Ptr", 0, 
        "UInt", 1,
        "UInt", 0xF0000000,
        "Int") 

    If (!Result) {
        MsgBox("Error: Failed to acquire cryptographic context (Error " . A_LastError . ")", "CSPRNG Error")
        return
    }

    hProv := NumGet(pProv, 0, "UPtr") ; Extract the handle value

    ; --- 2. Generate Random Bytes (CryptGenRandom) ---
    RandomBuffer := Buffer(BytesToGenerate, 0) ; Create buffer for 6 bytes

    ; Call CryptGenRandom
    Result := DllCall("advapi32\CryptGenRandom",
        "UPtr", hProv,
        "UInt", BytesToGenerate,
        "Ptr", RandomBuffer,
        "Int")

    ; --- 3. Cleanup ---
    DllCall("advapi32\CryptReleaseContext", "UPtr", hProv, "UInt", 0)

    ; --- 4. Output Processing ---

    If (Result) {
        ; Convert the raw buffer bytes into a readable hexadecimal string
        HexHash := ""
        Loop BytesToGenerate
        {
            ByteValue := NumGet(RandomBuffer, A_Index - 1, "UChar")
            HexHash .= Format("{:02X}", ByteValue)
        }

        ; 1. Copy the result to the clipboard
        A_Clipboard := HexHash

        ; 2. Send the result via keyboard simulation
        Send "{Text}" . HexHash

        ; Confirmation tooltip
        ToolTip "Sent and Copied: " HexHash, 10, 10
        SetTimer () => ToolTip(), -1000 ; Hide the ToolTip after 1 second

    } Else {
        MsgBox("Error: Failed to generate random bytes (Error " . A_LastError . ")", "CSPRNG Error")
    }
}
