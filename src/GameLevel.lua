--[[
    GD50
    Super Mario Bros. Remake

    -- GameLevel Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GameLevel = Class{}

function GameLevel:init(entities, objects, tilemap)
    self.entities = entities
    self.objects = objects
    self.tileMap = tilemap
    self.key = false
    self.lockBlock = false
end

--[[
    Remove all nil references from tables in case they've set themselves to nil.
]]
function GameLevel:clear()
    for i = #self.objects, 1, -1 do
        if not self.objects[i] then
            table.remove(self.objects, i)
        end
    end

    for i = #self.entities, 1, -1 do
        if not self.objects[i] then
            table.remove(self.objects, i)
        end
    end
end

function GameLevel:update(dt)
    self.tileMap:update(dt)

    for k, object in pairs(self.objects) do
        -- if the player has picked up the key make the lock box non solid so it can be consumed
        if self.key then
            if object.type == 'lockBlock' then
                object.solid = false
            end
        end
        if self.lockBlock == true then
            if object.type == 'post' or object.type == 'flag' then
                object.onActivation(object)
            end
        end
        object:update(dt)
    end

    for k, entity in pairs(self.entities) do
        entity:update(dt)
    end
end

function GameLevel:render()
    for k, object in pairs(self.objects) do
        object:render()
    end

    self.tileMap:render()

    for k, entity in pairs(self.entities) do
        entity:render()
    end
end