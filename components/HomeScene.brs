Sub init()
    m.RowList = m.top.findNode("RowList")
    m.Title = m.top.findNode("Title")
    m.Description = m.top.findNode("Description")
    m.Poster = m.top.findNode("Poster")

    m.RowList.setFocus(true)
    m.LoadTask = CreateObject("roSGNode", "FeedParser") 'Create XML Parsing task node
    m.LoadTask.control = "RUN" 'Run the task node
    m.LoadTask.observeField("content","rowListContentChanged")
    m.Video = m.top.findNode("Video")
    m.videoContent = createObject("roSGNode", "ContentNode")
    m.RowList.observeField("rowItemSelected", "playVideo")
End Sub

Sub rowListContentChanged()
     m.RowList.content = m.LoadTask.content
     m.RowList.observeField("rowItemFocused", "changeContent")
end Sub

Sub changeContent() 'Changes info to be displayed on the overhang
    contentItem = m.RowList.content.getChild(m.RowList.rowItemFocused[0]).getChild(m.RowList.rowItemFocused[1])
    'contentItem is a variable that points to (rowItemFocused[0]) which is the row, and rowItemFocused[1] which is the item index in the row

    m.top.backgroundUri = contentItem.HDPOSTERURL 'Sets Scene background to the image of the focused item
    m.Poster.uri = contentItem.HDPOSTERURL 'Sets overhang image to the image of the focused item
    m.Title.text = contentItem.TITLE 'Sets overhang title to the title of the focused item
    m.Description.text = contentItem.DESCRIPTION ' Sets overhang description to the description of the focused item
End Sub


Sub playVideo()
    m.videoContent.url = m.RowList.content.getChild(m.RowList.rowItemFocused[0]).getChild(m.RowList.rowItemFocused[1]).URL
    m.videoContent.streamFormat = "hls"
    print ">>>>"
    print m.videoContent.url
    print m.videoContent.streamFormat
    print "<<<<"
    'rowItemFocused[0] is the row and rowItemFocused[1] is the item index in the row

    m.Video.content = m.videoContent
    m.Video.visible = "true"
    m.Video.control = "play"
End Sub

Function onKeyEvent(key as String, press as Boolean) as Boolean 'Maps back button to leave video
    if press
    	if key = "back" 'If the back button is pressed
		m.Video.visible = "false" 'Hide video
		m.Video.control = "stop" 'Stop video from playing
		return true
        end if
    end if
end Function
