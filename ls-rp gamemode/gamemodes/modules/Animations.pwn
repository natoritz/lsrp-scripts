// Variables

static const g_aPreloadLibs[105][] =
{
	"AIRPORT",      /*"ATTRACTORS",*/   "BAR",          "BASEBALL",     "BD_FIRE",
	"BEACH",        "BENCHPRESS",   /*"BF_INJECTION",*/ /*"BIKE_DBZ",*/     "BIKED",
	/*"BIKEH",*/        /*"BIKELEAP",*/     "BIKES",        "BIKEV",        /*"BLOWJOBZ",*/
	"BMX",          "BOMBER",       "BOX",          "BSKTBALL",     "BUDDY",
	"BUS",          "CAMERA",       "CAR",          /*"CAR_CHAT",*/     "CARRY",
	/*"CASINO",*/       /*"CHAINSAW",*/     "CHOPPA",       "CLOTHES",      "COACH",
	"COLT45",       "COP_AMBIENT",  /*"COP_DVBYZ",*/    "CRACK",        "CRIB",
	/*"DAM_JUMP",*/     "DANCING",      "DEALER",       /*"DILDO",*/        "DODGE",
	"DOZER",        "DRIVEBYS",     "FAT",          "FIGHT_B",      "FIGHT_C",
	"FIGHT_D",      "FIGHT_E",      /*"FINALE",       "FINALE2",*/      "FLAME",
	"FLOWERS",      "FOOD",         /*"FREEWEIGHTS",*/  "GANGS",        "GFUNK",
	"GHANDS",       /*"GHETTO_DB",*/    /*"GOGGLES",*/      "GRAFFITI",     "GRAVEYARD",
	"GRENADE",      "GYMNASIUM",    "HAIRCUTS",     /*"HEIST9",*/       "INT_HOUSE",
	"INT_OFFICE",   /*"INT_SHOP",*/     "JST_BUISNESS", "KART",         "KISSING",
	"KNIFE",        "LAPDAN1",      "LAPDAN2",      /*"LAPDAN3",*/      /*"LOWRIDER",*/
	"MD_CHASE",     /*"MD_END",*/       "MEDIC",        "MISC",         "MTB",
	"MUSCULAR",     "NEVADA",       "ON_LOOKERS",   "OTB",          "PARACHUTE",
	"PARK",         /*"PAULNMAC",*/     "PED",          /*"PLAYER_DVBYS",*/ "PLAYIDLES",
	"POLICE",       "POOL",         "POOR",         "PYTHON",       "QUAD",
	"QUAD_DBZ",     "RAPPING",      "RIFLE",        "RIOT",         /*"ROB_BANK",*/
	"ROCKET",       /*"RUNNINGMAN",*/   "RUSTLER",      "RYDER",        /*"SAMP",*/
	"SCRATCHING",   /*"SEX",*/          "SHAMAL",       "SHOP",         "SHOTGUN",
	"SILENCED",     "SKATE",        "SMOKING",      "SNIPER",       "SNM",
	"SPRAYCAN",     "STRIP",        "SUNBATHE",     "SWAT",         "SWEET",
	"SWIM",         "SWORD",        "TANK",         /*"TATTOOS",*/      "TEC",
	"TRAIN",        "TRUCK",        "UZI",          "VAN",          /*"VENDING",*/
	"VORTEX",       "WAYFARER",     "WEAPONS",      "WOP",          "WUZI"
};

// Functions

PreloadAnimations(playerid)
{
	for(new i = 0; i < sizeof(g_aPreloadLibs); ++i)
	{
	    ApplyAnimation(playerid, g_aPreloadLibs[i], "null", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return true;
}

AnimationCheck(playerid, bool:caranim = false)
{
	if(PlayerData[playerid][pInjured] || DeathMode{playerid} || KnockedOut{playerid} || IsTazed{playerid})
	    return true;

	if(!caranim)
	{
		if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) 
		{
			return true;
		}
	}
	else
	{
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER && GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)
		{
			return true;
		} 
	}	

	return false;
}

// Commands

YCMD:sa(playerid, params[], help) = stopanim;

