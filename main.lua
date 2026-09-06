---------------------------
-- 88lkk Ui + Util
---------------------------

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/88lkk/Pandaware/refs/heads/main/assets/ui.lua"))()

---------------------------
-- Interface
---------------------------

local Window = Library:Window("pandaware")
Window:Toggle("sword aura", function(Toggled)
	if Toggled then
		Loop("sword aura", function()
			local Char = LocalPlayer.Character
			if not Char then task.wait() return end

			local Hum = Char:FindFirstChildOfClass("Humanoid")
			if not Hum or Hum.Health <= 0 then task.wait() return end

			local RArm = Char:FindFirstChild("Right Arm")
			if not RArm then task.wait() return end

			local Grip = RArm:FindFirstChild("RightGrip")
			if not Grip then task.wait() return end

			local Sword = Char:FindFirstChildOfClass("Tool")
			if not Sword then task.wait() return end

			local Handle = Sword:FindFirstChild("Handle")
			if not Handle then task.wait() return end

			for _, Player in Players:GetPlayers() do
				if Player == LocalPlayer then continue end

				local TChar = Player.Character
				if not TChar then continue end

				local THum = TChar:FindFirstChildOfClass("Humanoid")
				if not THum or THum.Health <= 0 then continue end

				if (Char:GetPivot().Position - TChar:GetPivot().Position).Magnitude < 15 then
					Attacking = true
					Grip.Enabled = false
					Handle.CFrame = TChar:GetPivot()
					Handle.Velocity = Vector3.zero
					Handle.RotVelocity = Vector3.zero
					Sword:Activate()
					continue
				end
			end

			task.wait()

			if Grip then
				Grip.Enabled = true
			end
		end)
	else
		Unloop("sword aura")
	end
end)
