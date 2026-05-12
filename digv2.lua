-- Super Turtle main file. This is the main entry point for the Super Turtle script.
-- It sets up the mod, registers event handlers, and initializes the Super Turtle functionality.
-- Version 2 of the Super Turtle script, with improved fuel management and mining tool checks.

local args = { ... }
local mineLength = tonumber(args[1]) or 5

if args[1] == "help" then
    print("usage: digv2 <actions> <length>")
    print("actions: dig - mine forward, digup - mine up, digdown - mine down")
    print("actions: digstairdown - mine a 3-block wide staircase down")
    print("length: how many blocks to mine forward (default 5)")
    return
end

if not args or #args == 0 then
    print("No arguments provided. Defaulting to mining forward 5 blocks.")
else
    print("Arguments: " .. table.concat(args, " "))
end

-- Loop mineLength times to move forward and mine blocks
for i = 1, mineLength do
    local successInfo, dataInfo = turtle.inspect()
    if moveForward() then
        print("Moved block " .. i .. " of " .. mineLength .. ". " .. (dataInfo.name or "unknown block"))
    else
        print("Failed to move - stopping: " .. (dataInfo.name or "unknown reason"))
        break
    end
end