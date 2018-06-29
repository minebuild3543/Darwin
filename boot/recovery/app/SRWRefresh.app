local w, h = term.getSize()

local window = GUI.Window:new({w = w; h = h;})

local a_label1 = GUI.Label:new({x = 4; y = 4; text = "The Refresh Your PC Wizard allows you to"; textAlign = "left"; bgColor = colors.lightGray;})
local a_label2 = GUI.Label:new({x = 4; y = 5; text = "repair errors in your system installation"; textAlign = "left"; bgColor = colors.lightGray;})
local a_label3 = GUI.Label:new({x = 4; y = 6; text = "by selectively reinstalling parts of the OS."; textAlign = "left"; bgColor = colors.lightGray;})

local b_CheckBox1 = GUI.Checkbox:new({x = 4; y = 8; text = "Reinstall kernel extensions";})
local b_CheckBox2 = GUI.Checkbox:new({x = 4; y = 10; text = "Reinstall standard libraries";})
local b_CheckBox3 = GUI.Checkbox:new({x = 4; y = 12; text = "Reinstall system applications";})

local b_commit = function(self)
	self.parent:close()
    term.setBackgroundColor(colors.black)
	term.clear()
	term.setCursorPos(1,1)
	stdout("The Refresh Your PC Wizard is unavailable.\n")
	stdout("Recovery operations complete, rebooting...")
	sleep(0.5)
	os.reboot()
end

local b_back = function(self)
	self.parent:close()
    term.setBackgroundColor(colors.black)
	term.clear()
	term.setCursorPos(1,1)
	shell.run("/boot/recovery/app/SRWMain.app")
end

GUI.Controller:addWindow(window)
window:setTitleLabel(GUI.Label:new({text = "Orbital RE - Refresh your PC"; textColor = colors.white; textAlign = "center";}))
window:addComponent(b_CheckBox1)
window:addComponent(b_CheckBox2)
window:addComponent(b_CheckBox3)
window:addComponent(GUI.Button:new({x = 2; y = 16; w = 24; action = b_commit; text = "Proceed with repair";}))
window:addComponent(GUI.Button:new({x = 26; y = 16; w = 24; action = b_back; text = "Back";}))
GUI.Controller:startUpdateCycle()