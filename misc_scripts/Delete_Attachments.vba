Select the email items for which you want to delete the attachments.  
Press F11 to open VBA
Paste in the following code
Hit Play (press F5).


Public Sub ReplaceAttachmentsToLink()
Dim objApp As Outlook.Application
'Dim aMail As Outlook.MailItem 'Object
Dim oAttachments As Outlook.Attachments
Dim oSelection As Outlook.Selection
Dim i As Long
Dim iCount As Long
   
    ' Instantiate an Outlook Application object.
    Set objApp = CreateObject("Outlook.Application")
  
    ' Get the collection of selected objects.
    Set oSelection = objApp.ActiveExplorer.Selection
  
    ' Check each selected item for attachments. If attachments exist,
    ' save them to the Temp folder and strip them from the item.
    For Each aMail In oSelection
  
    ' This code only strips attachments from mail items.
    ' If aMail.class=olMail Then
    ' Get the Attachments collection of the item.
    Set oAttachments = aMail.Attachments
    iCount = oAttachments.Count
      
        
    If iCount > 0 Then
      
        ' We need to use a count down loop for removing items
        ' from a collection. Otherwise, the loop counter gets
        ' confused and only every other item is removed.
          
        For i = iCount To 1 Step -1
          
            ' Delete the attachment.
            oAttachments.Item(i).Delete
                          
        Next i
        'End If
                     
       aMail.Save
     
    End If
    Next 'end aMail
      
ExitSub:
  
Set oAttachments = Nothing
Set aMail = Nothing
Set oSelection = Nothing
Set objApp = Nothing
End Sub