CMD:stopanim(playerid, params[])
{
	if(IsTazed{playerid} || KnockedOut{playerid})
	    return SendClientMessage(playerid, COLOR_WHITE, "Don't abuse /stopanim when tazed/knocked out");

	if(PlayerData[playerid][pInjured] || DeathMode{playerid} || KnockedOut{playerid} || IsTazed{playerid})
	    return SendClientMessage(playerid, COLOR_GRAD1, "The animation cannot be stopped at this time.");

	if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
	{
	    if(GetPlayerCameraMode(playerid) == 55)
		{
            RemovePlayerDriveby(playerid);
		}

        PlayerData[playerid][pAnimation] = 0;

		SendClientMessage(playerid, COLOR_WHITE, "HINT: Use key {FFFF00}H{FFFFFF} to lean in and out. /stopanim may cause you to desync.");
	    return true;
	}

    if(PlayerData[playerid][pAnimation])
    {
		if(!IsPlayerInAnyVehicle(playerid)) 
        {
            ClearAnimations(playerid, 1);

            ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0);
        }
        else 
        {
            ApplyAnimationEx(playerid, "CAR", "TAP_HAND", 4.0, 0, 0, 0, 0, 0, 0);
        }

		PlayerData[playerid][pAnimation] = 0;
	}
	return true;
}

CMD:uncarry(playerid, params[])
{
    if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CARRY) SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	return true;
}

CMD:carry(playerid, params[])
{
    if(GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_CARRY) SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
	return true;
}

CMD:aim(playerid, params[])
{
    if(AnimationCheck(playerid))
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    if((gettime() - AnimCooldown[playerid]) < 5) 
		return SendClientMessage(playerid, COLOR_LIGHTRED, "You need to wait 5 seconds between each animation");

    PlayerData[playerid][pAnimation] = 1;
    ApplyAnimation(playerid, "PED", "gang_gunstand", 4.0, 1, 0, 0, 0, 0, 1);

    AnimCooldown[playerid] = gettime();
   	return true;
}

CMD:taxil(playerid, params[])
{
    if(AnimationCheck(playerid))
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    if((gettime() - AnimCooldown[playerid]) < 5) 
		return SendClientMessage(playerid, COLOR_LIGHTRED, "You need to wait 5 seconds between each animation");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "MISC", "Hiker_Pose_L", 4.0, 0, 1, 1, 1, 0, 1);

    AnimCooldown[playerid] = gettime();
   	return true;
}

CMD:taxir(playerid, params[])
{
    if(AnimationCheck(playerid))
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    if((gettime() - AnimCooldown[playerid]) < 5) 
		return SendClientMessage(playerid, COLOR_LIGHTRED, "You need to wait 5 seconds between each animation");

    PlayerData[playerid][pAnimation] = 1;

   	ApplyAnimation(playerid, "MISC", "Hiker_Pose", 4.0, 0, 1, 1, 1, 0, 1);

   	AnimCooldown[playerid] = gettime();
   	return true;
}

CMD:stretch(playerid, params[])
{
    if(AnimationCheck(playerid))
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    if((gettime() - AnimCooldown[playerid]) < 5) 
		return SendClientMessage(playerid, COLOR_LIGHTRED, "You need to wait 5 seconds between each animation");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "PLAYIDLES", "stretch", 4.1, 0, 0, 0, 0, 0, 1);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:flip(playerid, params[])
{
    if(AnimationCheck(playerid))
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    if((gettime() - AnimCooldown[playerid]) < 5) 
		return SendClientMessage(playerid, COLOR_LIGHTRED, "You need to wait 5 seconds between each animation");

    PlayerData[playerid][pAnimation] = 1;

   	ApplyAnimation(playerid, "PED", "KD_left", 4.1, 0, 1, 1, 1, 0, 1);
    
   	AnimCooldown[playerid] = gettime();
   	return true;
}

