local function boot_handleBootElement(str)
   local s1 = "                                           "
   local n1 = s1:len()
   local n2 = str:len()
   local s2 = string.sub(s1, 1, n1-n2)
   return " "..str..s2.." "
end

local function boot_mprint(array, this, x, y, h, g)
   local c1 = term.getBackgroundColor()
   local c2 = term.getTextColor()
   term.setTextColor(colors.lightGray)
   for i = 1, #array do
      term.setCursorPos(x, y)
      --Check if option selected
      if i == this then 
      --Option selected   
         term.setBackgroundColor(h)
         term.setTextColor(g)
      else 
      --Option NOT selected 
         term.setBackgroundColor(g)
         term.setTextColor(h)
      end
      --Print the string
      term.write(boot_handleBootElement(array[i]))
      y = y + 1 
   end
   term.setBackgroundColor(c1)
   term.setTextColor(c2)
end

local function boot_drawBootMenu(array, pos_x, pos_y, highlight, generic)
   local select = 1
   local x, y = term.getCursorPos()
   
   while true do
      term.setCursorPos(x, y)
      boot_mprint(array, select, pos_x, pos_y, highlight, generic)
      event, key = os.pullEvent("key")
      --Enter
      if key == 28 then 
         return select 
      end
      
      if #array > 1 then
         --Arrow UP or W key
         if key == 200 or key == 17 then 
      		    select = select - 1 
			
            if select < 1 then 
               select = #array 
            end
         --Arrow Down or S key
         elseif key == 208 or key == 31 then 
      		    select = select + 1     
        			 if select > #array then select = 1 end
  	      end
      end   
   end
end

local function boot_printColoredTextLine(y, txt, bg, fg)
 term.setCursorPos(1, y)
 term.setBackgroundColor(bg or colors.lightGray)
 term.write("                                                   ")
 term.setCursorPos(1, y)
 term.setTextColor(fg or colors.black)
 print(txt)
 term.setBackgroundColor(colors.black)
 term.setTextColor(colors.white)
end

local function drawBootManager(opt)
    term.setBackgroundColor(colors.black)
    term.clear()
    term.setCursorPos(1,1)
    boot_printColoredTextLine(2, "             Orbital Boot Manager v1.0             ", colors.lightGray, colors.black)
	if not err then
        boot_printColoredTextLine(18, " ARROW KEYS=Choose                      ENTER=Boot ", colors.lightGray, colors.black)
	else
        boot_printColoredTextLine(18, "                                                   ", colors.lightGray, colors.black)
	end
end

if not fs.exists("/boot/bcd") or not fs.isDir("/boot/bcd") or not loadfile("/boot/bcd/orbital") or not loadfile("/boot/bcd/orbital-re") then
    drawBootManager(true)
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.lightGray)	
	term.setCursorPos(2,7)
	print("The required Boot Configuration Data (BCD) files")
	term.setCursorPos(2,8)
	print("are not present on this computer.")
	term.setCursorPos(2,10)
	print("Please reinstall the Orbital operating system.")
    while true do
	    sleep(1)
	end
end

while true do
    drawBootManager(false)
    local a={"Orbital 0.0.2.7 Developer Preview", "Orbital Recovery Environment", "Boot from floppy disk"}
    local gmn=boot_drawBootMenu(a, 4, 5, colors.lightGray, colors.black)
    if gmn == 1 then
		shell.run("/boot/bcd/orbital")
		break
    elseif gmn == 2 then 
		shell.run("/boot/bcd/orbital-re")
        if __RECOVERY then
			break
        else
            term.setCursorPos(1, 16)
            term.setTextColor(colors.lightGray)
			print("         ERROR: Orbital RE is unavailable.")
			sleep(1)
		end
    elseif gmn==3 then 
        if fs.exists("/disk/startup") then
		    shell.run("/disk/startup") 
			break
        else
            term.setCursorPos(1, 16)
            term.setTextColor(colors.lightGray)
			print("        ERROR: Unable to detect MBR on disk")
			sleep(1)
		end
	end
end