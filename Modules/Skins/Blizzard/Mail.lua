local W, F, E, L = unpack(select(2, ...))
local S = W:GetModule("Skins")

local _G = _G

function S:MailFrame()
    if not self:CheckDB("mail") then
        return
    end

    self:CreateShadow(_G.MailFrame)
    self:CreateShadow(_G.OpenMailFrame)

    for i = 1, 2 do
        self:CreateBackdropShadow(_G["MailFrameTab" .. i])
    end
end

S:AddCallback("MailFrame")
