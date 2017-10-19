' CopyFSO.vbs
' Example VBScript for manipulating files.
' Author Guy Thomas http://computerperformance.co.uk/
' Version 3.4 - 4th July 2004
' ----------------------------------------------------------
Option Explicit

Main

' To Run from Notepad++ , use Alt+SpaceBar

Sub Main()

Dim objLogFile , objFSO
Dim FileLogPath , FileLogName 
    
Dim FileSourcePath , FileSourceName, _
    FileTargetPath , FileTargetName 



  FileLogPath = "C:\Users\Hendy\Desktop"
  FileLogName = "LogCopyOperation.txt"

  FileSourcePath = "C:\MetaTrader4\T1_3_EURCAD\MQL4\Experts"
  FileSourceName = "Powertool 4 (proty.2 build.2) - PMultiple - HiddenStopTarget - LongAndShort.mq4"
  
  FileTargetPath = "Z:"
  FileTargetName = FileSourceName
  
  Set objFSO      = CreateObject("Scripting.FileSystemObject")
  Set objLogFile = objFSO.CreateTextFile( FileLogPath & "\" & FileLogName , True)
  objLogFile.WriteLine("Created Log File " & FileLogPath & "\" & FileLogName ) 
  
  
  
  
 
' Copy block here

  objLogFile.WriteLine("Source path: " & FileSourcePath )
 
  Call CopyFileToTarget(FileSourcePath , FileTargetPath , FileSourceName )
  objLogFile.WriteLine("Copied to " & FileTargetPath & "\" & FileSourceName ) 
    
  Call CopyFileToTarget(FileSourcePath , "C:\MetaTrader4\T1_1_GBPJPY\MQL4\Experts" , FileSourceName )
  objLogFile.WriteLine("Copied to " &    "C:\MetaTrader4\T1_1_GBPJPY\MQL4\Experts" & "\" & FileSourceName ) 
  
  Call CopyFileToTarget(FileSourcePath , "C:\MetaTrader4\T1_2_EURJPY\MQL4\Experts" , FileSourceName )
  objLogFile.WriteLine("Copied to " &    "C:\MetaTrader4\T1_2_EURJPY\MQL4\Experts" & "\" & FileSourceName ) 

  Call CopyFileToTarget(FileSourcePath , "C:\MetaTrader4\T1_4_AUDJPY\MQL4\Experts" , FileSourceName )
  objLogFile.WriteLine("Copied to " &    "C:\MetaTrader4\T1_4_AUDJPY\MQL4\Experts" & "\" & FileSourceName ) 
  
  Call CopyFileToTarget(FileSourcePath , "C:\MetaTrader4\T2_1_EURUSD\MQL4\Experts" , FileSourceName )
  objLogFile.WriteLine("Copied to " &    "C:\MetaTrader4\T2_1_EURUSD\MQL4\Experts" & "\" & FileSourceName ) 

  Call CopyFileToTarget(FileSourcePath , "C:\MetaTrader4\T2_2_GBPUSD\MQL4\Experts" , FileSourceName )
  objLogFile.WriteLine("Copied to " &    "C:\MetaTrader4\T2_2_GBPUSD\MQL4\Experts" & "\" & FileSourceName ) 

  Call CopyFileToTarget(FileSourcePath , "C:\MetaTrader4\T2_3_AUDUSD\MQL4\Experts" , FileSourceName )
  objLogFile.WriteLine("Copied to " &    "C:\MetaTrader4\T2_3_AUDUSD\MQL4\Experts" & "\" & FileSourceName ) 
  
  Call CopyFileToTarget(FileSourcePath , "C:\MetaTrader4\T2_4_USDJPY\MQL4\Experts" , FileSourceName )
  objLogFile.WriteLine("Copied to " &    "C:\MetaTrader4\T2_4_USDJPY\MQL4\Experts" & "\" & FileSourceName ) 

 
  
  
' Finalisation and closing block here
  
  objLogFile.Close  

  Call OpenLogFile( FileLogPath & "\" & FileLogName )    
  Wscript.Quit

End Sub


Sub CopyFileToTarget(FileSourcePath , FileTargetPath , FileSourceName )
  Dim objFileCopy, objFSO
  Set objFSO      = CreateObject("Scripting.FileSystemObject")
  Set objFileCopy = objFSO.GetFile(FileSourcePath & "\" & FileSourceName)  
  objFileCopy.Copy (FileTargetPath & "\" & FileSourceName )    
  set objFSO = Nothing
  set objFileCopy = Nothing
End Sub


Sub OpenLogFile( strFPathAndName )
  Dim oShell 
  Set oShell = WScript.CreateObject("WScript.Shell")
  oShell.run "Notepad.exe " & strFPathAndName
  Set oShell = Nothing 
End Sub