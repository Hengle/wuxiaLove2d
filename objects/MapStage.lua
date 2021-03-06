---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by apple.
--- DateTime: 2018/10/29 下午11:55
---

--- @class MapStage : Stage
MapStage = Class("MapStage",Stage)

--- init
local style = {
    font = assets.font.myfont(32),
    showBorder = true,
    bgColor = {0.208, 0.220, 0.222,0.222},
    --group = "MapStage"
    --fgColor = {1,0,0}
}

local mx,my = 0,0

require("lib.gooi")
function MapStage:init()
    self.area = Area(self)
    self.area:addPhysicsWorld()
    self.main_canvas = love.graphics.newCanvas(gw,gh)
    self.date = Date:new(100000)
    --self.background = assets.graphics.Backgrounds.bg
    self.map = assets.graphics.map
    self.ui = gooi
    self.ui.desktopMode()
    --- ui 切换
    self.ui_group = "MapStage"
    self.ui.setStyle(style)
    self.ui.newLabel({text = "江湖地图",x = gw/2 - 320,y= 40,w = 320,group = self.ui_group}):setStyle({font=font80}):fg({0,0,0}):center()
    self.ui.newButton({group = self.ui_group,text = "返回太虚",w = 128,h = 32,x = gw - 256,y = gh - 80})
        :onRelease(
            function ()
                gotoRoom("MainStage","MainStage")
            end)
end

function MapStage:activate()
    self.ui.setGroupVisible(self.ui_group,true)
    self.ui.setGroupEnabled(self.ui_group,true)
end

function MapStage:deactivate()
    self.ui.setGroupVisible(self.ui_group,false)
    self.ui.setGroupEnabled(self.ui_group,false)
end

function MapStage:update(dt)
    if self.area then self.area:update(dt) end
    self.ui.update(dt)
    if love.mouse.isDown(1) then
        local mx,my = camera:getMousePosition(sw,sh,0,0,sw * gw,sh * gh)
        local dx,dy = mx - self.previous_mx,my - self.previous_my
        camera:move(-dx,-dy)
    end
    self.previous_mx,self.previous_my = camera:getMousePosition(sw,sh,0,0,sw * gw,sh * gh)

end

function MapStage:draw()
    love.graphics.setCanvas(self.main_canvas)
    love.graphics.clear()
    camera:attach(0,0,gw,gh)
    love.graphics.draw(self.map)
    if self.area then self.area:draw() end
    camera:detach()
    love.graphics.setCanvas()

    love.graphics.setColor(1,1,1,1)
    love.graphics.setBlendMode('alpha','premultiplied')
    love.graphics.draw(self.main_canvas,0,0,0,sx,sy)
    love.graphics.setBlendMode('alpha')
    love.graphics.setColor(0.5,0.5,0.5,0.5)
    love.graphics.rectangle('fill',0,0,gw,32,0,1,1,8)
    love.graphics.setColor(1,1,1,1)




    self.ui.draw(self.ui_group)

    --self.date:draw()
end

function MapStage:mousereleased()
    self.ui.released()
end

function MapStage:mousepressed()
    self.ui.pressed()
end

function MapStage:destroy()
    if self.area then
        self.area:destroy()
        self.area = nil
    end
end

return MapStage