CMD:slapass(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    if((gettime() - AnimCooldown[playerid]) < 5) 
		return SendClientMessage(playerid, COLOR_LIGHTRED, "You need to wait 5 seconds between each animation");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "SWEET", "sweet_ass_slap", 4.1, false, false, false, false, 0, true);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:dance(playerid, params[])
{
    if(AnimationCheck(playerid))
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    if((gettime() - AnimCooldown[playerid]) < 5) 
		return SendClientMessage(playerid, COLOR_LIGHTRED, "You need to wait 5 seconds between each animation");

    new animid;

   	if(sscanf(params, "d", animid)) 
        return SendClientMessage(playerid, COLOR_GREY, "USAGE: /dance [1-13]");

	switch(animid)
	{
		case 1: SetPlayerSpecialAction(playerid, 5);
	    case 2: SetPlayerSpecialAction(playerid, 6);
        case 3: SetPlayerSpecialAction(playerid, 7);
	    case 4: SetPlayerSpecialAction(playerid, 8);
	    case 5: ApplyAnimation(playerid, "DANCING", "DAN_Down_A", 4.0, 1, 0, 0, 0, 0, 1);
    	case 6: ApplyAnimation(playerid, "DANCING", "DAN_Left_A", 4.0, 1, 0, 0, 0, 0, 1);
     	case 7: ApplyAnimation(playerid, "DANCING", "DAN_Loop_A", 4.0, 1, 0, 0, 0, 0, 1);
      	case 8: ApplyAnimation(playerid, "DANCING", "DAN_Right_A", 4.0, 1, 0, 0, 0, 0, 1);
       	case 9: ApplyAnimation(playerid, "DANCING", "DAN_Up_A", 4.0, 1, 0, 0, 0, 0, 1);
        case 10: ApplyAnimation(playerid, "DANCING", "dnce_M_a", 4.0, 1, 0, 0, 0, 0, 1);
       	case 11: ApplyAnimation(playerid, "DANCING", "dnce_M_b", 4.0, 1, 0, 0, 0, 0, 1);
        case 12: ApplyAnimation(playerid, "DANCING", "dnce_M_c", 4.0, 1, 0, 0, 0, 0, 1);
        case 13: ApplyAnimation(playerid, "DANCING", "dnce_M_d", 4.0, 1, 0, 0, 0, 0, 1);
  		default: SendClientMessage(playerid, COLOR_GREY, "USAGE: /dance [style 1-13]");
	}

	if(animid >= 1 && animid <= 13) PlayerData[playerid][pAnimation] = 1;

    AnimCooldown[playerid] = gettime();
 	return true;
}

CMD:strip(playerid, params[])
{
    if(AnimationCheck(playerid))
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    if((gettime() - AnimCooldown[playerid]) < 5) 
		return SendClientMessage(playerid, COLOR_LIGHTRED, "You need to wait 5 seconds between each animation");

    new animid;

   	if(sscanf(params, "d", animid)) 
        return SendClientMessage(playerid, COLOR_GREY, "USAGE: /strip [1-11]");

	switch(animid)
	{
		case 1: ApplyAnimation(playerid,"DANCING", "DAN_Loop_A", 4.1, 1, 1, 1, 1, 1, 1);
		case 2: ApplyAnimation(playerid,"DANCING", "dnce_M_a", 4.1, 1, 0, 0, 1, 1, 1);
		case 3: ApplyAnimation(playerid,"DANCING", "dnce_M_b", 4.1, 1, 1, 1, 1, 1, 1);
		case 4: ApplyAnimation(playerid,"DANCING", "dnce_M_c", 4.1, 1, 1, 1, 1, 1, 1);
		case 5: ApplyAnimation(playerid,"DANCING", "dnce_M_d", 4.1, 1, 0, 0, 1, 1, 1);
		case 6: ApplyAnimation(playerid,"DANCING", "dnce_M_e", 4.1, 1, 0, 0, 1, 1, 1);
		case 7: ApplyAnimation(playerid,"DANCING", "bd_clap1", 4.1, 1, 1, 1, 1, 1, 1);
		case 8: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE1);
		case 9: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE2);
		case 10: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE3);
		case 11: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE4);
  		default: SendClientMessage(playerid, COLOR_GREY, "USAGE: /strip [style 1-11]");
	}

	if(animid >= 1 && animid <= 11) PlayerData[playerid][pAnimation] = 1;

    AnimCooldown[playerid] = gettime();
 	return true;
}

CMD:wave(playerid, params[])
{
    if(AnimationCheck(playerid))
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    if((gettime() - AnimCooldown[playerid]) < 5) 
		return SendClientMessage(playerid, COLOR_LIGHTRED, "You need to wait 5 seconds between each animation");

   	new animid;

   	if(sscanf(params,"d",animid)) return SendClientMessage(playerid, COLOR_GREY, "USAGE:/wave [1-3]");

	switch(animid)
	{
 		case 1: ApplyAnimation(playerid, "ON_LOOKERS", "wave_loop", 4.0, 1, 0, 0, 0, 0, 1);
 		case 2: ApplyAnimation(playerid, "KISSING", "gfwave2", 4.0, 0, 0, 0, 0, 0, 1);
 		case 3: ApplyAnimation(playerid, "PED", "endchat_03", 4.0, 0, 0, 0, 0, 0, 1);
 		default: SendClientMessage(playerid, COLOR_GREY, "USAGE/wave [1-3]");
 	}

 	if(animid >= 1 && animid <= 3) PlayerData[playerid][pAnimation] = 1;

 	AnimCooldown[playerid] = gettime();
 	return true;
}

