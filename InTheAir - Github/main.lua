--Main Lua
--InTheAir
--Chris Childers
--chili24137@gmail.com
local background=display.setDefault("background",.25,1,.9 )
local platform=display.newRect(display.contentCenterX, display.contentCenterY+800, 350, 100)
platform.x=display.contentCenterX
platform.y=display.contentCenterY+800
platform:setFillColor(0,0,0)
local titleText=display.newText("In the Air", display.contentCenterX, display.contentCenterY-660, "helvetica", 200)
titleText:setFillColor(0,0,0)

local playButton=display.newText("Play", display.contentCenterX, display.contentCenterY+500, "helvetica", 180)
playButton:setFillColor(0,0,0)

local rightWall=display.newRect(display.contentCenterX+525, display.contentCenterY, 50,1500)
rightWall:setFillColor(0,0,0)

local leftWall=display.newRect(display.contentCenterX-525, display.contentCenterY, 50,1500)
leftWall:setFillColor(0,0,0)

local eventTimer

local circleTable={}

local ballNum=0
local function spawnBall()
  local circle=display.newCircle(0, 0, 90)
  table.insert(circleTable, circle)
  circle.x=display.contentCenterX+(math.random(-200,200))
  circle.y=display.contentCenterY-200
  circle:setFillColor(0,0,0)
  physics.addBody(circle, "dynamic",{radius=85, bounce=1})
end


local physics=require("physics")
physics.start()

physics.addBody(platform, "static")
physics.addBody(leftWall, "static")
physics.addBody(rightWall,"static")
physics.addBody(titleText,"static")

local locTracker=0

local function gameLoop() --checks for balls fallen
print("cow")
for i=3, 1, -1 do
local thisCircle=circleTable[i] --i'm assigning this to nothing so below
print(i)
if(locTracker==0) then
  if (thisCircle.y>2000) --here is below, it tries to compare null with int
  then
    locTracker=1
    print(i)
    for j=3,1,-1 do
      local yeahThisCircle=circleTable[j]
      display.remove(yeahThisCircle)
      table.remove(circleTable,j)
    end

    timer.cancel(eventTimer)
    playButton.isVisible=true

  --cancel timer
  --make play button visible and clickable again
  end
end

end

end

local function movePlatform(event)

  local platform=event.target
  local phase=event.phase

  if ("began"==phase) then
    display.currentStage:setFocus(platform)

    platform.touchOffsetX=event.x-platform.x
  elseif("moved"==phase) then
    platform.x=event.x-platform.touchOffsetX
  elseif("ended"==phase or "cancelled"==phase) then
    display.currentStage:setFocus(nil)
  end


  return true
end


local function runTimer(event)

playButton.isVisible=false
locTracker=0
timer.performWithDelay(100, spawnBall, 3)

print("helo")
eventTimer=timer.performWithDelay(500, gameLoop, 0)
print("aldflaj")
return true
end


playButton:addEventListener("tap", runTimer)
platform:addEventListener("touch",movePlatform)
