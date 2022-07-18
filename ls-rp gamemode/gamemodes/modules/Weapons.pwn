// Includes

#define BODY_PART_CHEST	(3)
#define BODY_PART_GROIN (4)
#define BODY_PART_LEFT_ARM (5)
#define BODY_PART_RIGHT_ARM (6)
#define BODY_PART_LEFT_LEG (7)
#define BODY_PART_RIGHT_LEG (8)
#define BODY_PART_HEAD (9)

// Variables

static const g_arrWeaponNames[][] =
{
	"Fist",
	"Brass Knuckles",
	"Golf Club",
	"Nightstick",
	"Knife",
	"Baseball Bat",
	"Shovel",
	"Pool Cue",
	"Katana",
	"Chainsaw",
	"Double Dildo",
	"Dildo",
	"Vibrator",
	"Silver Vibrator",
	"Flowers",
	"Cane/Brifcase",
	"Grenade",
	"Tear Gas",
	"Molotov Cocktail",
	"",
	"",
	"",
	"9mm",
	"Silences 9mm",
	"Desert Eagle",
	"Shotgun",
	"Sawnoff Shotgun",
	"Combat Shotgun",
	"Micro SMG",
	"MP5",
	"AK47",
	"M4",
	"Tec9",
	"Country Rifle",
	"Sniper Rifle",
	"Rocket Launcher",
	"HeatSeek Rocket Launcher",
	"Flamethrower",
	"Minigun",
	"Satchel Charge",
	"Detonator",
	"Spraycan",
	"Fire Extinguisher",
	"Camera",
	"Night Vision Goggles",
	"Thermal Goggles",
	"Parachute"
};

enum WeaponDamageInfo
{
	WeaponID,
	Float:WepDamage,
};

new WeaponDamage[][WeaponDamageInfo] =
{
	// WeaponID		WeaponDamage
	{0,				0.0},	//Unarmed
	{1,				15.0},	//Brass Knuckles
	{2,				15.0},	//Golf Club
	{3,				20.0},	//Nite Stick
	{4,				30.0},	//Knife
	{5,				10.0},	//Baseball Bat
	{6,				15.0},	//Shovel
	{7,				10.0},	//Pool Cue
	{8,				35.0},	//Katana
	{9,				0.0},	//Chainsaw
	{10,			1.0},	//Purple Dildo
	{12,			1.0},	//Large White Vibrator
	{11,			1.0},	//Small White Vibrator
	{13,			1.0},	//Silver Vibrator
	{14,			0.0},	//Flowers
	{15,			7.0},	//Cane
	{16,			0.0},	//Grenade
	{17,			0.0},	//Tear Gas
	{18,			10.0},	//Molotov Coctail
	{19,			0.0},	//Invalid Weapon
	{20,			0.0},	//Invalid Weapon
	{11,			0.0},	//Invalid Weapon
	{22,			20.0},	//Colt 9mm
	{23,			40.0},	//Silenced Colt 9mm
	{24,			45.5},	//Desert Eagle
	{25,			35.0},	//Shotgun
	{26,			0.0},	//Sawn-off Shotgun
	{27,			0.0},	//Combat Shotgun
	{28,			15.0},	//Micro SMG
	{29,			28.0},	//MP5
	{30,			40.0},	//AK-47
	{31,			35.0},	//M4
	{32,			15.0},	//Tec9
	{33,			75.0},	//Country Rifle (was 75 - 85)
	{34,			500.0},	//Sniper Rifle
	{35,			0.0},	//Rocket Launcher
	{36,			0.0},	//HS Rocket Launcher
	{37,			0.0},	//Flamethrower
	{38,			0.0},	//Minigun
	{39,			0.0},	//Satchel Charge
	{40,			2.0},	//Satchel Detonator
	{41,			0.0},	//Spraycan
	{42,			0.0},	//Fire Extinguisher
	{43,			0.0},	//Camera
	{44,			0.0},	//Nightvision Goggles
	{45,			0.0},	//Thermal Goggles
	{46,			0.0},	//Thermal Goggles
	{47,			0.0},	//Fake Pistol
	{48,			0.0},	//Invalid Weapon
	{49,			15.0},	//Vehicle
	{50,			0.0},	//Heli-Blades
	{51,			100.0},	//Explosion
	{52,			0.0},	//Invalid Weapon
	{53,			5.0},	//Drowned
	{54,			0.0}	//Splat
};

enum E_DROPPED_WEAPONS_DATA
{
	bool:DropExists,
    DropGunAmmount[2],
    Float:DropGunPos[3],
    DropLicense,
    DropObj,
    DropMinutes,
	DropWorld,
	DropInterior,
};

new DroppedWeapons[MAX_DROP_ITEMS][E_DROPPED_WEAPONS_DATA];

static const GunObjectIDs[200] =
{
	1575,  331, 333, 334, 335, 336, 337, 338, 339, 341, 321, 322, 323, 324, 325, 326, 342, 343, 344, -1,  -1 , -1,
    346, 347, 348, 349, 350, 351, 352, 353, 355, 356, 372, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366, 367,
    368, 369, 1575
};

