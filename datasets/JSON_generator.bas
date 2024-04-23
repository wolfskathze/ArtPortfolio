Attribute VB_Name = "Modul1"
Sub JSON_generator()
    'Public Structure Color
    '    Public ColorName As String
    '    Public ColorPercentage As Integer
    'End Structure
    Const vbDoublequote As String = """"
    Dim outputstr As String
    Dim nodenr As Integer
    Dim linknr As Integer
    Set fs = CreateObject("Scripting.FileSystemObject")
    Set outfile = fs.CreateTextFile(ThisWorkbook.Path & "\ArtPortfolio.json", True)
    nodenr = 0
    linknr = 0
    outputstr = outputstr & "{" & vbCrLf
    outputstr = outputstr & vbTab & vbDoublequote & "nodes" & vbDoublequote & ": [" & vbCrLf
    For i = 2 To Cells(Rows.Count - 1, 1).End(xlUp).Row
        outputstr = outputstr & vbTab & vbTab & "{" _
        & vbDoublequote & "id" & vbDoublequote & ": " & vbDoublequote & Cells(i, 1).Value & vbDoublequote & ", " _
        & vbDoublequote & "author" & vbDoublequote & ": " & vbDoublequote & Cells(i, 3).Value & vbDoublequote & ", " _
        & vbDoublequote & "date" & vbDoublequote & ": " & vbDoublequote & Cells(i, 4).Value & vbDoublequote & ", " _
        & vbDoublequote & "type" & vbDoublequote & ": " & vbDoublequote & Cells(i, 6).Value & vbDoublequote & ", " _
        & vbDoublequote & "picture" & vbDoublequote & ": " & vbDoublequote & Cells(i, 1).Value & Cells(i, 2).Value & vbDoublequote & ", " _
        & vbDoublequote & "width" & vbDoublequote & ": " & Cells(i, 7).Value & ", " _
        & vbDoublequote & "height" & vbDoublequote & ": " & Cells(i, 8).Value _
        & "}," & vbCrLf
        nodenr = nodenr + 1
    Next
    If nodenr > 0 Then
        outputstr = Left(outputstr, Len(outputstr) - 3)
        outputstr = outputstr & vbCrLf
    End If
    outputstr = outputstr & vbTab & "]," & vbCrLf
    outputstr = outputstr & vbTab & vbDoublequote & "links" & vbDoublequote & ": [" & vbCrLf
    For j = 2 To Cells(Rows.Count, 1).End(xlUp).Row
        Dim source() As String
        source = Split(Cells(j, 9).Value, ",")
        For k = j + 1 To Cells(Rows.Count, 1).End(xlUp).Row
            Dim target() As String
            target = Split(Cells(k, 9).Value, ",")
            Dim sourcecompare As Variant
            Dim l As Integer
            l = 0
            For Each sourcecompare In source
                Dim targetcompare As Variant
                For Each targetcompare In target
                    If sourcecompare = targetcompare Then
                        l = l + 1
                    End If
                Next
            Next
            If l > 0 Then
                outputstr = outputstr & vbTab & vbTab & "{" _
                & vbDoublequote & "source" & vbDoublequote & ": " & vbDoublequote & Cells(j, 1) & vbDoublequote & ", " _
                & vbDoublequote & "target" & vbDoublequote & ": " & vbDoublequote & Cells(k, 1) & vbDoublequote & ", " _
                & vbDoublequote & "value" & vbDoublequote & ": " & l _
                & "}," & vbCrLf
                linknr = linknr + 1
            End If
        Next
    Next
    If linknr > 0 Then
        outputstr = Left(outputstr, Len(outputstr) - 3)
        outputstr = outputstr & vbCrLf
    End If
    outputstr = outputstr & vbTab & "]" & vbCrLf
    outputstr = outputstr & "}" & vbCrLf
    
    outfile.Write outputstr
    outfile.Close
End Sub
