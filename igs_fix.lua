local gmTeams = {}
hook.Add( "PostGamemodeLoaded", "IGS:JobFix", function()
	if RPExtraTeams and next( RPExtraTeams ) ~= nil then
		gmTeams = RPExtraTeams
	elseif rp and rp.teams and next( rp.teams ) ~= nil then
		gmTeams = rp.teams
	end
end)

hook.Remove("playerCanChangeTeam", "IGS" )
hook.Add("playerCanChangeTeam", "IGS", function(pl, iTeam, bForce)
	local TEAM = gmTeams[iTeam]
	local ITEM = IGS.PlayerHasOneOf(pl, IGS.ITEMS.DRP.JOBS[TEAM.command])
	if ITEM ~= nil then -- донатный итем
		local allow, message = hook.Run("IGS.playerCanChangeTeam", pl, iTeam, bForce)
		return allow or tobool(ITEM), message or "Это для донатеров (/donate)"
	end
end)
