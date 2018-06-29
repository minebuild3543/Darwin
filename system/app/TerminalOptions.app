local w, h = term.getSize()
local window = GUI.Window:new({w = w; h = h;})

local CheckBox1 = GUI.Checkbox:new({x = 4; y = 8; text = "Enable auto-completion in console"; checked = settings.get("shell.autocomplete");})
local CheckBox2 = GUI.Checkbox:new({x = 4; y = 10; text = "Enable auto-completion in Lua interpreter"; checked = settings.get("lua.autocomplete");})
local CheckBox3 = GUI.Checkbox:new({x = 4; y = 12; text = "List hidden files"; checked = settings.get("list.show_hidden");})

local commit = function(self)
    settings.set("shell.autocomplete", CheckBox1.checked)
    settings.set("lua.autocomplete", CheckBox2.checked)
    settings.set("list.show_hidden", CheckBox3.checked)
    settings.save( ".settings" )
	self.parent:close()
end

GUI.Controller:addWindow(window)
window:setTitleLabel(GUI.Label:new({text = "Terminal Options"; textColor = colors.white; textAlign = "center";}))
--window:addComponent(GUI.Button:new({x = 1; y = 1; w = 1; h = 1; action = (function(self) self.parent:close() end); textColor = colors.red; bgColor = window.tlColor; text = "X";}))

window:addComponent(GUI.Label:new({x = 4; y = 4; text = "The following options regulate the behaviour"; textAlign = "left"; bgColor = colors.lightGray;}))
window:addComponent(GUI.Label:new({x = 4; y = 5; text = "of the Orbital Terminal. Mark the checkboxes"; textAlign = "left"; bgColor = colors.lightGray;}))
window:addComponent(GUI.Label:new({x = 4; y = 6; text = "corresponding with options you wish to enable."; textAlign = "left"; bgColor = colors.lightGray;}))
window:addComponent(CheckBox1)
window:addComponent(CheckBox2)
window:addComponent(CheckBox3)
window:addComponent(GUI.Button:new({x = 35; y = 16; action = commit; text = "Commit Options";}))

GUI.Controller:startUpdateCycle()