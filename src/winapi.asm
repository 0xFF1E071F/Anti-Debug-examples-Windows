[bits 32]

global _main
extern _MessageBoxA@16
extern _IsDebuggerPresent@0
extern _CheckRemoteDebuggerPresent@8
extern _GetCurrentProcess@0
section .data

paramTextDEBUG   DB  "Close it right nao b4 its 2 late m8", 0
paramTitleDEBUG  DB  "Anti-Debug info", 0
paramText   DB  "You are not using debugger, good job", 0
paramTitle  DB  "Anti-Debug info", 0

section .text

_main:

; IsDebuggerPresent

call _IsDebuggerPresent@0
cmp eax, 1
je debugged

; CheckRemoteDebuggerPresent

call _GetCurrentProcess@0
sub esp, 4
push esp
push eax
call _CheckRemoteDebuggerPresent@8
mov ecx, [esp]
add esp, 4
cmp ecx, 1
je debugged

push 0x40
push paramTitle
push paramText
push 0
call _MessageBoxA@16
ret

debugged:
push 0x40
push paramTitleDEBUG
push paramTextDEBUG
push 0
call _MessageBoxA@16
ret

