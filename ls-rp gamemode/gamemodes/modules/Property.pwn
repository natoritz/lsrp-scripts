// Defines

#define MAX_PROPERTIES (330)
#define MAX_COMPLEXES (40)
#define MAX_HOUSE_ITEMS (4)
#define MAX_HOUSE_WEAPONS (40)

#define APARTMENT_SQLID_HARBOUR (63)
#define APARTMENT_SQLID_RECEIVE_AND_RELEASE (49)

// Variables

enum E_HOUSE_DATA
{
	hID,
	Text3D:hLabel,
	hDynamicArea,
	Float:hEntranceX,
	Float:hEntranceY,
	Float:hEntranceZ,
	Float:hExitX,
	Float:hExitY,
	Float:hExitZ,
	hInfo[64],
	hOwnerSQLID,
	hOwner[MAX_PLAYER_NAME],
	hOwned,
	hLocked,
	hPrice,
	hLevelbuy,
	hRentprice,
	hRentable,
	hInterior,
	hWorld,
	hCash,
	hWeapon[MAX_HOUSE_WEAPONS],
	hAmmo[MAX_HOUSE_WEAPONS],
	hWeaponLicense[MAX_HOUSE_WEAPONS],
	hItems[MAX_HOUSE_ITEMS],
	Float:hCheckPosX,
	Float:hCheckPosY,
	Float:hCheckPosZ,
    hRadio,
    hSubid,
    bool:hradioOn,
    hradioURL[128],
    hComplexSQL,
	hComplexID,
    hShootingTimer
};

enum E_COMPLEX_DATA
{
	aID,
	Text3D:aLabel,
	aDynamicArea,
	Float:aEntranceX,
	Float:aEntranceY,
	Float:aEntranceZ,
	Float:aExitX,
	Float:aExitY,
	Float:aExitZ,
	aLocked,
	aInterior,
	aWorld,
	aInfo[60],
	aOwnerSQLID,
	aOwner[MAX_PLAYER_NAME],
	aRentable,
	aRentprice,
	aOwned,
	aPrice,
	aLevelbuy,
	aLocklevel,
	aAlarmlevel,
	aPickup,
	aShootingTimer,
	aFaction,
	aPickupEnabled
};

new PropertyData[MAX_PROPERTIES][E_HOUSE_DATA];
new ComplexData[MAX_COMPLEXES][E_COMPLEX_DATA];
new Iterator:Property<MAX_PROPERTIES>;
new Iterator:Complex<MAX_COMPLEXES>;

// Functions

Complex_IsOwner(playerid, apartment)
{
	if(apartment == -1)
	    return false;

	if(!SQL_IsLogged(playerid) || PlayerData[playerid][pID] == -1)
	    return false;

	if(PlayerData[playerid][pAdmin] > 3 && AdminDuty{playerid})
		return true;

    if(ComplexData[apartment][aOwned] == 1 && ComplexData[apartment][aOwnerSQLID] == PlayerData[playerid][pID])
		return true;

	return 0;
}

Property_IsOwner(playerid, houseid)
{
	if(houseid == -1)
	    return false;

	if(!SQL_IsLogged(playerid) || PlayerData[playerid][pID] == -1)
	    return false;

	if(PropertyData[houseid][hOwned] && PropertyData[houseid][hOwnerSQLID] == PlayerData[playerid][pID])
	    return true;

	if(PlayerData[playerid][pAdmin] > 3 && AdminDuty{playerid})
		return true;

	return false;
}

ReturnPropertyAddress(housekey)
{
	new
		houseLocation[MAX_ZONE_NAME],
		houseCity[MAX_ZONE_NAME],
		houseStreet[MAX_ZONE_NAME],
		longStr[128]
	;

	if(PropertyData[housekey][hComplexID] == -1)
	{
		GetStreet(PropertyData[housekey][hEntranceX], PropertyData[housekey][hEntranceY], houseStreet, MAX_ZONE_NAME);
		Get2DZone(PropertyData[housekey][hEntranceX], PropertyData[housekey][hEntranceY], houseLocation, MAX_ZONE_NAME);
		GetCity(PropertyData[housekey][hEntranceX], PropertyData[housekey][hEntranceY], houseCity, MAX_ZONE_NAME);
	}
	else
	{
	    new aptid = PropertyData[housekey][hComplexID];

		GetStreet(ComplexData[aptid][aEntranceX], ComplexData[aptid][aEntranceY], houseStreet, MAX_ZONE_NAME);
		Get2DZone(ComplexData[aptid][aEntranceX], ComplexData[aptid][aEntranceY], houseLocation, MAX_ZONE_NAME);
		GetCity(ComplexData[aptid][aEntranceX], ComplexData[aptid][aEntranceY], houseCity, MAX_ZONE_NAME);
	}

	format(longStr, sizeof(longStr), "%s, %s, %s %d", houseStreet, houseLocation, houseCity, ReturnAreaCode(houseLocation));
	return longStr;
}

