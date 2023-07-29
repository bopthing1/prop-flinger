local DEFAULT_FORCE_AMOUNT = 1000000000

TOOL.Category = "Fun"
TOOL.Name = "Flinger Tool"
TOOL.Command = nil
TOOL.ConfigName = ""

if CLIENT then
    language.Add("tool.flingertool.name", "Flinger Tool")
    language.Add("tool.flingertool.desc", "Fling anything that is flingable. Also you can adjust the force.")
    language.Add("tool.flingertool.0", "Left Click: Fling  Reload: Reset values")
    language.Add("tool.flingertool.forcelabel1", "horizontal force:")
    language.Add("tool.flingertool.forcelabel2", "vertical force:")
end

TOOL.ClientConVar["force_amount"] = DEFAULT_FORCE_AMOUNT


function TOOL:LeftClick(trace)
    if CLIENT then return true end

    local ply = self:GetOwner()

    print(self:GetClientNumber("force_amount"))

    if (IsValid(trace.Entity) and not trace.Entity:IsNPC()) then -- gmod crashes if you try to fling an npc
        local physObj = trace.Entity:GetPhysicsObject()
        local dir = ply:GetAimVector() * 999999999999999999999999

        physObj:ApplyForceOffset(
            (dir * self:GetClientNumber("force_amount")),
            trace.HitPos)
    end

    return true
end

function TOOL:Reload(trace)
    if CLIENT then return true end

    self.ClientConVar["force_amount"] = DEFAULT_FORCE_AMOUNT

    return true
end

local conVarsDefault = TOOL:BuildConVarList()

function TOOL.BuildCPanel(CPanel)
    CPanel:AddControl("Header", { Description = "#tool.flingertool.desc" })
    CPanel:AddControl("Slider",
        {
            Label = "#tool.flingertool.forcelabel1",
            Command = "flingertool_force_amount",
            Type = "Float",
            Min = 0.5,
            Max = 1000000000000
        })
end
