require "TimedActions/ISDestroyStuffAction"

Freemansoul = {}
Freemansoul.ISDestroyStuffAction = {}
Freemansoul.ISDestroyStuffAction.perform = ISDestroyStuffAction.perform


Freemansoul.destroyTransmitOrKill = function(final, sq, life, arg)
	local sq = self.item:getSquare()
    local life = sq:getObjects(self.item)
    local final = life:getHealth()
	final = final - 1000
    if final <= 0 then
        if isClient() then
            sledgeDestroy(object)
        else
            object:getSquare():transmitRemoveItemFromSquare(object)
        end
    else
        life:setHealth(final)
    end
    return final
end

Freemansoul.destroyTransmitOrKill1 = function(final, sq, life, objNew, index, attachedSprite, arg)
	local sq = self.item:getSquare()
    local life = sq:getObjects(self.item)
    local final = life:getHealth()
    local objNew = IsoObject.getNew(sq, self:getCornerWallSprite(self.item:getSprite()), self:getCornerWallSprite(self.item:getSprite()), false);
    local index = self.item:getObjectIndex();
    local attachedSprite = self:getCornerWallSprite(self.item:getAttachedAnimSprite():get(i-1):getParentSprite())
    if final <= 0 then
        if isClient() then
            sledgeDestroy(object)
		elseif self.item:getSprite():getProperties():Is("CornerNorthWall") then

			objNew:setAttachedAnimSprite(ArrayList:new())

			if self.item:getAttachedAnimSprite() ~= nil and not self.item:getAttachedAnimSprite():isEmpty() then
				for i=1,self.item:getAttachedAnimSprite():size() do
					if attachedSprite ~= nil then
						objNew:getAttachedAnimSprite():add(getSprite(attachedSprite):newInstance())
					end
				end
			end
			print(objNew)

			sq:transmitRemoveItemFromSquare(self.item);
			sq:transmitAddObjectToSquare(objNew, index);
        else
            object:getSquare():transmitRemoveItemFromSquare(object)
        end
    else
        life:setHealth(final)
    end
    return final
end