enum E_DAMAGE_INFO
{
	eDamageTaken,
	eDamageTime,
	eDamageWeapon,
	eDamageBodypart,
	eDamageArmor,
	eDamageBy,
	eDamageID
}

new DamageInfo[MAX_PLAYERS][100][E_DAMAGE_INFO];

// Functions

GivePlayerWeaponEx(playerid, weaponid, ammo)
{
	if(weaponid < 0 || weaponid > 46)
	    return false;

	PlayerData[playerid][pGuns][g_aWeaponSlots[weaponid]] = weaponid;
	PlayerData[playerid][pAmmo][g_aWeaponSlots[weaponid]] = ammo;

	return GivePlayerWeapon(playerid, weaponid, ammo);
}

IsInvalidWeapon(weaponid)
{
	if((weaponid < 1 || weaponid > 46 || weaponid == 19 || weaponid == 20 || weaponid == 21 || weaponid == 39 || weaponid == 40 || weaponid == 44 || weaponid == 45))
		return true;

	return false;
}

GivePlayerValidWeapon(playerid, weaponid, ammo, license = 0, bool:notif = true, bool:replace = true)
{
	if(weaponid == 16 || weaponid == 17 || weaponid == 18)
	{
	    GivePlayerWeapon(playerid, weaponid, ammo);
	    return true;
	}

	if(IsInvalidWeapon(weaponid)) return false;

	new slot_taken = IsWeaponSlotTaken(playerid, weaponid);

	if(slot_taken && replace)
	{
	    new oldweapon = PlayerData[playerid][pWeapon][slot_taken - 1];

	    RemoveWeapon(playerid, oldweapon);
	}

	if(IsMelee(weaponid))
	{
 		PlayerData[playerid][pWeapon][0] = weaponid;
		PlayerData[playerid][pAmmunation][0] = ammo;

		if(notif) SendClientMessageEx(playerid, COLOR_GREEN, "[Melee] You will now spawn with %s", ReturnWeaponName(weaponid));
	}
	else if(IsPrimary(weaponid))
	{
		PlayerData[playerid][pWeapon][1] = weaponid;
		PlayerData[playerid][pAmmunation][1] = ammo;

		if(notif) SendClientMessageEx(playerid, COLOR_GREEN, "[Primary weapon] You will now spawn with %s", ReturnWeaponName(weaponid));

		PlayerData[playerid][pPrimaryLicense] = license;
	}
	else if(IsSecondary(weaponid))
	{
		PlayerData[playerid][pWeapon][2] = weaponid;
		PlayerData[playerid][pAmmunation][2] = ammo;

		if(notif) SendClientMessageEx(playerid, COLOR_GREEN, "[Secondary weapon] You will now spawn with %s", ReturnWeaponName(weaponid));

		PlayerData[playerid][pSecondaryLicense] = license;
	}

	PlayerData[playerid][pGuns][g_aWeaponSlots[weaponid]] = weaponid;
	PlayerData[playerid][pAmmo][g_aWeaponSlots[weaponid]] = ammo;

	GivePlayerWeapon(playerid, weaponid, ammo);
	return true;
}

GetWeaponByName(const name[])
{
	if(IsNumeric(name) && (strval(name) >= 0 && strval(name) <= 43))
	    return strval(name);

	for(new i = 0; i < sizeof(g_arrWeaponNames); ++i)
	{
	    if(strfind(g_arrWeaponNames[i], name, true) != -1)
	    {
	        return i;
		}
	}
	return -1;
}

ReturnWeaponName(weaponid, playerid = INVALID_PLAYER_ID)
{
	static
		name[30];

	GetWeaponName(weaponid, name, sizeof(name));

	if(!weaponid)
	    name = "Fists";

	else if(weaponid == 30)
	    name = "AK-47";

	else if(weaponid == 18)
	    name = "Molotov Cocktail";

	else if(weaponid == 44)
	    name = "Nightvision";

	else if(weaponid == 45)
	    name = "Infrared";

	else if(playerid != INVALID_PLAYER_ID && weaponid == 25 && BeanbagActive{playerid})
	    name = "Beanbag Shotgun";

	else if(playerid != INVALID_PLAYER_ID && weaponid == 33 && LessLethalActive{playerid})
	    name = "40mm Less Lethal Launcher";

	return name;
}

ReturnWeaponType(id)
{
	new weapon[22];

    switch(id)
    {
        case 0 .. 24: weapon = "Melee Weapon";
        default: weapon = "Heavy Weapon";
    }

    return weapon;
}

GetWeaponPackageName(weaponid)
{
	static
		name[24]
	;

	if(weaponid == 47)
	{
	    name = "Armour";
	    return name;
	}
	else if(weaponid == 48)
	{
	    name = "Vehicle Bomb";
	    return name;
	}
	else
	{
		GetWeaponName(weaponid, name, sizeof(name));

		if(!weaponid)
		    name = "Empty";

		else if(weaponid == 23)
		    name = "Silenced Pistol";

		else if(weaponid == 30)
		    name = "AK47";

        return name;
	}
}

