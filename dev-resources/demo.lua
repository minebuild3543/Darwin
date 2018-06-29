local program = require "programs"

programs = {
  program.new(function()
    shell.run("paint", "tes")
  end, 5, 5, 20, 10),
  program.new(function()
    shell.run("edit", "tes")
  end, 1, 2, 10, 7),
  program.new(function()
    shell.run("worm")
  end, 30, 2, 15, 9),
  program.new(function()
    while true do
      term.setBackgroundColor(colors.white)
      term.clear()
      coroutine.yield()
    end
  end, 28, 10, 20, 10)
}

while true do
  local event, var1, var2, var3 = os.pullEventRaw()
  if event == "terminate" then break end

  term.setBackgroundColor(colors.black)
  term.clear()
  program.update(programs, event, var1, var2, var3)
end

term.setBackgroundColor(colors.black)
term.clear()
term.setCursorPos(1, 1)