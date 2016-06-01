Run "C:\Program Files (x86)\Atlassian\SourceTree\SourceTree.exe"

WinWaitActive, Welcome ahk_exe SourceTree.exe
IfWinActive
{
	; Accept and continue
	Sleep 1000
	MouseClick, left, 245, 264
	MouseClick, left, 635, 381

	; Use an existing account
	Sleep 1000
	MouseClick, left, 429, 373 

	; Login with Atlassian credentials
	; For some reason the login dialog has no title
	SetTitleMatchMode, RegEx
	WinWaitActive, ^$ ahk_exe SourceTree.exe

	Sleep 3000
	SetKeyDelay 20

	Send c1922034@trbvn.com{tab}
	Send git-training{tab}
	MouseClick, left, 93, 359

	; Continue
	WinWaitActive, Welcome ahk_exe SourceTree.exe
	Sleep 1000
	MouseClick, left, 638, 377

	; Skip setup
	Sleep 1000
	MouseClick, left, 298, 380

	; No SSH keys
	WinWaitActive Load SSH Key?, , 1
	IfWinActive
	{
		MouseClick, left, 429, 114
	}

	; I don't want to use Mercurial
	Sleep 1000
	WinWaitActive SourceTree: Mercurial not found, , 1
	IfWinActive
	{
		MouseClick, left, 112, 193
	}

	; No bookmarks
	WinWaitActive, Create Bookmarks?, , 5
	IfWinActive
	{
		MouseClick, left, 670, 182
	}
}

Sleep 1000
WinWaitActive, SourceTree
WinClose

; Close putty
Process,Close,pageant.exe