ReturnDynamicAddress(Float:x, Float:y)
{
	new
		Location[MAX_ZONE_NAME],
		City[MAX_ZONE_NAME],
		Street[MAX_ZONE_NAME],
		longStr[128]
	;

	GetStreet(x, y, Street, MAX_ZONE_NAME);
	Get2DZone(x, y, Location, MAX_ZONE_NAME);
	GetCity(x, y, City, MAX_ZONE_NAME);

	format(longStr, sizeof(longStr), "%s, %s, %s %d", Street, Location, City, ReturnAreaCode(Location));
	return longStr;
}

ReturnClosestProperty(playerid)
{
	if(InProperty[playerid] != -1) return InProperty[playerid];

	foreach (new i : Property)
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, PropertyData[i][hEntranceX], PropertyData[i][hEntranceY], PropertyData[i][hEntranceZ]))
		{
			return i;
		}
	}
	return -1;
}

StopHouseBoomBox(house)
{
	if(PropertyData[house][hradioOn])
	{
		PropertyData[house][hradioOn] = false;

		foreach (new i : Player)
		{
			if(InProperty[i] == house)
			{
				StopAudioStreamForPlayer(i);
				SendClientMessage(i, COLOR_LIGHTRED, "The radio is turned off.");
			}
		}
	}
	return true;
}

StopBizzBoomBox(house)
{
	if(BusinessData[house][bradioOn])
	{
		BusinessData[house][bradioOn] = false;

		foreach (new i : Player)
		{
			if(InBusiness[i] == house)
			{
				StopAudioStreamForPlayer(i);
				SendClientMessage(i, COLOR_LIGHTRED, "The radio is turned off.");
			}
		}
	}
	return true;
}

Property_Inside(playerid)
{
	return InProperty[playerid];
}

Apartment_Inside(playerid)
{
	return InApartment[playerid];
}

Property_Nearest(playerid, Float:radius = 2.5, ignoreid = -1)
{
	new apartment = InApartment[playerid];

	if(apartment != -1) apartment = ComplexData[apartment][aID];

    foreach (new i : Property)
	{
	    if(ignoreid == i) continue;

		if(PropertyData[i][hComplexSQL] != apartment) continue;

		if(IsPlayerInRangeOfPoint(playerid, radius, PropertyData[i][hEntranceX], PropertyData[i][hEntranceY], PropertyData[i][hEntranceZ]))
		{
			return i;
		}
	}
	return -1;
}

Apartment_Nearest(playerid, Float:radius = 2.5, ignoreid = -1)
{
    foreach (new i : Complex)
	{
	    if(ignoreid == i) continue;

		if(IsPlayerInRangeOfPoint(playerid, radius, ComplexData[i][aEntranceX], ComplexData[i][aEntranceY], ComplexData[i][aEntranceZ]))
		{
			return i;
		}
	}
	return -1;
}

