'*********************************************************************************************************  
' DISTRIBUTE A FILE ACROSS SEVERAL TARGET FOLDER
' ON VPS
'*********************************************************************************************************  



Option Explicit

Main

' To Run from Notepad++ , use Alt+SpaceBar

Sub Main()

Dim objLogFile , objFSO
Dim FileLogPath , FileLogName

Dim FileSourcePath , FileSourceName, _
    FileTargetPath , FileTargetName


'*********************************************************************************************************  
' INITIALISE LOG FILE
'*********************************************************************************************************  


  FileLogPath = "C:\Users\Administrator\Desktop"
  FileLogName = "LogCopyOperation.txt"

  Set objFSO      = CreateObject("Scripting.FileSystemObject")
  Set objLogFile = objFSO.CreateTextFile( FileLogPath & "\" & FileLogName , True)
  objLogFile.WriteLine("Created Log File " & FileLogPath & "\" & FileLogName )


'*********************************************************************************************************  
' DETERMINE SOURCE PATH AND SOURCE NAME
'*********************************************************************************************************  

  FileSourcePath = "C:\Users\Administrator\Desktop"
  FileSourceName = "MACDH_OnCalc.mq4"

  ' Log the source path
  objLogFile.WriteLine("Source path: " & FileSourcePath )


'*********************************************************************************************************  
' PERFORM COPYING HERE
'*********************************************************************************************************  

' Copy block here
  
  Call CopyFileToTarget(objLogFile, FileSourcePath , "C:\MetaTrader4\T1_1_GBPJPY\MQL4\Indicators" , FileSourceName )
  Call CopyFileToTarget(objLogFile, FileSourcePath , "C:\MetaTrader4\T1_2_EURJPY\MQL4\Indicators" , FileSourceName )
  Call CopyFileToTarget(objLogFile, FileSourcePath , "C:\MetaTrader4\T1_3_EURCAD\MQL4\Indicators" , FileSourceName )
  Call CopyFileToTarget(objLogFile, FileSourcePath , "C:\MetaTrader4\T1_4_AUDJPY\MQL4\Indicators" , FileSourceName )
  
  Call CopyFileToTarget(objLogFile, FileSourcePath , "C:\MetaTrader4\T2_1_EURUSD\MQL4\Indicators" , FileSourceName )
  Call CopyFileToTarget(objLogFile, FileSourcePath , "C:\MetaTrader4\T2_2_GBPUSD\MQL4\Indicators" , FileSourceName )
  Call CopyFileToTarget(objLogFile, FileSourcePath , "C:\MetaTrader4\T2_3_AUDUSD\MQL4\Indicators" , FileSourceName )
  Call CopyFileToTarget(objLogFile, FileSourcePath , "C:\MetaTrader4\T2_4_USDJPY\MQL4\Indicators" , FileSourceName )



'*********************************************************************************************************  
' CLOSE LOG FILE, OPEN LOG FILE, AND QUIT THE SCRIPT
'*********************************************************************************************************  
  
' Finalisation and closing block here
  objLogFile.Close
  Call OpenLogFile( FileLogPath & "\" & FileLogName )
  Wscript.Quit

End Sub


Sub CopyFileToTarget(objLogFile,  FileSourcePath , FileTargetPath , FileSourceName )
  Dim objFileCopy, objFSO

  Set objFSO      = CreateObject("Scripting.FileSystemObject")
  Set objFileCopy = objFSO.GetFile(FileSourcePath & "\" & FileSourceName)
  objFileCopy.Copy (FileTargetPath & "\" & FileSourceName )
  set objFSO = Nothing
  set objFileCopy = Nothing

  objLogFile.WriteLine("Copied to " &    FileTargetPath & "\" & FileSourceName )

End Sub


Sub OpenLogFile( strFPathAndName )
  Dim oShell
  Set oShell = WScript.CreateObject("WScript.Shell")
  oShell.run "Notepad.exe " & strFPathAndName
  Set oShell = Nothing
End Sub