FindFreePackageSlot(playerid)
{
	for(new i = 0; i < MAX_PLAYER_WEAPON_PACKAGE; ++i)
	{
		if(!PlayerData[playerid][pPackageWP][i])
		{
		    return i;
		}
	}

	return -1;
}

FindFreeCarPackageSlot(carid)
{
	for(new i = 0; i < MAX_CAR_WEAPON_PACKAGE; ++i)
	{
		if(!CarData[carid][carPackageWP][i])
		{
		    return i;
		}
	}

	return -1;
}

Car_SavePackage(carid)
{
	if(carid == -1) return false;

	new query[256];
	mysql_format(dbCon, query, sizeof(query), "UPDATE `cars` SET `carPackageWeapons` = '%e' WHERE `carID` = '%d' LIMIT 1", FormatVehicleWeapons(carid), CarData[carid][carID]);
	return mysql_tquery(dbCon, query);
}

Player_SavePackage(playerid)
{
	new query[256];
	mysql_format(dbCon, query, sizeof(query), "UPDATE `characters` SET `PackageWeapons` = '%e' WHERE `ID` = '%d' LIMIT 1", FormatPlayerWeapons(playerid), PlayerData[playerid][pID]);
	return mysql_tquery(dbCon, query);
}

GetWeaponPackage(slot)
{
    new max_ammo = -1;

	switch(slot)
	{
	    case 0, 1, 10, 8: max_ammo = 20;
	    case 4, 5: max_ammo = 1500;
	    case 3, 6: max_ammo = 1000;
	    case 2: max_ammo = 5000;
	    default: max_ammo = 20;
	}
	return max_ammo;
}

ShowVehicleWeapons(playerid, carid)
{
	SendClientMessage(playerid, COLOR_GREEN, "_______Vehicle Weapon Package:_______");

	SendClientMessageEx(playerid, COLOR_WHITE, "[ %d. %s ] [ %d. %s ] [ %d. %s ]", 1, GetVehicleInfo(carid, 0), 2, GetVehicleInfo(carid, 1), 3, GetVehicleInfo(carid, 2));
    SendClientMessageEx(playerid, COLOR_WHITE, "[ %d. %s ] [ %d. %s ] [ %d. %s ]", 4, GetVehicleInfo(carid, 3), 5, GetVehicleInfo(carid, 4), 6, GetVehicleInfo(carid, 5));
    SendClientMessageEx(playerid, COLOR_WHITE, "[ %d. %s ] [ %d. %s ] [ %d. %s ]", 7, GetVehicleInfo(carid, 6), 8, GetVehicleInfo(carid, 7), 9, GetVehicleInfo(carid, 8));
    SendClientMessageEx(playerid, COLOR_WHITE, "[ %d. %s ] [ %d. %s ] [ %d. %s ]", 10, GetVehicleInfo(carid, 9), 11, GetVehicleInfo(carid, 10), 12, GetVehicleInfo(carid, 11));
    SendClientMessageEx(playerid, COLOR_WHITE, "[ %d. %s ] [ %d. %s ] [ %d. %s ]", 13, GetVehicleInfo(carid, 12), 14, GetVehicleInfo(carid, 13), 15, GetVehicleInfo(carid, 14));
    SendClientMessageEx(playerid, COLOR_WHITE, "[ %d. %s ] [ %d. %s ] [ %d. %s ]", 16, GetVehicleInfo(carid, 15), 17, GetVehicleInfo(carid, 16), 18, GetVehicleInfo(carid, 17));
    SendClientMessageEx(playerid, COLOR_WHITE, "[ %d. %s ] [ %d. %s ]", 19, GetVehicleInfo(carid, 18), 20, GetVehicleInfo(carid, 19));
}

GetVehicleInfo(carid, slot)
{
	new info[64];

	if(!CarData[carid][carPackageWP][slot]) info = "Empty";
	else format(info, sizeof(info), "%s (%d/%d)", GetWeaponPackageName(CarData[carid][carPackageWP][slot]), CarData[carid][carPackageAmmo][slot], GetWeaponPackage(g_aWeaponSlots[CarData[carid][carPackageWP][slot]]));

	return info;
}

FormatPlayerWeapons(playerid)
{
	new wstr[256],tmp[64];

	for(new i = 0; i < MAX_PLAYER_WEAPON_PACKAGE; ++i)
	{
		if(i == 0)
		{
			format(tmp, sizeof(tmp), "%d=%d", PlayerData[playerid][pPackageWP][i], PlayerData[playerid][pPackageAmmo][i]);
		}
		else
		{
			format(tmp, sizeof(tmp), "|%d=%d", PlayerData[playerid][pPackageWP][i], PlayerData[playerid][pPackageAmmo][i]);
		}

		strins(wstr, tmp, strlen(wstr));
	}
	return wstr;
}

