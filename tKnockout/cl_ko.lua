local knockedOut = false
local wait = 15
local count = 60

Citizen.CreateThread(function()
	while true do
		Wait(1)
		local myPed = GetPlayerPed(-1)
		if IsPedInMeleeCombat(myPed) then
			if GetEntityHealth(myPed) < 115 then
				SetPlayerInvincible(PlayerId(), true)
				SetPedToRagdoll(myPed, 1000, 1000, 0, 0, 0, 0)
				wait = 15
				knockedOut = true
				SetEntityHealth(myPed, 116)
				wait = 15
			end
		end
		if knockedOut == true then
			SetPlayerInvincible(PlayerId(), true)
			DisablePlayerFiring(PlayerId(), true)
			SetPedToRagdoll(myPed, 1000, 1000, 0, 0, 0, 0)
			DoScreenFadeOut(1000)
			Citizen.Wait(1000)
			DoScreenFadeIn(1000)
			ResetPedRagdollTimer(myPed)
			SetTimecycleModifier("damage")
			Citizen.Wait(0)
			DrawMissionText2("~r~Vous êtes K.O !", 16000)
			Citizen.Wait(13000)
			DoScreenFadeOut(2000)
			Citizen.Wait(2000)
			DoScreenFadeIn(2000)
			blesse()
			Citizen.Wait(25000)
			DoScreenFadeOut(1000)
			Citizen.Wait(1000)
			ClearTimecycleModifier()
			DoScreenFadeIn(1000)
			noblesse()
			
			if wait >= 0 then
				count = count - 1
				if count == 0 then
					count = 60
					wait = wait - 1
					SetEntityHealth(myPed, GetEntityHealth(myPed)+4)
				end
			else
				SetPlayerInvincible(PlayerId(), false)
				knockedOut = false
			end
		end
	end
end)

function blesse()
    hurt = true
    RequestAnimSet("move_m@injured")
    SetPedMovementClipset(GetPlayerPed(-1), "move_m@injured", true)
end

function noblesse()
    hurt = false
    ResetPedMovementClipset(GetPlayerPed(-1))
    ResetPedWeaponMovementClipset(GetPlayerPed(-1))
    ResetPedStrafeClipset(GetPlayerPed(-1))
end

function DrawMissionText2(m_text, showtime)
    ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end