Property_Refresh(houseid)
{
	if(!PropertyData[houseid][hOwned])
	{
	    if(!IsValidDynamic3DTextLabel(Text3D:PropertyData[houseid][hLabel]))
		{
	        if(PropertyData[houseid][hComplexID] == -1)
	        {
	            format(sgstr, sizeof(sgstr), ""EMBED_YELLOW"House[%d] For Sale:\nPrice: $%d\nLevel: %d\nLock Level: 1\nAlarm Level: 1", houseid, PropertyData[houseid][hPrice], PropertyData[houseid][hLevelbuy]);
	        	PropertyData[houseid][hLabel] = CreateDynamic3DTextLabel(sgstr, -1, PropertyData[houseid][hEntranceX], PropertyData[houseid][hEntranceY], PropertyData[houseid][hEntranceZ], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 0, -1, -1, 100.0);
			}
			else
			{
			    format(sgstr, sizeof(sgstr), ""EMBED_YELLOW"Apartment[%d] For Sale:\nPrice: $%d\nLevel: %d\nLock Level: 1\nAlarm Level: 1", houseid, PropertyData[houseid][hPrice], PropertyData[houseid][hLevelbuy]);
			    PropertyData[houseid][hLabel] = CreateDynamic3DTextLabel(sgstr, -1, PropertyData[houseid][hEntranceX], PropertyData[houseid][hEntranceY], PropertyData[houseid][hEntranceZ], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, ComplexData[ PropertyData[houseid][hComplexID] ][aWorld], -1, -1, 100.0);
			}
			return true;
		}

	    if(PropertyData[houseid][hComplexID] == -1)
	    {
			format(sgstr, sizeof(sgstr), ""EMBED_YELLOW"House[%d] For Sale:\nPrice: $%d\nLevel: %d\nLock Level: 1\nAlarm Level: 1", houseid, PropertyData[houseid][hPrice], PropertyData[houseid][hLevelbuy]);
			UpdateDynamic3DTextLabelText(PropertyData[houseid][hLabel], -1, sgstr);
		}
		else
		{
			format(sgstr, sizeof(sgstr), ""EMBED_YELLOW"Apartment[%d] For Sale:\nPrice: $%d\nLevel: %d\nLock Level: 1\nAlarm Level: 1", houseid, PropertyData[houseid][hPrice], PropertyData[houseid][hLevelbuy]);
			UpdateDynamic3DTextLabelText(PropertyData[houseid][hLabel], -1, sgstr);			
		}
	}
	else
	{
		if(IsValidDynamic3DTextLabel(Text3D:PropertyData[houseid][hLabel])) DestroyDynamic3DTextLabel(Text3D:PropertyData[houseid][hLabel]);
	}

	return true;
}

Complex_Refresh(id)
{
	if(id != -1)
	{
		if(IsValidDynamicPickup(ComplexData[id][aPickup]))
		    DestroyDynamicPickup(ComplexData[id][aPickup]);

		if(!ComplexData[id][aOwned])
		{
			if(!IsValidDynamic3DTextLabel(Text3D:ComplexData[id][aLabel]))
			{
			    format(sgstr, sizeof(sgstr), "{C38A39}Apartment Building[%d] For Sale:\nPrice: $%d\nLevel: %d\nLock Level:%d\nAlarm Level:%d", id, ComplexData[id][aPrice], ComplexData[id][aLevelbuy], ComplexData[id][aLocklevel], ComplexData[id][aAlarmlevel]);
			    ComplexData[id][aLabel] = CreateDynamic3DTextLabel(sgstr, -1, ComplexData[id][aEntranceX], ComplexData[id][aEntranceY], ComplexData[id][aEntranceZ], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1, 100.0);
			}
			else
			{
				format(sgstr, sizeof(sgstr), "{C38A39}Apartment Building[%d] For Sale:\nPrice: $%d\nLevel: %d\nLock Level:%d\nAlarm Level:%d", id, ComplexData[id][aPrice], ComplexData[id][aLevelbuy], ComplexData[id][aLocklevel], ComplexData[id][aAlarmlevel]);
			    UpdateDynamic3DTextLabelText(ComplexData[id][aLabel], -1, sgstr);
			}
		}
		else
		{
			if(IsValidDynamic3DTextLabel(Text3D:ComplexData[id][aLabel])) DestroyDynamic3DTextLabel(Text3D:ComplexData[id][aLabel]);
		}

		if(ComplexData[id][aPickupEnabled]) ComplexData[id][aPickup] = CreateDynamicPickup(1314, 23, ComplexData[id][aEntranceX], ComplexData[id][aEntranceY], ComplexData[id][aEntranceZ], 0, 0);
	}
	return true;
}

FormatPropertyWeapons(house)
{
	new wstr[600], tmp[32];

	for(new a = 0; a != MAX_HOUSE_WEAPONS; ++a)
	{
		new w = PropertyData[house][hWeapon][a], am = PropertyData[house][hAmmo][a], lc = PropertyData[house][hWeaponLicense][a];

		if(!a)
			format(tmp, sizeof(tmp),"%d=%d=%d", w, am, lc);
		else
			format(tmp, sizeof(tmp),"|%d=%d=%d", w, am, lc);

		strins(wstr, tmp, strlen(wstr));
	}
	return wstr;
}