AssignPlayerWeapons(playerid, const str[])
{
	new wtmp[MAX_PLAYER_WEAPON_PACKAGE][64];

	explode(wtmp, str, "|");

	for(new i = 0; i != MAX_PLAYER_WEAPON_PACKAGE; ++i)
	{
		new wtmp2[2][64];
		explode(wtmp2, wtmp[i], "=");
		
		PlayerData[playerid][pPackageWP][i] = strval(wtmp2[0]);
		PlayerData[playerid][pPackageAmmo][i] = strval(wtmp2[1]);
	}
}

FormatVehicleWeapons(carid)
{
	new wstr[256], tmp[64];

	for(new i = 0; i < MAX_CAR_WEAPON_PACKAGE; ++i)
	{
		if(i == 0)
		{
			format(tmp, sizeof(tmp), "%d=%d", CarData[carid][carPackageWP][i], CarData[carid][carPackageAmmo][i]);
		}
		else
		{
			format(tmp, sizeof(tmp), "|%d=%d", CarData[carid][carPackageWP][i], CarData[carid][carPackageAmmo][i]);
		}

		strins(wstr, tmp, strlen(wstr));
	}
	return wstr;
}

AssignVehicleWeapons(carid, const str[])
{
	new wtmp[MAX_CAR_WEAPON_PACKAGE][64];

	explode(wtmp,str,"|");

	for(new i = 0; i != MAX_CAR_WEAPON_PACKAGE; ++i)
	{
		new wtmp2[2][64];

		/*Has to be minus 1, don't touch*/

		explode(wtmp2, wtmp[i], "=");
		CarData[carid][carPackageWP][i] = strval(wtmp2[0]);
		CarData[carid][carPackageAmmo][i] = strval(wtmp2[1]);
	}
}

GetGunObjectID(wpid)
{
    if(wpid < 0 || wpid > 64)
    {
        return 1575;
    }

    return GunObjectIDs[wpid];
}

DropWeapon(weaponid, ammo, Float:X, Float:Y, Float:Z, world, interior)
{
	for(new i = 0; i < MAX_DROP_ITEMS; ++i)
    {
    	if(!DroppedWeapons[i][DropExists])
        {
            DroppedWeapons[i][DropExists] = true;
	        DroppedWeapons[i][DropGunAmmount][0] = weaponid;
	        DroppedWeapons[i][DropGunAmmount][1] = ammo;
	        DroppedWeapons[i][DropGunPos][0] = X;
	        DroppedWeapons[i][DropGunPos][1] = Y;
	        DroppedWeapons[i][DropGunPos][2] = Z;
	        DroppedWeapons[i][DropLicense] = 0;
	        DroppedWeapons[i][DropObj] = CreateDynamicObject(GetGunObjectID(weaponid), X, Y, Z - 1, 80.0, 0.0, 0.0, world, interior);
			DroppedWeapons[i][DropWorld] = world;
			DroppedWeapons[i][DropInterior] = interior;
	        DroppedWeapons[i][DropMinutes] = 0;
	        return true;
        }
	}
    return true;
}

ResetDropWeapon(dropid)
{
	DroppedWeapons[dropid][DropGunAmmount][0] = 0;
	DroppedWeapons[dropid][DropGunAmmount][1] = 0;
	DroppedWeapons[dropid][DropGunPos][0] = 0.0;
	DroppedWeapons[dropid][DropGunPos][1] = 0.0;
	DroppedWeapons[dropid][DropGunPos][2] = 0.0;
	DroppedWeapons[dropid][DropLicense] = 0;
	DroppedWeapons[dropid][DropWorld] = 0;
	DroppedWeapons[dropid][DropInterior] = 0;

	DestroyDynamicObject(DroppedWeapons[dropid][DropObj]);

	DroppedWeapons[dropid][DropExists] = false;
 	return true;
}

DropGun_Nearest(playerid)
{
    for(new i = 0; i != MAX_DROP_ITEMS; ++i)
	{
		if(!DroppedWeapons[i][DropExists]) continue;

		if(DroppedWeapons[i][DropWorld] != GetPlayerVirtualWorld(playerid) || DroppedWeapons[i][DropInterior] != GetPlayerInterior(playerid)) continue;

		if(IsPlayerInRangeOfPoint(playerid, 1.5, DroppedWeapons[i][DropGunPos][0], DroppedWeapons[i][DropGunPos][1], DroppedWeapons[i][DropGunPos][2]))
		{
			return i;
		}
	}
	return -1;
}

RemoveWeaponOnly(playerid, weaponid)
{
    deleyAC_Nop{playerid} = true;

	ResetPlayerWeapons(playerid);

	for(new i = 0; i < 13; ++i)
	{
	    if(PlayerData[playerid][pGuns][i] != weaponid)
		{
			if(PlayerData[playerid][pGuns][i])
			{
				GivePlayerWeapon(playerid, PlayerData[playerid][pGuns][i], PlayerData[playerid][pAmmo][i]);
			}
		}
		else
		{
            PlayerData[playerid][pGuns][i] = 0;
            PlayerData[playerid][pAmmo][i] = 0;
	    }
	}

    cl_DressHoldWeapon(playerid, GetPlayerWeapon(playerid));

	deleyAC_Nop{playerid} = false;
	return true;
}

