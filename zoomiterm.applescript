on getTargetSession(argv)
	if 0 < (count of argv) then
		return item 1 of argv
	else
		return "zsh"
	end if
end getTargetSession

on launchSession(sessionName)
	tell application "iTerm"
		activate
		-- find terminal
		-- if there are no terminals, make new terminal.
		set countOfTerminal to (get count of terminal)
		local MyTerm
		if 0 < countOfTerminal then
			set MyTerm to (get terminal 0)
		else
			set MyTerm to (make new terminal)
		end if
		
		-- open session.
		tell MyTerm
			launch session sessionName
		end tell
		
		-- if the window is not zoomed, zoom the window.
		set myWindow to get window 0
		if get zoomable of myWindow then
			if not (get zoomed of myWindow) then
				set (zoomed of myWindow) to true
			end if
		end if
	end tell
end launchSession

on run argv
	set TargetSession to getTargetSession(argv)
	launchSession(TargetSession)
end run