CMD:handsup(playerid, params[])
{
    if(AnimationCheck(playerid))
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    if((gettime() - AnimCooldown[playerid]) < 5) 
		return SendClientMessage(playerid, COLOR_LIGHTRED, "You need to wait 5 seconds between each animation");

    PlayerData[playerid][pAnimation] = 1;
    AnimCooldown[playerid] = gettime();
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_HANDSUP);
	return true;
}

CMD:rifflewalkstance(playerid, params[])
{
    if(AnimationCheck(playerid))
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    if((gettime() - AnimCooldown[playerid]) < 5) 
		return SendClientMessage(playerid, COLOR_LIGHTRED, "You need to wait 5 seconds between each animation");

    PlayerData[playerid][pAnimation] = 1;
 	ApplyAnimation(playerid,"PED","WALK_armed", 4.1, 1, 1, 1, 1, 1, 1);
 	AnimCooldown[playerid] = gettime();

	return true;
}

CMD:rifflerunstance(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    if((gettime() - AnimCooldown[playerid]) < 5) 
		return SendClientMessage(playerid, COLOR_LIGHTRED, "You need to wait 5 seconds between each animation");

    PlayerData[playerid][pAnimation] = 1;
    AnimCooldown[playerid] = gettime();

	ApplyAnimation(playerid,"PED","run_armed", 4.1, 1, 1, 1, 1, 1, 1);
	return true;
}

CMD:gsign(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    if((gettime() - AnimCooldown[playerid]) < 5) 
		return SendClientMessage(playerid, COLOR_LIGHTRED, "You need to wait 5 seconds between each animation");

    new animid;

   	if(sscanf(params, "d", animid))
   		return SendClientMessage(playerid, COLOR_GREY, "USAGE: /gsign [1-10]");

	switch(animid)
	{

  		case 1: ApplyAnimation(playerid, "GHANDS", "gsign1", 4.0, false, true, true, true, 1, true);
        case 2: ApplyAnimation(playerid, "GHANDS", "gsign1LH", 4.0, false, true, true, true, 1, true);
        case 3: ApplyAnimation(playerid, "GHANDS", "gsign2", 4.0, false, true, true, true, 1, true);
        case 4: ApplyAnimation(playerid, "GHANDS", "gsign2LH", 4.0, false, true, true, true, 1, true);
        case 5: ApplyAnimation(playerid, "GHANDS", "gsign3", 4.0, false, true, true, true, 1, true);
        case 6: ApplyAnimation(playerid, "GHANDS", "gsign3LH", 4.0, false, true, true, true, 1, true);
        case 7: ApplyAnimation(playerid, "GHANDS", "gsign4", 4.0, false, true, true, true, 1, true);
        case 8: ApplyAnimation(playerid, "GHANDS", "gsign4LH", 4.0, false, true, true, true, 1, true);
        case 9: ApplyAnimation(playerid, "GHANDS", "gsign5", 4.0, false, true, true, true, 1, true);
        case 10: ApplyAnimation(playerid, "GHANDS", "gsign5LH", 4.0, false, true, true, true, 1, true);
  		default: SendClientMessage(playerid, COLOR_GREY, "USAGE: /gsign [1-10]");
   	}

   	if(animid >= 1 && animid <= 10) PlayerData[playerid][pAnimation] = 1;

   	AnimCooldown[playerid] = gettime();
   	return true;
}

CMD:dj(playerid, params[])
{
	if(AnimationCheck(playerid))
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

	new animid;

   	if(sscanf(params,"d",animid))
	   return SendClientMessage(playerid, COLOR_GREY, "USAGE:/dj [1-4]");

	switch(animid)
	{
		case 1: ApplyAnimation(playerid, "SCRATCHING", "scdldlp", 4.0, 1, 0, 0, 0, 0, 1);
    	case 2: ApplyAnimation(playerid, "SCRATCHING", "scdlulp", 4.0, 1, 0, 0, 0, 0, 1);
     	case 3: ApplyAnimation(playerid, "SCRATCHING", "scdrdlp", 4.0, 1, 0, 0, 0, 0, 1);
     	case 4: ApplyAnimation(playerid, "SCRATCHING", "scdrulp", 4.0, 1, 0, 0, 0, 0, 1);
      	default: SendClientMessage(playerid, COLOR_GREY, "USAGE:/dj [1-4]");
	}

	if(animid >= 1 && animid <= 4) PlayerData[playerid][pAnimation] = 1;

	AnimCooldown[playerid] = gettime();
	return true;
}