RemoveWeapon(playerid, weaponid)
{
    deleyAC_Nop{playerid} = true;

	ResetPlayerWeapons(playerid);

	if(IsMelee(weaponid))
	{
		PlayerData[playerid][pWeapon][0] = 0;
		PlayerData[playerid][pAmmunation][0] = 0;
	}
	else if(IsPrimary(weaponid))
	{
		PlayerData[playerid][pWeapon][1] = 0;
		PlayerData[playerid][pAmmunation][1] = 0;
	}
	else if(IsSecondary(weaponid))
	{
		PlayerData[playerid][pWeapon][2] = 0;
		PlayerData[playerid][pAmmunation][2] = 0;
	}

	for(new i = 0; i < 13; ++i)
	{
	    if(PlayerData[playerid][pGuns][i] != weaponid)
		{
			if(PlayerData[playerid][pGuns][i])
			{
				GivePlayerWeapon(playerid, PlayerData[playerid][pGuns][i], PlayerData[playerid][pAmmo][i]);
			}
		}
		else
		{
            PlayerData[playerid][pGuns][i] = 0;
            PlayerData[playerid][pAmmo][i] = 0;
	    }
	}

    cl_DressHoldWeapon(playerid, GetPlayerWeapon(playerid));

	deleyAC_Nop{playerid} = false;
	return true;
}

ResetWeapons(playerid, bool:death = false)
{
    deleyAC_Nop{playerid} = true;

	ResetPlayerWeapons(playerid);

	for(new i = 0; i < 13; ++i)
	{
    	PlayerData[playerid][pGuns][i] = 0;
    	PlayerData[playerid][pAmmo][i] = 0;

    	if(i < 3)
    	{
			PlayerData[playerid][pWeapon][i] = 0;
			PlayerData[playerid][pAmmunation][i] = 0;
    	}
	}

	PlayerData[playerid][pPrimaryLicense] = 0;
	PlayerData[playerid][pSecondaryLicense] = 0;

	cl_RemoveWeapons(playerid);

 	if(!death)
	{
		deleyAC_Nop{playerid} = false;
	}
	return true;
}

cl_RemoveWeapons(playerid)
{
	if(IsPlayerAttachedObjectSlotUsed(playerid, 5)) RemovePlayerAttachedObject(playerid, 5);
	if(IsPlayerAttachedObjectSlotUsed(playerid, 6)) RemovePlayerAttachedObject(playerid, 6);
	if(IsPlayerAttachedObjectSlotUsed(playerid, 7)) RemovePlayerAttachedObject(playerid, 7);
	if(IsPlayerAttachedObjectSlotUsed(playerid, 8)) RemovePlayerAttachedObject(playerid, 8);
	if(IsPlayerAttachedObjectSlotUsed(playerid, 9)) RemovePlayerAttachedObject(playerid, 9);
}

cl_DressHoldWeapon(playerid, weaponid = 0)
{
	RemovePlayerAttachedObject(playerid, 5);
	RemovePlayerAttachedObject(playerid, 6);
	RemovePlayerAttachedObject(playerid, 7);
	RemovePlayerAttachedObject(playerid, 8);
	RemovePlayerAttachedObject(playerid, 9);

	new slot;

	for(new i = 0; i < 13; ++i)
	{
		if(PlayerData[playerid][pGuns][i] && PlayerData[playerid][pGuns][i] != weaponid)
		{
			slot = g_aWeaponAttach[ PlayerData[playerid][pGuns][i] ];

			if(slot != -1 && WeaponSettings[playerid][slot][awHide] == 0)
			{
                if(!IsPlayerAttachedObjectSlotUsed(playerid, 5)) SetPlayerAttachedObject(playerid, 5, GetGunObjectID(PlayerData[playerid][pGuns][i]), WeaponSettings[playerid][slot][awBone], WeaponSettings[playerid][slot][aPx], WeaponSettings[playerid][slot][aPy], WeaponSettings[playerid][slot][aPz], WeaponSettings[playerid][slot][aPrx], WeaponSettings[playerid][slot][aPry], WeaponSettings[playerid][slot][aPrz], 1, 1, 1);
			    else if(!IsPlayerAttachedObjectSlotUsed(playerid, 6)) SetPlayerAttachedObject(playerid, 6, GetGunObjectID(PlayerData[playerid][pGuns][i]), WeaponSettings[playerid][slot][awBone], WeaponSettings[playerid][slot][aPx], WeaponSettings[playerid][slot][aPy], WeaponSettings[playerid][slot][aPz], WeaponSettings[playerid][slot][aPrx], WeaponSettings[playerid][slot][aPry], WeaponSettings[playerid][slot][aPrz], 1, 1, 1);
			    else if(!IsPlayerAttachedObjectSlotUsed(playerid, 7)) SetPlayerAttachedObject(playerid, 7, GetGunObjectID(PlayerData[playerid][pGuns][i]), WeaponSettings[playerid][slot][awBone], WeaponSettings[playerid][slot][aPx], WeaponSettings[playerid][slot][aPy], WeaponSettings[playerid][slot][aPz], WeaponSettings[playerid][slot][aPrx], WeaponSettings[playerid][slot][aPry], WeaponSettings[playerid][slot][aPrz], 1, 1, 1);
			    else if(!IsPlayerAttachedObjectSlotUsed(playerid, 8)) SetPlayerAttachedObject(playerid, 8, GetGunObjectID(PlayerData[playerid][pGuns][i]), WeaponSettings[playerid][slot][awBone], WeaponSettings[playerid][slot][aPx], WeaponSettings[playerid][slot][aPy], WeaponSettings[playerid][slot][aPz], WeaponSettings[playerid][slot][aPrx], WeaponSettings[playerid][slot][aPry], WeaponSettings[playerid][slot][aPrz], 1, 1, 1);
			    else if(!IsPlayerAttachedObjectSlotUsed(playerid, 9)) SetPlayerAttachedObject(playerid, 9, GetGunObjectID(PlayerData[playerid][pGuns][i]), WeaponSettings[playerid][slot][awBone], WeaponSettings[playerid][slot][aPx], WeaponSettings[playerid][slot][aPy], WeaponSettings[playerid][slot][aPz], WeaponSettings[playerid][slot][aPrx], WeaponSettings[playerid][slot][aPry], WeaponSettings[playerid][slot][aPrz], 1, 1, 1);
	  		}
		}
	}
	return true;
}

