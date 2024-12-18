-- Author:GtX | Andy
-- Name:Create I3D Mappings
-- Description:Displays </i3dMappings> to allow easy copy and paste to placeable or vehicle XML files.
-- Icon:iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAZ5JREFUOI2Nkr9PFEEUxz+zdwmBSw67mY1kiPFHfTSSEAtM7lrkb4CC0OlJIsRYqqXWYm9jAdi5xERiZxBouIpit7nF2DgNxR37LNg79pgVfckkk+/7vve+7wdcY1rrNa312nUcVQaGYZhF1ipABrxWktDtdj1+4AUb04+s9YpE1hIa0/9ngo9TU5X8K3OdTjDX6aiCz+N7wGTlIr6VJMo5h3OOZhwPfF4L1asAed+RtTLf62mA3elpKeEBJUMMw1AiayX3SZFXNkivhQKhWFUA+a8tDCpdVdpKktKVD0FtzMHd9qcGwIeFI5l9+EJ9zltpxjEH314Pg2YebBymaTozoiCABpIJknH687d8//oSAc5F2N97RZbJ8AENT0GotRAE2OVN7v96319vL1TJRFAolK/+5r0lBfkajTFn8q4NIDHHKlndr/y4tcHJm0copdjdec6NyYmRBMaYszRNx6sASmRsZOTnPRRw58k2gKx8uVR68nYREUSEsaEC2XxaPtkSu/14a0CR02ezqFqtRr1ez7g8nOIB/S2nADjngj/TiJ7+RFY5IAAAAABJRU5ErkJgggCopGMLAAQAjS0tIEF1dGhvcjprZXZpbms5OAotLSBOYW1lOnNldENsaXBEaXN0YW5jZQotLSBEZXNjcmlwdGlvbjoKLS0gSWNvbjoKLS0gSGlkZTogbm8KCmxvY2FsIGNsaXBEaXN0YW5jZSA9IDMwMDsgLS1jaGFuZ2UgaGVyZSB0aGUgY2xpcGRpc3RhbmNlCmZ1bmN0aW9uIHNldENsaXAobm9kZSkKICAgIGxvY2FsIG51bSA9IGdldE51bU9mQ2hpbGRyZW4obm9kZSkKICAgIGZvciBpPTEsbnVtIGRvCiAgICAgICAgbG9jYWwgY2hpbGQgPSBnZXRDaGlsZEF0KG5vZGUsaS0xKTsKICAgICAgICBzZXRDbGlwRGlzdGFuY2UoY2hpbGQsIGNsaXBEaXN0YW5jZSk7CiAgICAgICAgaWYgZ2V0TnVtT2ZDaGlsZHJlbihjaGlsZCkgPiAwIHRoZW4KICAgICAgICAgICAgc2V0Q2xpcChjaGlsZCk7CiAgICAgICAgZW5kOwogICAgZW5kOwplbmQ7CmxvY2FsIHRnID0gZ2V0U2VsZWN0aW9uKDApOwpzZXRDbGlwRGlzdGFuY2UodGcsIGNsaXBEaXN0YW5jZSk7CnNldENsaXAodGcpOwAAAAAAiaR8CwAFAI4tIEF1dGhvcjprZXZpbms5OAotLSBOYW1lOnNldENsaQ==
-- Hide: no
--
-- Copyright (C) GtX | Andy, 2018
-- Contact: https://github.com/GtX-Andy or https://forum.giants-software.com

CreateI3DMappings = {}

CreateI3DMappings.WINDOW_WIDTH = 800
CreateI3DMappings.WINDOW_HEIGHT = 600

CreateI3DMappings.NUMBER_DUPLICATE_NAMES = 0
CreateI3DMappings.NUMBER_WHITESPACE_NAMES = 0

function CreateI3DMappings.new()
    local self = setmetatable({}, {__index = CreateI3DMappings})

    self.window = nil

    self.defaultMappingsText = "<i3dMappings>\n</i3dMappings>"
    self.mappingsTextAreaText = self.defaultMappingsText

    if g_createI3DMappings ~= nil then
        g_createI3DMappings:close()
    end

    self:generateUI()
    g_createI3DMappings = self

    return self
