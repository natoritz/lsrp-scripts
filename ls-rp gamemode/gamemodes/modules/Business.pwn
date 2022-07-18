// Defines

#define MAX_BUSINESS (60)
#define MAX_BUSINESS_ITEM (12)

// Variables

enum E_BUSINESS_DATA
{
    bID,
    bOwned,
	bOwner[MAX_PLAYER_NAME],
	bInfo[80],
	bType,
	bsubType,
	Float:bEntranceX,
	Float:bEntranceY,
	Float:bEntranceZ,
	Float:bExitX,
	Float:bExitY,
	Float:bExitZ,
	bLevelNeeded,
	bBuyPrice,
	bEntranceCost,
	bTill,
	bLocked,
	bInterior,
	bWorld,
	bProducts,
	bMaxProducts,
	bPriceProd,
	bPickup,
	bShootingTimer,
	bItems[MAX_BUSINESS_ITEM],
	bool:bradioOn,
    bradioURL[128],
	// v buy
	Float:bBuyingCarX,
	Float:bBuyingCarY,
	Float:bBuyingCarZ,
	Float:bBuyingCarA,
	Float:bBuyingBoatX,
	Float:bBuyingBoatY,
	Float:bBuyingBoatZ,
	Float:bBuyingBoatA,
	Float:bBuyingAirX,
	Float:bBuyingAirY,
	Float:bBuyingAirZ,
	Float:bBuyingAirA,
};

new BusinessData[MAX_BUSINESS][E_BUSINESS_DATA];
new BizzEntrance[MAX_PLAYERS][MAX_BUSINESS];
new Iterator:Business<MAX_BUSINESS>;

// Functions

Business_Nearest(playerid, Float:radius = 2.5)
{
    foreach (new i : Business)
	{
		if(IsPlayerInRangeOfPoint(playerid, radius, BusinessData[i][bEntranceX], BusinessData[i][bEntranceY], BusinessData[i][bEntranceZ]))
		{
			return i;
		}
	}
	return -1;
}

Business_Inside(playerid)
{
    return InBusiness[playerid];
}

Business_IsOwner(playerid, bizid)
{
	if(!SQL_IsLogged(playerid) || PlayerData[playerid][pID] == -1)
	    return true;

	if(PlayerData[playerid][pAdmin] > 3 && AdminDuty{playerid})
		return true;

    if(BusinessData[bizid][bOwned] != 0 && PlayerData[playerid][pPbiskey] == bizid)
		return true;

	return false;
}

Business_Refresh(bizid)
{
	if(bizid != -1)
	{
		if(IsValidDynamicPickup(BusinessData[bizid][bPickup]))
		    DestroyDynamicPickup(BusinessData[bizid][bPickup]);

		if(BusinessData[bizid][bType] == 13) return true; // Black Market

		switch(BusinessData[bizid][bType])
		{
		    case 2, 3, 6, 8:
		    {
		        BusinessData[bizid][bPickup] = CreateDynamicPickup(1239, 2, BusinessData[bizid][bEntranceX], BusinessData[bizid][bEntranceY], BusinessData[bizid][bEntranceZ]);
		    }
		    default:
		    {
				if(BusinessData[bizid][bOwned])
					BusinessData[bizid][bPickup] = CreateDynamicPickup(1239, 2, BusinessData[bizid][bEntranceX], BusinessData[bizid][bEntranceY], BusinessData[bizid][bEntranceZ]);
				else
					BusinessData[bizid][bPickup] = CreateDynamicPickup(1272, 2, BusinessData[bizid][bEntranceX], BusinessData[bizid][bEntranceY], BusinessData[bizid][bEntranceZ]);
			}
		}
	}
	return true;
}

Business_FoodMenu(playerid)
{
	new id;

	if((id = Business_Inside(playerid)) != -1)
	{
	    if(InBusiness[playerid] == id && BusinessData[id][bType] == 9)
	    {
			ShowPlayerRestaurantMenu(playerid, id);
		}
		else SendErrorMessage(playerid, "You are not in a restaurant.");
	}	
}

Business_PrintInfo(playerid, targetid)
{
	if(!Iter_Contains(Business, targetid)) return true;

	SendClientMessage(playerid, COLOR_GREEN, "_______________________________________");
	SendClientMessageEx(playerid, COLOR_GREEN, "*** %s ***", BusinessData[targetid][bInfo]);

	SendClientMessageEx(playerid, COLOR_WHITE, "Address: %s, San Andreas", ReturnLocation(playerid));
	SendClientMessageEx(playerid, COLOR_WHITE, "Owner:[%s] Level:[%d] Value:[%d] Type:[%d] Locked:[%s] ID: [%d]", BusinessData[targetid][bOwner], BusinessData[targetid][bLevelNeeded], BusinessData[targetid][bBuyPrice], BusinessData[targetid][bType], (BusinessData[targetid][bLocked]) ? ("Yes") : ("No"), targetid);
	SendClientMessageEx(playerid, COLOR_WHITE, "Upgrades:[0] Cashbox:[%s] Entrance Fee:[%s]", FormatNumber(BusinessData[targetid][bTill]), FormatNumber(BusinessData[targetid][bEntranceCost]));
	SendClientMessageEx(playerid, COLOR_WHITE, "Technical Info: 1 Cargo = %d Products. Currently: Products[%d / %d], CargoPrice[%d]", GetProductPerCargo(BusinessData[targetid][bType]), BusinessData[targetid][bProducts], BusinessData[targetid][bMaxProducts], BusinessData[targetid][bPriceProd]);

	SendClientMessage(playerid, COLOR_GREEN, "_______________________________________");
	return true;
}

Business_FormatItems(business)
{
	new wstr[256], tmp[32];

	for(new a = 0; a != MAX_BUSINESS_ITEM; ++a)
	{
		new w = BusinessData[business][bItems][a];

		if(!a) format(tmp, sizeof(tmp), "%d", w);
		else format(tmp, sizeof(tmp), "|%d", w);

		strins(wstr, tmp, strlen(wstr));
	}

	return wstr;
}

Business_AssignItems(business, const str[])
{
	new wtmp[MAX_BUSINESS_ITEM][32];
	explode(wtmp,str,"|");
	for(new z = 0; z != MAX_BUSINESS_ITEM; ++z)
	{
		BusinessData[business][bItems][z] = strval(wtmp[z]);
	}
}