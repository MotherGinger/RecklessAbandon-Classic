local E, L, V, P, G = unpack(select(2, ...)) --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB

function E:Dump(o)
    local cache, stack, output = {}, {}, {}
    local depth = 1
    local output_str = "{\n"

    while true do
        local size = 0
        for k, v in pairs(o) do
            size = size + 1
        end

        local cur_index = 1
        for k, v in pairs(o) do
            if (cache[o] == nil) or (cur_index >= cache[o]) then
                if (string.find(output_str, "}", output_str:len())) then
                    output_str = output_str .. ",\n"
                elseif not (string.find(output_str, "\n", output_str:len())) then
                    output_str = output_str .. "\n"
                end

                -- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
                table.insert(output, output_str)
                output_str = ""

                local key
                if (type(k) == "number" or type(k) == "boolean") then
                    key = "[" .. tostring(k) .. "]"
                else
                    key = "['" .. tostring(k) .. "']"
                end

                if (type(v) == "number" or type(v) == "boolean") then
                    output_str = output_str .. string.rep("    ", depth) .. key .. " = " .. tostring(v)
                elseif (type(v) == "table") then
                    output_str = output_str .. string.rep("    ", depth) .. key .. " = {\n"
                    table.insert(stack, o)
                    table.insert(stack, v)
                    cache[o] = cur_index + 1
                    break
                else
                    output_str = output_str .. string.rep("    ", depth) .. key .. " = '" .. tostring(v) .. "'"
                end

                if (cur_index == size) then
                    output_str = output_str .. "\n" .. string.rep("    ", depth - 1) .. "}"
                else
                    output_str = output_str .. ","
                end
            else
                -- close the table
                if (cur_index == size) then
                    output_str = output_str .. "\n" .. string.rep("    ", depth - 1) .. "}"
                end
            end

            cur_index = cur_index + 1
        end

        if (size == 0) then
            output_str = output_str .. "\n" .. string.rep("    ", depth - 1) .. "}"
        end

        if (#stack > 0) then
            o = stack[#stack]
            stack[#stack] = nil
            depth = cache[o] == nil and depth + 1 or depth - 1
        else
            break
        end
    end

    -- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
    table.insert(output, output_str)
    output_str = table.concat(output)

    return output_str
end

function E:CopyTable(currentTable, defaultTable)
    if type(currentTable) ~= "table" then
        currentTable = {}
    end

    if type(defaultTable) == "table" then
        for option, value in pairs(defaultTable) do
            if type(value) == "table" then
                value = self:CopyTable(currentTable[option], value)
            end

            currentTable[option] = value
        end
    end

    return currentTable
end

function E:IsEmpty(t)
    for _, _ in pairs(t) do
        return false
    end
    return true
end

function E:Tabulate(t, template)
    template = template or "%s %s\n"

    local ordered_keys = {}
    for k in pairs(t) do
        table.insert(ordered_keys, k)
    end

    local result = {}
    for i = 1, #ordered_keys do
        local k, v = ordered_keys[i], t[ordered_keys[i]]

        result[#result + 1] = template:format(k, v)
    end

    table.sort(result)

    return table.concat(result)
end

-- Frame Pool

ObjectPoolMixin = {}

function ObjectPoolMixin:OnLoad(creationFunc, resetterFunc)
    self.creationFunc = creationFunc
    self.resetterFunc = resetterFunc

    self.activeObjects = {}
    self.inactiveObjects = {}

    self.numActiveObjects = 0
end

function ObjectPoolMixin:Acquire()
    local numInactiveObjects = #self.inactiveObjects
    if numInactiveObjects > 0 then
        local obj = self.inactiveObjects[numInactiveObjects]
        self.activeObjects[obj] = true
        self.numActiveObjects = self.numActiveObjects + 1
        self.inactiveObjects[numInactiveObjects] = nil
        return obj, false
    end

    local newObj = self.creationFunc(self)
    if self.resetterFunc then
        self.resetterFunc(self, newObj)
    end
    self.activeObjects[newObj] = true
    self.numActiveObjects = self.numActiveObjects + 1
    return newObj, true
end

function ObjectPoolMixin:Release(obj)
    assert(self.activeObjects[obj])

    self.inactiveObjects[#self.inactiveObjects + 1] = obj
    self.activeObjects[obj] = nil
    self.numActiveObjects = self.numActiveObjects - 1
    if self.resetterFunc then
        self.resetterFunc(self, obj)
    end
end

function ObjectPoolMixin:ReleaseAll()
    for obj in pairs(self.activeObjects) do
        self:Release(obj)
    end
end

function ObjectPoolMixin:EnumerateActive()
    return pairs(self.activeObjects)
end

function ObjectPoolMixin:GetNextActive(current)
    return (next(self.activeObjects, current))
end

function ObjectPoolMixin:GetNumActive()
    return self.numActiveObjects
end

function ObjectPoolMixin:EnumerateInactive()
    return ipairs(self.inactiveObjects)
end

function CreateObjectPool(creationFunc, resetterFunc)
    local objectPool = CreateFromMixins(ObjectPoolMixin)
    objectPool:OnLoad(creationFunc, resetterFunc)
    return objectPool
end

FramePoolMixin = Mixin({}, ObjectPoolMixin)

local function FramePoolFactory(framePool)
    return CreateFrame(framePool.frameType, nil, framePool.parent, framePool.frameTemplate)
end

function FramePoolMixin:OnLoad(frameType, parent, frameTemplate, resetterFunc)
    ObjectPoolMixin.OnLoad(self, FramePoolFactory, resetterFunc)
    self.frameType = frameType
    self.parent = parent
    self.frameTemplate = frameTemplate
end

function FramePool_Hide(framePool, frame)
    frame:Hide()
end

function FramePool_HideAndClearAnchors(framePool, frame)
    frame:Hide()
    frame:ClearAllPoints()
end

function E:CreateFramePool(frameType, parent, frameTemplate, resetterFunc)
    local framePool = CreateFromMixins(FramePoolMixin)
    framePool:OnLoad(frameType, parent, frameTemplate, resetterFunc or FramePool_HideAndClearAnchors)
    return framePool
end