end

function CreateI3DMappings:generateUI()
    local frameRowSizer = UIRowLayoutSizer.new()
    self.window = UIWindow.new(frameRowSizer, "Create I3D Mappings")

    local borderSizer = UIRowLayoutSizer.new()
    UIPanel.new(frameRowSizer, borderSizer, -1, -1, -1, -1, BorderDirection.NONE, 0, 1)

    local rowSizer = UIRowLayoutSizer.new()
    UIPanel.new(borderSizer, rowSizer, -1, -1, CreateI3DMappings.WINDOW_WIDTH, CreateI3DMappings.WINDOW_HEIGHT, BorderDirection.ALL, 10, 1)

    local colSizer = UIColumnLayoutSizer.new()
    UIPanel.new(borderSizer, colSizer, -1, -1, -1, -1, BorderDirection.BOTTOM, 10)

    self.mappingsTextArea = UITextArea.new(rowSizer, self.mappingsTextAreaText, TextAlignment.LEFT, false, true, -1, -1, CreateI3DMappings.WINDOW_WIDTH, CreateI3DMappings.WINDOW_HEIGHT, BorderDirection.ALL, 1, 1)

    UIButton.new(colSizer, "Create From Selected", function() self:createMappings(true) end, nil, -1, -1, -1, 35, BorderDirection.LEFT, 10, 1)
    UIButton.new(colSizer, "Create From Scenegraph", function() self:createMappings(false) end, nil, -1, -1, -1, 35, BorderDirection.NONE, 10, 1)
    UIButton.new(colSizer, "Copy All", self.copyAll, self, -1, -1, -1, 35, BorderDirection.RIGHT, 25, 1)

    local function showMessageBox()
        local aboutText = "Create I3D Mappings - v1.0.0.0\n\nBuild Date: November 21 2024\nSupport: https://github.com/GtX-Andy\n\nCopyright © 2018 - 2024 GtX (Andy)"
        self:showMessageBox(aboutText, "About")
    end

    UIButton.new(colSizer, "🛈", showMessageBox, nil, -1, -1, 35, 35, BorderDirection.RIGHT, 10, -1)

    self.window:setOnCloseCallback(function() self:onClose() end)
    self.window:showWindow()
end

