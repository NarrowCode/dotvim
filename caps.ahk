StartTime := A_TickCount
while GetKeyState("Capslock", "p")
  Send {Ctrl Down}
Send {Ctrl Up}
ElapsedTime := A_TickCount - StartTime
Tooltip %ElapsedTime%
If (ElapsedTime < 98)
  Send {Escape}
Return
