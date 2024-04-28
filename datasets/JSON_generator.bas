Sub JSON_generator()
    'Public Structure Color
    '    Public ColorName As String
    '    Public ColorPercentage As Integer
    'End Structure
    Const vbDoublequote As String = """"
    Const namerow As Integer = 1
    Const datanamerow As Integer = 2
    Const authorrow As Integer = 3
    Const daterow As Integer = 4
    Const colorrow As Integer = 5
    Const typerow As Integer = 6
    Const widthrow As Integer = 7
    Const heightrow As Integer = 8
    Const topicrow As Integer = 9
    Const materialrow As Integer = 10
    Const techniquerow As Integer = 11
    Const grouprow As Integer = 12
    Const forcemultiplier As Integer = 3
    
    Dim outputstr As String
    Dim nodenr As Integer

    Set fs = CreateObject("Scripting.FileSystemObject")
    Set outfile = fs.CreateTextFile(ThisWorkbook.Path & "\ArtPortfolio.json", True)
    nodenr = 0
    linknr = 0
    outputstr = outputstr & "{" & vbCrLf
    outputstr = outputstr & vbTab & vbDoublequote & "nodes" & vbDoublequote & ": [" & vbCrLf
    For i = 2 To Cells(Rows.Count - 1, datanamerow).End(xlUp).Row
        outputstr = outputstr & vbTab & vbTab & "{" _
        & vbDoublequote & "id" & vbDoublequote & ": " & vbDoublequote & Cells(i, namerow).Value & vbDoublequote & ", " _
        & vbDoublequote & "author" & vbDoublequote & ": " & vbDoublequote & Cells(i, authorrow).Value & vbDoublequote & ", " _
        & vbDoublequote & "date" & vbDoublequote & ": " & vbDoublequote & Cells(i, daterow).Value & vbDoublequote & ", " _
        & vbDoublequote & "type" & vbDoublequote & ": " & vbDoublequote & Cells(i, typerow).Value & vbDoublequote & ", " _
        & vbDoublequote & "picture" & vbDoublequote & ": " & vbDoublequote & Cells(i, datanamerow).Value & vbDoublequote & ", " _
        & vbDoublequote & "width" & vbDoublequote & ": " & Cells(i, widthrow).Value & ", " _
        & vbDoublequote & "height" & vbDoublequote & ": " & Cells(i, heightrow).Value _
        & "}," & vbCrLf
        nodenr = nodenr + 1
    Next
    If nodenr > 0 Then
        outputstr = Left(outputstr, Len(outputstr) - 3)
        outputstr = outputstr & vbCrLf
    End If
    outputstr = outputstr & vbTab & "]," & vbCrLf
    outputstr = outputstr & vbTab & vbDoublequote & "links" & vbDoublequote & ": [" & vbCrLf
    For j = 2 To Cells(Rows.Count, datanamerow).End(xlUp).Row
        Dim source() As String
        source = Split(Cells(j, topicrow).Value, ", ")
        For k = j + 1 To Cells(Rows.Count, datanamerow).End(xlUp).Row
            Dim target() As String
            target = Split(Cells(k, topicrow).Value, ", ")
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
                & vbDoublequote & "source" & vbDoublequote & ": " & vbDoublequote & Cells(j, datanamerow) & vbDoublequote & ", " _
                & vbDoublequote & "target" & vbDoublequote & ": " & vbDoublequote & Cells(k, datanamerow) & vbDoublequote & ", " _
                & vbDoublequote & "value" & vbDoublequote & ": " & l * forcemultiplier _
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