function CreateI3DMappings:createMappings(selectedOnly)
    local sceneId = getRootNode()
    local numMappingsByName = {}

    if selectedOnly then
        -- local mappingsText = self.defaultMappingsText
        local numSelected = getNumSelected()

        if numSelected > 0 then
            mappingsText = '<i3dMappings>\n'

            if numSelected > 1 then
                local selectedNodes = {}

                for i = 1, numSelected do
                    local childId = getSelection(i - 1)

                    selectedNodes[i] = {
                        name = CreateI3DMappings.getValidNodeName(childId, numMappingsByName),
                        pathIndices = CreateI3DMappings.getNodePathIndices(childId, sceneId)
                    }
                end

                table.sort(selectedNodes, function(a, b)
                    return a.pathIndices < b.pathIndices
                end)

                for _, selectedNode in ipairs (selectedNodes) do
                    mappingsText = mappingsText .. '    <i3dMapping id="' .. selectedNode.name .. '" node="' .. selectedNode.pathIndices .. '"/>\n'
                end
            else
                local childId = getSelection(0)
                mappingsText = mappingsText .. '    <i3dMapping id="' .. CreateI3DMappings.getValidNodeName(childId, numMappingsByName) .. '" node="' .. CreateI3DMappings.getNodePathIndices(childId, sceneId) .. '"/>\n'
            end

            self.mappingsTextArea:setValue(mappingsText .. '</i3dMappings>')
        else
            self.mappingsTextArea:setValue("Info:\n  - First select one or more nodes from the Scenegraph.")
        end
    else
        local terrain = getChild(sceneId, "terrain")

        if terrain == 0 or not getHasClassId(terrain, ClassIds.TERRAIN_TRANSFORM_GROUP) then
            if getNumOfChildren(sceneId) > 1 then
                local perspCamera = getChild(sceneId, "persp")

                if perspCamera ~= 0 and not getHasClassId(perspCamera, ClassIds.CAMERA) then
                    perspCamera = 0
                end

                local mappingsText = '<i3dMappings>\n'
                local createMappingsTextRecursive

                createMappingsTextRecursive = function(id)
                    for i = 0, getNumOfChildren(id) - 1 do
                        local childId = getChildAt(id, i)

                        if childId ~= perspCamera then
                            mappingsText = mappingsText .. '    <i3dMapping id="' .. CreateI3DMappings.getValidNodeName(childId, numMappingsByName) .. '" node="' .. CreateI3DMappings.getNodePathIndices(childId, sceneId) .. '"/>\n'
                            createMappingsTextRecursive(childId)
                        end
                    end
                end

                createMappingsTextRecursive(sceneId)

                self.mappingsTextArea:setValue(mappingsText .. '</i3dMappings>')
            else
                self.mappingsTextArea:setValue("Info:\n  - Scenegraph is empty.")
            end
        else
            self.mappingsTextArea:setValue("Info:\n  - Creating I3D mappings from a maps Scenegraph is not possible, please select individual items instead.")
        end
    end

    -- Added for release version
    local message = ""
    local numDuplicates = CreateI3DMappings.NUMBER_DUPLICATE_NAMES
    local numWhitespace = CreateI3DMappings.NUMBER_WHITESPACE_NAMES

    if numDuplicates > 0 then
        message = `Duplicate Names: {numDuplicates}\n`
    end

    if numWhitespace > 0 then
        message = `{message}Names Containing Whitespace: {numWhitespace}`
    end

    if message ~= "" then
        self:showMessageBox(`Resolved XML naming violations:\n\n{message}`, "Info")
    end

    CreateI3DMappings.NUMBER_DUPLICATE_NAMES = 0
    CreateI3DMappings.NUMBER_WHITESPACE_NAMES = 0
end

function CreateI3DMappings:copyAll()
    setClipboard(self.mappingsTextArea:getValue():match("^(.*%S)%s*$"))
end

function CreateI3DMappings:showMessageBox(text, title)
    if text ~= nil then
        if MessageBox == nil then
            source("ui/MessageBox.lua")
        end

        if self.messageBoxWindow ~= nil then
            self.messageBoxWindow:close()
        end

        self.messageBoxWindow = MessageBox.show(title or "Message", text, function() self.messageBoxWindow = nil end)
    end
end

function CreateI3DMappings:close()
    self.window:close()
end

function CreateI3DMappings:onClose()
    if self.messageBoxWindow ~= nil then
        self.messageBoxWindow:close()
    end

    g_createI3DMappings = nil
end

function CreateI3DMappings.getValidNodeName(node, list)
    local name = getName(node)

    -- If the GE name contains spaces then convert mapping ID to correct camelCase
    if name:find(" ") then
        name = name:gsub("%W+(%w+)", function(str)
            return str:gsub("^%l", string.upper)
        end)
        CreateI3DMappings.NUMBER_WHITESPACE_NAMES += 1
    end

    if list ~= nil then
        -- If name is in use by another mapping then add 'duplicate_xx' suffix
        local numMappings = list[name]

        if numMappings == nil then
            list[name] = 1
        else
            list[name] = numMappings + 1
            name = string.format("%s_duplicate_%02.f", name, numMappings)
            CreateI3DMappings.NUMBER_DUPLICATE_NAMES += 1
        end
    end

    return name
end

function CreateI3DMappings.getNodePathIndices(node, sceneId)
    local parentNode = getParent(node) or 0

    if sceneId == nil then
        sceneId = getRootNode()
    end

    if parentNode == 0 or parentNode == sceneId or parentNode == nil or getChildIndex(parentNode) == -1 then
        return `{getChildIndex(node)}>`
    end

    if getParent(parentNode) == sceneId then
        return `{CreateI3DMappings.getNodePathIndices(parentNode, sceneId)}{getChildIndex(node)}`
    end

    return `{CreateI3DMappings.getNodePathIndices(parentNode, sceneId)}|{getChildIndex(node)}`
end

CreateI3DMappings.new()