function ISDestroyStuffAction:perform()    
    Freemansoul.ISDestroyStuffAction.perform(self)

    local stairObjects = buildUtil.getStairObjects(self.item)
    local doubleDoorObjects = buildUtil.getDoubleDoorObjects(self.item)
    local garageDoorObjects = buildUtil.getGarageDoorObjects(self.item)
    local graveObjects = buildUtil.getGraveObjects(self.item)
	----Vars to identify some tiles to modify the damage dealt to them------
	local sq = self.item:getSquare()
	local life = sq:getObjects(self.item)
    local final = life:getHealth()
	local sprite1 = life:getProperties()
	local sprite2 = sprite1:getSprite()
	local sprite = sprite2:getSpriteName()
	local objNew = IsoObject.getNew(sq, self:getCornerWallSprite(self.item:getSprite()), self:getCornerWallSprite(self.item:getSprite()), false);
    local index = self.item:getObjectIndex();
    local attachedSprite = self:getCornerWallSprite(self.item:getAttachedAnimSprite():get(i-1):getParentSprite())

	if #stairObjects > 0 then
		for i=1,#stairObjects do
			local object = stairsObjects[i]
			Freemansoul.destroyTransmitOrKill(final, sq, object, life)
		end
	elseif #doubleDoorObjects > 0 then
		for i=1,#doubleDoorObjects do
			local object = doubleDoorObjects[i]
			Freemansoul.destroyTransmitOrKill(final, sq, object, life)
		end
	elseif #garageDoorObjects > 0 then
		for i=1,#garageDoorObjects do
			local object = garageDoorObjects[i]
			Freemansoul.destroyTransmitOrKill(final, sq, object, life)
		end
	elseif #graveObjects > 0 then
		for i=1,#graveObjects do
			local object = graveObjects[i]
			Freemansoul.destroyTransmitOrKill(final, sq, object, life)
		end
	elseif ISWoodenWall or ISMetalWall or ISWoodenDoor or ISWoodenDoorFrame or ISWoodenRoof > 0 then
        if ISWoodenWall > 0 then
		    for i=1,ISWoodenWall do
			    local object = ISWoodenWall[i]
			    final = final - 1000
			    if sprite == "walls_exterior_house_02_0" or sprite == "walls_exterior_house_02_4" or sprite == "walls_exterior_house_01_4" or sprite == "walls_exterior_house_01_16" then
				    for i=1,sprite do
					    local object = sprite[i]
					    final = final - 800
                        Freemansoul.destroyTransmitOrKill1(final, object, life, objNew, index, attachedSprite, sq)
                    end
				else
					Freemansoul.destroyTransmitOrKill1(final, object, life, objNew, index, attachedSprite, sq)
				end
			end	
        elseif ISWoodenDoor > 0 then
		    for i=1,ISWoodenDoor do
			    local object = ISWoodenDoor[i]
			    final = final - 1000
				Freemansoul.destroyTransmitOrKill1(final, object, life, objNew, index, attachedSprite, sq)
			end
        elseif ISWoodenDoorFrame > 0 then
		    for i=1,ISWoodenDoorFrame do
			    local object = ISWoodenDoorFrame[i]
			    final = final - 1000
				Freemansoul.destroyTransmitOrKill1(final, object, life, objNew, index, attachedSprite, sq)
			end
        elseif ISWoodenRoof > 0 then
		    for i=1,ISWoodenRoof do
			    local object = ISWoodenRoof[i]
			    final = final - 800
				Freemansoul.destroyTransmitOrKill1(final, object, life, objNew, index, attachedSprite, sq)
            end	
        elseif ISMetalWall > 0 then
		    for i=1,ISMetalWall do
			    local object = ISMetalWall[i]
			    final = final - 800
			    if sprite == "constructedobjects_01_64" or sprite == "constructedobjects_01_48" then
				    for i=1,#sprite do
					    local object = #sprite[i]
					    final = final - 500
                        Freemansoul.destroyTransmitOrKill1(final, object, life, objNew, index, attachedSprite, sq)
                    end
				elseif sprite == "industry_trucks_01_4" then
					for i=1,sprite do
						local object = sprite[i]
						final = final - 200
                        Freemansoul.destroyTransmitOrKill1(final, object, life, objNew, index, attachedSprite, sq)
                    end
				else
					Freemansoul.destroyTransmitOrKill1(final, object, life, objNew, index, attachedSprite, sq)
				end
			end
		end
	elseif ISHighMetalFence > 0 then
		for i=1,ISHighMetalFence do
			local object = ISHighMetalFence[i]
			final = final - 1000
			Freemansoul.destroyTransmitOrKill1(final, object, life, objNew, index, attachedSprite, sq)
		end
	else
		if isClient() then
			sledgeDestroy(self.item);
		elseif self.item:getSprite():getProperties():Is("CornerNorthWall") then

			objNew:setAttachedAnimSprite(ArrayList:new())

				--attached sprites
			if self.item:getAttachedAnimSprite() ~= nil and not self.item:getAttachedAnimSprite():isEmpty() then
				for i=1,self.item:getAttachedAnimSprite():size() do
					if attachedSprite ~= nil then
						objNew:getAttachedAnimSprite():add(getSprite(attachedSprite):newInstance())
					end
				end
			end
			print(objNew)

			sq:transmitRemoveItemFromSquare(self.item);
			sq:transmitAddObjectToSquare(objNew, index);
		else --not a corner wall, just remove it
			self.item:getSquare():transmitRemoveItemFromSquare(self.item)
		end
	end
  ----------------------------MODIFIED PART END----------------------------------------
  ---------------I am not sure i should delete this next part or not---------
 --	getSoundManager():PlaySound("breakdoor", false, 1);
	-- add a sound to the list so zombie/npc can hear it
	addSound(self.character, self.character:getX(),self.character:getY(),self.character:getZ(), 10, 10);
    -- reduce the sledge condition
	if not ISBuildMenu.cheat then
		local sledge = self.character:getPrimaryHandItem();
		if ZombRand(sledge:getConditionLowerChance() * 2) == 0 then
			sledge:setCondition(sledge:getCondition() - 1);
			ISWorldObjectContextMenu.checkWeapon(self.character);
		end
	end
    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end