CMD:camera3(playerid, params[])
{
    if(AnimationCheck(playerid)) return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "CAMERA", "CAMCRCH_IDLELOOP", 4.0, 0, 0, 0, 1, 0, 1);
    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:camera2(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "CAMERA", "CAMSTND_CMON", 4.0, 0, 0, 0, 1, 0, 1);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:camshot1(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "CAMERA", "PICCRCH_IN", 4.1, false, false, false, false, 0, false);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:cpr(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "MEDIC", "CPR", 4.1, false, false, false, false, 0, false);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:crawl(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "PED", "CAR_CRAWLOUTRHS", 4.1, false, false, false, false, 0, false);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:dropflag(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "CAR", "FLAG_DROP", 4.1, false, false, false, false, 0, false);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:fixcar(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    if(IsPlayerInAnyVehicle(playerid)) return true;

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "CAR", "FIXN_CAR_LOOP", 4.1, false, false, false, true, 0, false);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:fixcarout(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    if(IsPlayerInAnyVehicle(playerid)) return true;

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "CAR", "FIXN_CAR_OUT", 4.1, false, false, false, false, 0, false);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:bat(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "CRACK", "BBALBAT_IDLE_01", 4.1, true, false, false, false, 0, false);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:bat2(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "CRACK", "BBALBAT_IDLE_02", 4.1, true, false, false, false, 0, false);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:batstance(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "BASEBALL", "BAT_IDLE", 4.1, true, false, false, false, 0, false);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:dealerstance(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "DEALER", "DEALER_IDLE", 4.1, true, false, false, false, 0, false);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:dealerstance2(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "DEALER", "DEALER_IDLE_01", 4.1, true, false, false, false, 0, false);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:dealerstance3(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "DEALER", "DEALER_IDLE_02", 4.1, true, false, false, false, 0, false);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:dealerstance4(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "DEALER", "DEALER_IDLE_03", 4.1, true, false, false, false, 0, false);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:lean(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "GANGS", "LEANIDLE", 4.0,0,1,1,1,0);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:cry(playerid, params[])
{
    if(AnimationCheck(playerid))
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "GRAVEYARD", "MRNF_LOOP", 4.1, true, false, false, false, 0, true);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:seduce(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "JST_BUISNESS", "GIRL_02", 4.1, false, false, false, true, 0, true);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:comeon(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "MISC", "BMX_COMEON", 4.1, false, false, false, false, 0, true);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:sleep(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "CRACK", "crckidle2", 4.1, true, false, false, false, 0, true);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:crack(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "CRACK", "CRCKDETH2", 4.1, true, false, false, false, 0, true);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:crack2(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "CRACK", "CRCKIDLE1", 4.1, true, false, false, false, 0, true);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:crack3(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "CRACK", "CRCKDETH3", 4.1, false, false, false, true, 0, true);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:crack4(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "CRACK", "CRCKDETH1", 4.1, false, false, false, true, 0, true);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:stretch2(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "PLAYIDLES", "STRETCH", 4.1, false, false, false, false, 0, true);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:rap1(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "RAPPING", "RAP_A_LOOP", 4.1, true, true, false, false, 0, true);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:rap2(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "RAPPING", "RAP_B_LOOP", 4.1, true, true, false, false, 0, true);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:rap3(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "RAPPING", "RAP_C_LOOP", 4.1, true, true, false, false, 0, true);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:fuckyou2(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "RIOT", "RIOT_FUKU", 4.0, false, false, false, false, 0, true);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:riot2(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "RIOT", "RIOT_CHANT", 4.0, false, false, false, false, 0, true);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:riot3(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "RIOT", "RIOT_PUNCHES", 4.0, false, false, false, false, 0, true);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:shouts(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "RIOT", "RIOT_SHOUT", 4.0, false, false, false, false, 0, true);

    AnimCooldown[playerid] = gettime();
    return true;
}

YCMD:provoke(playerid, params[], help) = what;

