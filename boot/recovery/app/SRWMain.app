local w, h = term.getSize()

local window = GUI.Window:new({w = w - 5; h = h - 5;})

local b_CheckBox1 = GUI.Checkbox:new({x = 4; y = 8; text = "Repair bootloader";})
local b_CheckBox2 = GUI.Checkbox:new({x = 4; y = 10; text = "Repair Orbital BCD file";})

local a_repairBCDandMBR = function(self)
    self.parent:close()
    term.setBackgroundColor(colors.black)
	term.clear()
	term.setCursorPos(1,1)
	shell.run("/boot/recovery/app/SRWBoot.app")
end

local a_refreshPC = function(self)
    self.parent:close()
    term.setBackgroundColor(colors.black)
	term.clear()
	term.setCursorPos(1,1)
	shell.run("/boot/recovery/app/SRWRefresh.app")
end

local a_rebootComputer = function(self)
    self.parent:close()
    term.setBackgroundColor(colors.black)
	term.clear()
	term.setCursorPos(1,1)
	stdout("Recovery operations complete, rebooting...")
	sleep(0.5)
	os.reboot()
end 

GUI.Controller:addWindow(window)
window:setTitleLabel(GUI.Label:new({text = "Orbital Recovery Environment"; textColor = colors.white; textAlign = "center";}))
local a_label1 = GUI.Label:new({x = 4; y = 4; text = "Welcome to the Orbital Recovery Environment."; textAlign = "left"; bgColor = colors.lightGray;})
local a_label2 = GUI.Label:new({x = 4; y = 5; text = "This application allows you to perform various"; textAlign = "left"; bgColor = colors.lightGray;})
local a_label3 = GUI.Label:new({x = 4; y = 6; text = "repair and maintenance tasks on your system."; textAlign = "left"; bgColor = colors.lightGray;})
local a_repair = GUI.Button:new({x = 2; y = 8; w = 47; action = a_repairBCDandMBR; text = "Repair your computer";})
local a_refresh = GUI.Button:new({x = 2; y = 12; w = 47; action = a_refreshPC; text = "Refresh your Orbital installation";})
local a_reboot = GUI.Button:new({x = 2; y = 16; w = 47; action = a_rebootComputer text = "Cancel recovery operations";})
window:addComponent(a_label1)
window:addComponent(a_label2)
window:addComponent(a_label3)
window:addComponent(a_repair)
window:addComponent(a_refresh)
window:addComponent(a_reboot)

GUI.Controller:startUpdateCycle()