SetPlayerWeapons(playerid)
{
    ResetPlayerWeapons(playerid);

	if(PlayerData[playerid][pLevel] >= 2 && !PlayerData[playerid][pJailed])
	{
		if(PlayerData[playerid][pWeapon][0] > 0)
		{
			GivePlayerWeaponEx(playerid, PlayerData[playerid][pWeapon][0], PlayerData[playerid][pAmmunation][0]);
		}
		if(PlayerData[playerid][pWeapon][1] > 0)
		{
			GivePlayerWeaponEx(playerid, PlayerData[playerid][pWeapon][1], PlayerData[playerid][pAmmunation][1]);
		}
		if(PlayerData[playerid][pWeapon][2] > 0)
		{
			GivePlayerWeaponEx(playerid, PlayerData[playerid][pWeapon][2], PlayerData[playerid][pAmmunation][2]);
		}
	}

	if(ParticleSettings[playerid][usingParticle]) GivePlayerWeaponEx(playerid, 23, 99999);
}

IsMelee(weaponid)
{
    if(weaponid >= 1 && weaponid <= 18 || weaponid == 43)
		return true;

	return 0;
}

IsPrimary(weaponid)
{
    if(weaponid >= 25 && weaponid <= 34 || weaponid == 38)
		return true;

	return 0;
}

IsSecondary(weaponid)
{
    if(weaponid >= 22 && weaponid <= 24)
		return true;

	return 0;
}

ReturnWeaponSlot(weaponid)
{
    if(IsMelee(weaponid))
		return 0;
    if(IsPrimary(weaponid))
		return 1;
    if(IsSecondary(weaponid))
		return 2;

    return -1;
}

ReturnSlotName(slot)
{
	new slot_name[20];

	switch(slot)
	{
	    case 0: slot_name = "Meele";
	    case 1: slot_name = "Primary";
	    case 2: slot_name = "Secondary";
	}

	return slot_name;
}

IsWeaponSlotTaken(playerid, weaponid)
{
	new slot = ReturnWeaponSlot(weaponid);

	if(slot == -1) return false;

	if(PlayerData[playerid][pWeapon][slot] > 0)
	{
		return slot + 1;
	}

	return false;
}

PlayerHasWeapon(playerid, weaponid)
{
	for(new i = 0; i < 3; ++i)
	{
	    if(PlayerData[playerid][pWeapon][i] == weaponid)
	    {
	        return true;
	    }
	}

	return false;
}

PlayerHasWeaponEx(playerid, weaponid)
{
	for(new i = 0; i < 13; ++i)
	{
	    if(PlayerData[playerid][pGuns][i] == weaponid)
		{
	    	return true;
		}
	}

	return false;
}

RevivePlayer(playerid)
{
	ResetPlayer(playerid);
	ClearDamages(playerid, true);
	PlayerData[playerid][pInjured] = 0;
	KnockedOut{playerid} = false;
	ForceKnockout{playerid} = false;
	DeathMode{playerid} = false;
	DeathTimer[playerid] = 0;
	BrokenLeg{playerid} = false;
	death_Pause[playerid] = 0;
	ClearAnimations(playerid, 1);
}

IsBrutallyWounded(playerid)
{
	if(PlayerData[playerid][pInjured] || DeathMode{playerid})
		return true;

	return false;
}

/*IsPlayerDead(playerid)
{
	if(DeathMode{playerid})
		return true;

	return false;
}*/