CMD:what(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "RIOT", "RIOT_ANGRY", 4.0, false, false, false, false, 0, true);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:camera1(playerid, params[])
{
    if(AnimationCheck(playerid)) return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "CAMERA", "camcrch_cmon", 4.0, 0, 0, 0, 1, 0, 1);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:baridle(playerid, params[])
{
    if(AnimationCheck(playerid)) return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "BAR", "BARMAN_IDLE", 4.0, false, false, false, false, 0, true);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:barorder(playerid, params[])
{
    if(AnimationCheck(playerid)) return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "BAR", "BARCUSTOM_ORDER", 4.0, false, false, false, false, 0, true);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:servebottle(playerid, params[])
{
    if(AnimationCheck(playerid)) return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "BAR", "BARSERVE_BOTTLE", 4.0, false, false, false, false, 0, true);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:serveglass(playerid, params[])
{
    if(AnimationCheck(playerid)) return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "BAR", "BARSERVE_GLASS", 4.0, false, false, false, false, 0, true);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:stand(playerid, params[])
{
    if(AnimationCheck(playerid)) return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "WUZI", "WUZI_STAND_LOOP", 4.0, false, false, false, true, 0, true);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:fightstance(playerid, params[])
{
    if(AnimationCheck(playerid)) return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "PED", "FIGHTIDLE", 4.1, true, false, false, false, 0, true);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:idle(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    if((gettime() - AnimCooldown[playerid]) < 5)  
        return SendClientMessage(playerid, COLOR_LIGHTRED, "You need to wait 5 seconds between each animation");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "PLAYIDLES", "SHIFT", 4.1, false, false, false, false, 0, true);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:crossarm(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;
    
    ApplyAnimation(playerid, "COP_AMBIENT", "COPLOOK_LOOP", 4.1, false, false, false, true, 0, true);

    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:crossarm3(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "COP_AMBIENT", "COPLOOK_THINK", 4.1, false, false, false, false, 0, true);
    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:crossarm2(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "COP_AMBIENT", "COPLOOK_NOD", 4.1, false, false, false, false, 0, true);
    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:crosswin(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "OTB", "WTCHRACE_WIN", 4.1, false, false, false, false, 0, true);
    AnimCooldown[playerid] = gettime();
    return true;
}

CMD:rifflestance(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "PED", "IDLE_ARMED", 4.1, true, false, false, false, 0, true);
    return true;
}

CMD:lean2(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "MISC", "PLYRLEAN_LOOP", 4.1, true, true, false, false, 0, true);
    return true;
}

CMD:mourn(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "GRAVEYARD", "MRNM_LOOP", 4.1, true, false, false, false, 0, true);
    return true;
}

CMD:old(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "PED", "IDLESTANCE_OLD", 4.1, true, false, false, false, 0, true);
    return true;
}

CMD:priest(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;
    
    ApplyAnimation(playerid, "GRAVEYARD", "PRST_LOOPA", 4.1, true, false, false, false, 0, true);
    return true;
}

CMD:frontfall(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "PED", "FLOOR_HIT_F", 4.1, false, false, false, true, 0, true);
    return true;
}

CMD:fuckyou(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "PED", "FUCKU", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:cover(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "PED", "COWER", 4.1, false, false, false, true, 0, true);
    return true;
}

CMD:eatanim(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "PED", "GUM_EAT", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:exhausted(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "FAT", "IDLE_tired", 4.1, true, false, false, false, 0, true);
    return true;
}

CMD:tired(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "PED", "IDLE_TIRED", 4.1, true, false, false, false, 0, true);
    return true;
}

CMD:seat(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "PED", "SEAT_DOWN", 4.1, false, false, false, true, 0, true);
    return true;
}

CMD:uturn(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "PED", "TURN_180", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:fallkick(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "PED", "KO_SKID_FRONT", 4.1, false, false, false, true, 0, true);
    return true;
}

