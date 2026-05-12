--
-- 3-block wide descending staircase digging turtle.
-- Creates stairs: 3 blocks wide, steps down every 1 block forward
--

-- how many blocks to mine forward.
local mineLength = 30
local stairWidth = 3

-- Mine 3 blocks wide at current position
local function mineWidth()
    print("Mining 3 blocks wide...")
    
    -- Mine center block
    if turtle.detect() then
        turtle.dig()
    end
    
    -- Mine left block
    turtle.turnLeft()
    if turtle.detect() then
        turtle.dig()
    end
    turtle.turnRight()
    
    -- Mine right block
    turtle.turnRight()
    if turtle.detect() then
        turtle.dig()
    end
    turtle.turnLeft()
    
    print("Width cleared")
end

local function digging(i)
    turtle.dig()
    turtle.turnLeft()
    turtle.dig()
    turtle.turnRight()
    turtle.turnRight()
    turtle.dig()
    turtle.turnLeft()
end

local function diggingUp()
    turtle.digUp()
    turtle.up()
    turtle.turnLeft()
    turtle.dig()
    turtle.turnRight()
    turtle.turnRight()
    turtle.dig()
    turtle.turnLeft()
    turtle.down()
end

local function goForward(i)
    local moveSuccess = turtle.forward()
    if not moveSuccess then
        print("ERROR: Could not move forward at step " .. i)
    end
    
    print("Moved forward")
end
-- Mine down and move to next step
local function stepDown()
    print("Stepping down...")
    
    -- Mine block below
    turtle.digDown()
    
    -- Move down
    local moveSuccess = turtle.down()
    if not moveSuccess then
        print("ERROR: Could not move down!")
        return false
    end
    
    print("Stepped down successfully")
    return true
end

-- Main staircase loop
print("Starting 3-block wide downstairs mining...")
print("Fuel level: " .. turtle.getFuelLevel())

for i = 1, mineLength do
    print("\n--- Step " .. i .. " of " .. mineLength .. " ---")
    
    -- Check fuel
    if turtle.getFuelLevel() < 50 then
        print("WARNING: Low fuel level: " .. turtle.getFuelLevel())
    end
    
    -- Mine width at current position
    digging(i)
    
    -- Try to move forward
    -- if turtle.detect() then
    --     turtle.dig()
    -- end
    goForward(i)
    digging(i)
    diggingUp()
    
    -- Step down for next level
    if not stepDown() then
        break
    end
end

print("\nDownstairs mining complete!")
print("Final fuel level: " .. turtle.getFuelLevel())