ReturnDeathReason(reason)
{
	new
	    string[40]
	;

	switch(reason)
	{
	    case 49: string = "Vehicle";
	    case 50: string = "Helicopter Blades";
	    case 51: string = "Explosion";
	    case 53: string = "Drowned";
	    case 54, 255: string = "Suicide";
	}

	return string;
}

SaveDamages(playerid)
{
	new query[256];

	for(new i = 0; i < 100; ++i)
	{
	    if(DamageInfo[playerid][i][eDamageID] != -1 || !DamageInfo[playerid][i][eDamageTaken]) continue;

		format(query, sizeof(query), "INSERT INTO `damages` (damageTaken, damageTime, damageWeapon, damageBodypart, damageArmor, damageBy, playerID) VALUES (%d, %d, %d, %d, %d, %d, %d)",
            DamageInfo[playerid][i][eDamageTaken],
            DamageInfo[playerid][i][eDamageTime],
            DamageInfo[playerid][i][eDamageWeapon],
            DamageInfo[playerid][i][eDamageBodypart],
            DamageInfo[playerid][i][eDamageArmor],
            DamageInfo[playerid][i][eDamageBy],
            PlayerData[playerid][pID]
		);

	    mysql_tquery(dbCon, query);
	}

	return true;
}

ClearDamages(playerid, bool:dbwipe = false)
{
	BrokenLeg{playerid} = false;

    SetPlayerChatBubble(playerid, " ", COLOR_WHITE, 10.0, 200);

    new
		count
	;

	for(new i = 0; i < 100; ++i)
	{
	    if(DamageInfo[playerid][i][eDamageTaken]) count++;

	    DamageInfo[playerid][i][eDamageID] = -1;

		DamageInfo[playerid][i][eDamageTaken] = 0;
		DamageInfo[playerid][i][eDamageBy] = 0;

		DamageInfo[playerid][i][eDamageArmor] = 0;
		DamageInfo[playerid][i][eDamageBodypart] = 0;

		DamageInfo[playerid][i][eDamageTime] = 0;
		DamageInfo[playerid][i][eDamageWeapon] = 0;
	}

	TotalPlayerDamages[playerid] = 0;

	if(count && dbwipe)
	{
		format(sgstr, sizeof(sgstr), "DELETE FROM `damages` WHERE `playerID` = '%d'", PlayerData[playerid][pID]);
		mysql_pquery(dbCon, sgstr);
	}
	return true;
}

CallbackDamages(playerid, issuerid, bodypart, weaponid, Float:amount, Float:armour)
{
	new id = -1;

	for(new i = TotalPlayerDamages[playerid]; i < 100; ++i)
	{
		if(!DamageInfo[playerid][i][eDamageTaken])
		{
			id = i;
			break;
		}
	}

	if(id == -1) return true;

	TotalPlayerDamages[playerid] ++;

	if(armour > 1 && bodypart == BODY_PART_CHEST)
		DamageInfo[playerid][id][eDamageArmor] = 1;

	else DamageInfo[playerid][id][eDamageArmor] = 0;

	DamageInfo[playerid][id][eDamageTaken] = floatround(amount, floatround_round);
	DamageInfo[playerid][id][eDamageWeapon] = weaponid;

	DamageInfo[playerid][id][eDamageBodypart] = bodypart;
	DamageInfo[playerid][id][eDamageTime] = gettime();

	DamageInfo[playerid][id][eDamageBy] = PlayerData[issuerid][pID];
	DamageInfo[playerid][id][eDamageID] = -1;

	//SQL_LogAction(playerid, "Hit by %s with %s in %s (%d)", ReturnName(issuerid), ReturnWeaponName(weaponid), ReturnBodypartName(bodypart), DamageInfo[playerid][id][eDamageArmor]);
	//SQL_LogAction(extraid, "Attacked %s with %s in %s (%d)", ReturnName(playerid), ReturnWeaponName(weaponid), ReturnBodypartName(bodypart), DamageInfo[playerid][id][eDamageArmor]);
	return true;
}

ReturnBodypartName(bodypart)
{
	new bodyname[20];

	switch(bodypart)
	{
		case BODY_PART_CHEST:bodyname = "CHEST";
		case BODY_PART_GROIN:bodyname = "GROIN";
		case BODY_PART_LEFT_ARM:bodyname = "LEFT ARM";
		case BODY_PART_RIGHT_ARM:bodyname = "RIGHT ARM";
		case BODY_PART_LEFT_LEG:bodyname = "LEFT LEG";
		case BODY_PART_RIGHT_LEG:bodyname = "RIGHT LEG";
		case BODY_PART_HEAD:bodyname = "HEAD";
	}

	return bodyname;
}

