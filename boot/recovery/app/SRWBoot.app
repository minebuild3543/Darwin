local w, h = term.getSize()

local window = GUI.Window:new({w = w; h = h;})

local a_label1 = GUI.Label:new({x = 4; y = 4; text = "The Boot Recovery Wizard allows you to repair"; textAlign = "left"; bgColor = colors.lightGray;})
local a_label2 = GUI.Label:new({x = 4; y = 5; text = "various boot configuration parameters, BIOS"; textAlign = "left"; bgColor = colors.lightGray;})
local a_label3 = GUI.Label:new({x = 4; y = 6; text = "settings and the Master Boot Record."; textAlign = "left"; bgColor = colors.lightGray;})

local b_CheckBox1 = GUI.Checkbox:new({x = 4; y = 8; text = "Repair MBR";})
local b_CheckBox2 = GUI.Checkbox:new({x = 4; y = 10; text = "Repair BCD files";})
local b_CheckBox3 = GUI.Checkbox:new({x = 4; y = 12; text = "Repair BIOS settings";})

local b_commit = function(self)
	self.parent:close()
    if b_CheckBox1.checked == true or b_CheckBox2.checked == true then
	    local repair = "/boot/recovery/bootsect"
	    if b_CheckBox1.checked == true then
		    repair = repair.." /mbr"
		end
		if b_CheckBox2.checked == true then
		    repair = repair.." /bcd:orbital /bcd:orbital-re"
		end
		term.setBackgroundColor(colors.black)
		term.clear()
		term.setCursorPos(1,1)
		shell.run(repair)
	end
	if b_CheckBox3.checked == true then
		term.setBackgroundColor(colors.black)
		term.clear()
		term.setCursorPos(1,1)
		shell.run("/boot/recovery/sysprep --silent")
	end
    term.setBackgroundColor(colors.black)
	term.clear()
	term.setCursorPos(1,1)
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
window:setTitleLabel(GUI.Label:new({text = "Orbital RE - Boot Recovery Wizard"; textColor = colors.white; textAlign = "center";}))
window:addComponent(b_CheckBox1)
window:addComponent(b_CheckBox2)
window:addComponent(b_CheckBox3)
window:addComponent(GUI.Button:new({x = 2; y = 16; w = 24; action = b_commit; text = "Proceed with repair";}))
window:addComponent(GUI.Button:new({x = 26; y = 16; w = 24; action = b_back; text = "Back";}))
GUI.Controller:startUpdateCycle()