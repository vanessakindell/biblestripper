SuperStrict
Framework brl.standardio
Import BRL.FileSystem
Import BRL.Retro

?Linux
Import "-ldl"
?

Local filein:TStream = OpenFile("input.txt")
Local fileout:TStream = WriteFile("output.txt")

If Not filein
	Print "ERROR: input.txt could not be found"
	End
EndIf

Local sub$
Local firstspace:Int
Local outline$
Local prevspace:Int
Local nextspace:Int
Local a:Int
Local subset$

Print "Working..."
While Not Eof(filein)
	sub$ = ReadLine(filein)
	If(sub$<>"")
		'Strip first chapter/verse
		firstspace = Instr(sub$," ")
		If Instr(Left(sub$,firstspace),":")
			outline$ = Mid(sub$,firstspace+1)
		Else
			outline$ = sub$
		EndIf
		For a = 0 To Len outline$
			If Mid(outline$,a,1)=":"
				prevspace=Instr(outline$," ",a-4)
				nextspace=Instr(outline$," ",a)
				If nextspace = 0 Then nextspace = Len outline$+1
				subset$=Mid(outline$,prevspace,nextspace-prevspace)				
				If Int(subset$)>0
					outline$ = Left(outline$,prevspace-1)+Mid(outline$,nextspace)
				EndIf
			EndIf
		Next
		
		WriteLine(fileout:TStream, Upper(outline$))
	EndIf
Wend
CloseStream filein
CloseStream fileout
Print "Done."

End