CMD:kickdoor(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "POLICE", "DOOR_KICK", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:lay(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "BEACH", "bather", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:laugh(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "RAPPING", "LAUGH_01", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:downpush(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "GANGS", "SHAKE_CARA", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:lowbump(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "GANGS", "SHAKE_CARSH", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:agree(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "GANGS", "INVITE_YES", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:deal(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "GANGS", "DEALER_DEAL", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:flex(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "BENCHPRESS", "GYM_BP_CELEBRATE", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:reject(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "GANGS", "INVITE_NO", 4.1, false, false, false, false, 0, true);
	return true;
}

CMD:shouldercheck(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "BD_FIRE", "BD_PANIC_04", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:spray(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "GRAFFITI", "SPRAYCAN_FIRE", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:upshout(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "ON_LOOKERS", "PANIC_SHOUT", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:washhands(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "BD_FIRE", "WASH_UP", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:dishes(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "BD_FIRE", "WASH_UP", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:getupb(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "FIGHT_E", "HIT_FIGHTKICK_B", 4.1, false, false, false, true, 0, true);
    return true;
}

CMD:shoutat(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "ON_LOOKERS", "SHOUT_01", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:shout2(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "ON_LOOKERS", "SHOUT_LOOP", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:fallhit(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "FIGHT_C", "HITC_3", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:forwardlook(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "BD_FIRE", "BD_PANIC_02", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:sipdrink(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "BAR", "DNK_STNDM_LOOP", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:sit(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "BEACH", "PARKSIT_M_LOOP", 4.1, false, false, false, true, 0, true);
    return true;
}

CMD:sit2(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "BEACH", "SITNWAIT_LOOP_W", 4.1, false, false, false, true, 0, true);
    return true;
}

CMD:sit3(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "BEACH", "PARKSIT_W_LOOP", 4.1, false, false, false, true, 0, true);
    return true;
}

CMD:crouchshoot(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "BUDDY", "BUDDY_CROUCHFIRE", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:crouchreload(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "BUDDY", "BUDDY_CROUCHRELOAD", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:aimshoot(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "BUDDY", "BUDDY_FIRE", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:aimshoot2(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "PYTHON", "PYTHON_FIRE", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:smokelean(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "SMOKING", "M_smklean_loop", 4.1, true, false, false, false, 0, true);
    return true;
}

CMD:smoke(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "GANGS", "smkcig_prtl", 4.1, false, true, true, true, 1, true);
    return true;
}

CMD:shotgun(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "BUDDY", "BUDDY_FIRE_POOR", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:shottyreload(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "BUDDY", "BUDDY_RELOAD", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:blockshot(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "BSKTBALL", "BBALL_DEF_JUMP_SHOT", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:defense(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "BSKTBALL", "BBALL_DEF_LOOP", 4.1, true, false, false, false, 0, true);
    return true;
}

CMD:defenser(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "BSKTBALL", "BBALL_DEF_STEPR", 4.1, true, true, true, false, 0, true);
    return true;
}

CMD:dribble(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "BSKTBALL", "BBALL_IDLE", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:dribble2(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "BSKTBALL", "BBALL_WALK", 4.1, true, true, true, false, 0, true);
    return true;
}

CMD:dribble3(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "BSKTBALL", "BBALL_RUN", 4.1, true, true, true, false, 0, true);
    return true;
}

CMD:throw(playerid, params[])
{
    if(AnimationCheck(playerid))
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "GRENADE", "WEAPON_THROW", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:dunk(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "BSKTBALL", "BBALL_DNK", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:dunk2(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "BSKTBALL", "BBALL_DNK_GLI", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:fakeshot(playerid, params[])
{
    if(AnimationCheck(playerid)) 
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "BSKTBALL", "BBALL_DNK_LND", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:jumpshot(playerid, params[])
{
    if(AnimationCheck(playerid))         
        return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "BSKTBALL", "BBALL_JUMP_SHOT", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:pickupball(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "BSKTBALL", "BBALL_PICKUP", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:angry(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "BSKTBALL", "BBALL_REACT_MISS", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:stealball(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "BSKTBALL", "BBALL_JUMP_END", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:backhit(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "FIGHT_B", "HITB_1", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:flykick(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "FIGHT_C", "FIGHTC_M", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:bitchslap(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "BASEBALL", "BAT_M", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:box1(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "FIGHT_B", "FIGHTB_1", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:box2(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "FIGHT_B", "FIGHTB_2", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:aimfast(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

	ApplyAnimation(playerid, "SNIPER", "WEAPON_SNIPER", 4.1, false, false, false, false, 0, true);
	return true;
}

CMD:choke(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "KNIFE", "KILL_KNIFE_PED_DIE", 4.1, false, true, true, true, 0, true);
    return true;
}

CMD:dodge(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "KNIFE", "KNIFE_HIT_1", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:groundhit(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "FIGHT_B", "FIGHTB_G", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:hit(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "FIGHT_B", "HITB_2", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:kickhim(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "POLICE", "DOOR_KICK", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:kungfu1(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "FIGHT_C", "FIGHTC_1", 4.1, false, true, true, false, 0, true);
    return true;
}

CMD:kungfu2(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "FIGHT_C", "FIGHTC_2", 4.1, false, true, true, false, 0, true);
    return true;
}

CMD:kungfu3(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "FIGHT_C", "FIGHTC_3", 4.1, false, true, true, false, 0, true);
	return true;
}

CMD:kungfublock(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "FIGHT_C", "FIGHTC_BLOCK", 4.1, false, true, true, false, 0, true);
    return true;
}

CMD:kungfustomp(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "FIGHT_C", "FIGHTC_G", 4.1, false, true, true, false, 0, true);
    return true;
}

CMD:crushjump(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "DODGE", "CRUSH_JUMP", 4.1, false, true, true, false, 0, true);
    return true;
}

CMD:coverdive(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "DODGE", "COVER_DIVE_01", 4.1, false, true, true, false, 0, true);
    return true;
}

CMD:coverdive2(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "DODGE", "COVER_DIVE_02", 4.1, false, true, true, false, 0, true);
    return true;
}

CMD:punch(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "RIOT", "RIOT_PUNCHES", 4.1, false, true, true, false, 0, true);
    return true;
}

CMD:lookout(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "ON_LOOKERS", "LKAROUND_LOOP", 4.1, false, true, true, false, 0, true);
    return true;
}

CMD:lookout2(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "ON_LOOKERS", "LKUP_LOOP", 4.1, false, true, true, false, 0, true);
    return true;
}

CMD:injured(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "SWEET", "SWEET_INJUREDLOOP", 4.1, false, true, true, true, 0, true);
    return true;
}

CMD:gotshot(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "SWEET", "LAFIN_SWEET", 4.1, false, true, true, true, 0, true);
    return true;
}

CMD:compready(playerid, params[])
{
    if(AnimationCheck(playerid))
	    return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "ROCKET", "RocketFire", 4.1, false, true, true, true, 1, true);
    return true;
}

CMD:animtest(playerid, params[])
{
    new lib[60], anim[60];

    if(sscanf(params, "s[60]s[60]", lib, anim)) return SendErrorMessage(playerid, "/animtest [lib] [anim]");

    ApplyAnimation(playerid, lib, anim, 4.1, false, false, false, true, 0, true);
    return true;
}

CMD:caranim(playerid, params[])
{
    if(AnimationCheck(playerid, true))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");
   
    if(isnull(params))
	   	return SendSyntaxMessage(playerid, "/caranim [relax/tap]");

    if(!strcmp(params, "relax", false))
    {
        PlayerData[playerid][pAnimation] = 1;

        ApplyAnimation(playerid, "CAR", "SIT_RELAXED", 4.0, true, false, false, false, 0, true);
        return true;
    }
    else if(!strcmp(params, "tap", false))
    {
        PlayerData[playerid][pAnimation] = 1;

        ApplyAnimation(playerid, "CAR", "TAP_HAND", 4.0, true, false, false, false, 0, true);
        return true;
    }
    else
    {
        SendSyntaxMessage(playerid, "/caranim [relax/tap]");
    }
   	return true;
}

CMD:salute(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "GHANDS", "GSIGN5LH", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:roadcross(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "PED", "ROADCROSS", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:push(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "FIGHT_D", "FIGHTD_3", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:payshop(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "DEALER", "SHOP_PAY", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:openright(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "VAN", "VAN_OPEN_BACK_RHS", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:openleft(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "VAN", "VAN_OPEN_BACK_LHS", 4.1, false, false, false, false, 0, true);
    return true;
}

CMD:getshot(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "PED", "KO_SHOT_STOM", 4.1, false, true, true, true, 0, true);
    return true;
}

CMD:fallover(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "PED", "KO_SHOT_FRONT", 4.1, false, true, true, true, 0, true);
    return true;
}

CMD:deskbored(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "INT_OFFICE", "OFF_SIT_BORED_LOOP", 4.1, true, false, false, false, 0, true);
    return true;
}

CMD:desksit(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

    PlayerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "INT_OFFICE", "OFF_SIT_IDLE_LOOP", 4.1, true, false, false, false, 0, true);
    return true;
}

CMD:chat(playerid, params[])
{
    if(AnimationCheck(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "Cannot play animation at this time.");

	new chatstyle = PlayerData[playerid][pTalk];

	PlayerData[playerid][pAnimation] = 1;

	switch(chatstyle)
	{
		case 0: ApplyAnimation(playerid, "PED", "IDLE_CHAT", 4.0, 0, 1, 1, 0, 0, 1);
		case 1: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkA", 4.0, 0, 1, 1, 0, 0, 1);
		case 2: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkB", 4.0, 0, 1, 1, 0, 0, 1);
		case 3: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkC", 4.0, 0, 1, 1, 0, 0, 1);
		case 4: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkD", 4.0, 0, 1, 1, 0, 0, 1);
		case 5: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkE", 4.0, 0, 1, 1, 0, 0, 1);
		case 6: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkF", 4.0, 0, 1, 1, 0, 0, 1);
		case 7: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkG", 4.0, 0, 1, 1, 0, 0, 1);
		case 8: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkH", 4.0, 0, 1, 1, 0, 0, 1);
	}

    return true;
}