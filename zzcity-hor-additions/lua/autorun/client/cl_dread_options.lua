if not CLIENT then return end

hook.Add("PopulateToolMenu", "zb_zh_dread_options", function()
    spawnmenu.AddToolMenuOption("Options", "alagri's ZHorror", "zb_zh_dread",
        "Crusher dread", "", "", function(panel)
            panel:ClearControls()

            if not LocalPlayer():IsAdmin() then
                panel:Help("Admins only.")
                return
            end

            panel:CheckBox("Dread enabled", "zb_zh_dread_enabled")
            panel:Help("Raises nearby players' heartrate when a crusher is close.")

            local slider = panel:NumSlider("Dread range", "zb_zh_dread_range", 25, 1500, 0)
            panel:Help("Distance at which a crusher starts affecting heartrate.")
        end)
end)