AssignPropertyWeapons(house, const str[])
{
	new wtmp[MAX_HOUSE_WEAPONS][32];

	explode(wtmp, str, "|");

	for(new z = 0; z != MAX_HOUSE_WEAPONS; ++z)
	{
		new wtmp2[3][32];

		explode(wtmp2, wtmp[z], "=");

		PropertyData[house][hWeapon][z] = strval(wtmp2[0]);
		PropertyData[house][hAmmo][z] = strval(wtmp2[1]);
		PropertyData[house][hWeaponLicense][z] = strval(wtmp2[2]);
	}
}

FormatPropertyItems(house)
{
	new wstr[256], tmp[32];

	for(new a = 0; a != MAX_HOUSE_ITEMS; ++a)
	{
		if(!a)
			format(tmp, sizeof(tmp),"%d",PropertyData[house][hItems][a]);
		else
			format(tmp, sizeof(tmp),"|%d",PropertyData[house][hItems][a]);

		strins(wstr, tmp, strlen(wstr));
	}
	return wstr;
}

AssignPropertyItems(house, const str[])
{
	new wtmp[MAX_HOUSE_ITEMS][32];
	explode(wtmp, str, "|");

	for(new z = 0; z != MAX_HOUSE_ITEMS; ++z)
	{
		PropertyData[house][hItems][z] = strval(wtmp[z]);
	}
}

Complex_Save(id)
{
	new query[512];

	mysql_format(dbCon, query, sizeof(query), "UPDATE `apartments` SET `rentprice` = '%d', `rentable` = '%d', `ownerSQLID` = '%d', `owner` = '%e', `owned` = '%d', `locked` = '%d', `price`= '%d', `levelbuy` = '%d', `interior` = '%d', `world` = '%d' WHERE `ID` = '%d'",
		ComplexData[id][aRentprice],
		ComplexData[id][aRentable],
		ComplexData[id][aOwnerSQLID],
		ComplexData[id][aOwner],
		ComplexData[id][aOwned],
		ComplexData[id][aLocked],
		ComplexData[id][aPrice],
		ComplexData[id][aLevelbuy],
		ComplexData[id][aInterior],
		ComplexData[id][aWorld],
		ComplexData[id][aID]
	);

	mysql_pquery(dbCon, query);
	return true;
}

Property_Save(houseid)
{
	new query[512];

	mysql_format(dbCon, query, sizeof(query), "UPDATE `houses` SET `info` = '%e', `ownerSQLID` = '%d', `owner` = '%e', `owned` = '%d', `locked` = '%d', `price`= '%d', `levelbuy` = '%d', `rentprice` = '%d', `rentable` = '%d', `interior` = '%d', `world` = '%d', `cash` = '%d' WHERE `id` = '%d'",
        PropertyData[houseid][hInfo],
        PropertyData[houseid][hOwnerSQLID],
		PropertyData[houseid][hOwner],
		PropertyData[houseid][hOwned],
		PropertyData[houseid][hLocked],
		PropertyData[houseid][hPrice],
		PropertyData[houseid][hLevelbuy],
		PropertyData[houseid][hRentprice],
		PropertyData[houseid][hRentable],
		PropertyData[houseid][hInterior],
		PropertyData[houseid][hWorld],
		PropertyData[houseid][hCash],
		PropertyData[houseid][hID]
	);

	mysql_pquery(dbCon, query);

	mysql_format(dbCon, query, sizeof(query), "UPDATE `houses` SET `checkx` = '%f', `checky` = '%f', `checkz` = '%f', `weapons` = '%e', `radio` = '%d', `scriptid` = '%d' WHERE `id` = '%d'",
		PropertyData[houseid][hCheckPosX],
		PropertyData[houseid][hCheckPosY],
		PropertyData[houseid][hCheckPosZ],
		FormatPropertyWeapons(houseid),
		PropertyData[houseid][hRadio],
		houseid,
		PropertyData[houseid][hID]
	);

	mysql_pquery(dbCon, query);
	return true;
}