ShowPlayerDamages(damageid, playerid, adminView)
{
	if(TotalPlayerDamages[damageid] < 1)
		return Dialog_Show(playerid, None, DIALOG_STYLE_LIST, ReturnName(damageid), "There's no damage to show...", "Close", "");

	gstr[0] = EOS;

	switch(adminView)
	{
		case 0:
		{
			for(new i = TotalPlayerDamages[damageid]; i >= 0; --i)
			{
				if(!DamageInfo[damageid][i][eDamageTaken])
					continue;

				format(gstr, sizeof(gstr), "%s%d dmg from %s to %s (Kevlarhit: %d) %d s ago\n", gstr, DamageInfo[damageid][i][eDamageTaken], ReturnWeaponName(DamageInfo[damageid][i][eDamageWeapon]), ReturnBodypartName(DamageInfo[damageid][i][eDamageBodypart]), DamageInfo[damageid][i][eDamageArmor], gettime() - DamageInfo[damageid][i][eDamageTime]);
			}

			Dialog_Show(playerid, None, DIALOG_STYLE_LIST, ReturnName(damageid), gstr, "Close", "");
		}
		case 1:
		{
			for(new i = TotalPlayerDamages[damageid]; i >= 0; --i)
			{
				if(!DamageInfo[damageid][i][eDamageTaken])
					continue;

				format(gstr, sizeof(gstr), "%s{FF6346}(%s){FFFFFF} %d dmg from %s to %s (Kevlarhit: %d) %d s ago\n", gstr, ReturnDBIDName(DamageInfo[damageid][i][eDamageBy]), DamageInfo[damageid][i][eDamageTaken], ReturnWeaponName(DamageInfo[damageid][i][eDamageWeapon]), ReturnBodypartName(DamageInfo[damageid][i][eDamageBodypart]), DamageInfo[damageid][i][eDamageArmor], gettime() - DamageInfo[damageid][i][eDamageTime]);
			}

			Dialog_Show(playerid, None, DIALOG_STYLE_LIST, ReturnName(damageid), gstr, "Close", "");
		}
	}
	return true;
}

IsActualGun(weaponid)
{
	if(weaponid >= 22 && weaponid <= 34)
		return true;

	return false;
}

IsLethalMeele(id)
{
	switch(id)
	{
	    case 4, 8, 9, 18, 16:
			return true;
		default:
		    return false;
	}

	return false;
}

LegalWeaponCheck(playerid, weaponid)
{
	if(PlayerData[playerid][pFaction] == -1) return false;

	if((BeanbagActive{playerid} == true && weaponid == 25) || (TazerActive{playerid} == true && weaponid == 23) || (LessLethalActive{playerid} == true && weaponid == 33))
	{
		return true;
	}

	return false;
}

TacklePlayer(playerid, victimid)
{
    PlayerData[victimid][pAnimation] = 1;
	ApplyAnimation(victimid, "PED", "BIKE_fall_off", 4.1, false, true, true, true, 0, 1);

 	SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s runs at %s and tries to tackle them to the ground.", ReturnNameEx(playerid), ReturnNameEx(victimid));
	
	GameTextForPlayer(victimid, "~r~YOU HAVE BEEN TACKLED.", 3000, 3);
	return true;
}

IsGunrackWeapon(weaponid)
{
	if(weaponid < 25 || weaponid > 43) return false;

	switch(weaponid)
	{
		case 25, 29, 31, 27, 34, 43, 41, 42, 24, 33:
			return true;
		default:
			return false;
	}

	return false;
}

stock SavePlayerWeapons(playerid)
{
	TempWeapons[playerid][0][0] = PlayerData[playerid][pWeapon][0];
	TempWeapons[playerid][0][1] = PlayerData[playerid][pAmmunation][0];

	TempWeapons[playerid][1][0] = PlayerData[playerid][pWeapon][1];
	TempWeapons[playerid][1][1] = PlayerData[playerid][pAmmunation][1];

	TempWeapons[playerid][2][0] = PlayerData[playerid][pWeapon][2];
	TempWeapons[playerid][2][1] = PlayerData[playerid][pAmmunation][2];
}

stock RestorePlayerWeapons(playerid, bool:spawn = true)
{
	if(!spawn)
	{
	    new slot;

		for(new i = 0; i < 3; ++i)
		{
		    slot = g_aWeaponSlots[PlayerData[playerid][pWeapon][i]];

			PlayerData[playerid][pWeapon][i] = TempWeapons[playerid][i][0];
			PlayerData[playerid][pAmmunation][i] = TempWeapons[playerid][i][1];

			PlayerData[playerid][pGuns][slot] = PlayerData[playerid][pWeapon][i];
			PlayerData[playerid][pAmmo][slot] = PlayerData[playerid][pAmmunation][i];

			TempWeapons[playerid][i][0] = 0;
			TempWeapons[playerid][i][1] = 0;
		}

		return true;
	}

	for(new i = 0; i < 3; ++i)
	{
		if(TempWeapons[playerid][i][0] != 0)
		{
		    GivePlayerValidWeapon(playerid, TempWeapons[playerid][i][0], TempWeapons[playerid][i][1], 0, false);
		}

		TempWeapons[playerid][i][0] = 0;
		TempWeapons[playerid][i][1] = 0;
	}

	return true;
}