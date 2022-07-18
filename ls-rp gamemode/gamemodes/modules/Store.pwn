ShowShopList(playerid, bool:toggle)
{
	new
		id = Business_Inside(playerid)
	;

	if(toggle)
	{
	    SelectedItem[playerid] = -1;
	    SelectedRadio[playerid] = -1;

	    SelectTextDraw(playerid, 0xC6E5D2FF);

	    for(new i; i < 20; ++i)
	    {
	        if(i < 4) TextDrawShowForPlayer(playerid, Store_Frame[i]);

	        if(i < 10)
	        {
	            if(PlayerData[playerid][pCash] < ReturnItemPrice(i))
				{
					PlayerTextDrawBackgroundColor(playerid, Store_Items[playerid][i], 0xFFCCCCFF);
					PlayerTextDrawSetSelectable(playerid, Store_Items[playerid][i], false);
				}
				else
				{
	            	PlayerTextDrawBackgroundColor(playerid, Store_Items[playerid][i], -572662273);
	            	PlayerTextDrawSetSelectable(playerid, Store_Items[playerid][i], true);
				}

		        PlayerTextDrawShow(playerid, Store_Items[playerid][i]);
		        PlayerData[playerid][ItemCache][i] = -1;
	        }

	        PlayerTextDrawShow(playerid, Store_UI[playerid][i]);
	    }

	    new maskid[24];
	    format(maskid, 24, "Mask~n~[%d_%d]", randomEx(100000, 999999), randomEx(10, 99));
	    PlayerTextDrawSetString(playerid, Store_Mask[playerid], maskid);

		PlayerTextDrawSetString(playerid, Store_Business[playerid], ClearGameTextColor(BusinessData[id][bInfo]));
        PlayerTextDrawSetString(playerid, Store_Header[playerid], "Welcome!");
        PlayerTextDrawSetString(playerid, Store_Info[playerid], "Click on any of the items to add them to~n~your cart.~n~~n~Press ESC to exit.");
        PlayerTextDrawSetString(playerid, Store_Cart[playerid], "Cart: ~g~$0");

        PlayerTextDrawShow(playerid, Store_Business[playerid]);
        PlayerTextDrawShow(playerid, Store_Header[playerid]);
        PlayerTextDrawShow(playerid, Store_Info[playerid]);
        PlayerTextDrawShow(playerid, Store_Cart[playerid]);
	    PlayerTextDrawShow(playerid, Store_Mask[playerid]);

	    SetPVarInt(playerid, "PriceCount", 0);
	    UI_Purchase{playerid} = true;
	}
	else
	{
	    for(new i; i < 20; ++i)
	    {
	        if(i < 4) TextDrawHideForPlayer(playerid, Store_Frame[i]);

	        if(i < 10)
			{
				PlayerTextDrawHide(playerid, Store_Items[playerid][i]);
				PlayerData[playerid][ItemCache][i] = -1;
			}

	        PlayerTextDrawHide(playerid, Store_UI[playerid][i]);
	    }

        PlayerTextDrawHide(playerid, Store_Business[playerid]);
        PlayerTextDrawHide(playerid, Store_Header[playerid]);
        PlayerTextDrawHide(playerid, Store_Info[playerid]);
        PlayerTextDrawHide(playerid, Store_Cart[playerid]);
	    PlayerTextDrawHide(playerid, Store_Mask[playerid]);

	    DeletePVar(playerid, "PriceCount");
	    UI_Purchase{playerid} = false;
	}
	return true;
}

AddItemToCart(playerid, x, index_id)
{
	new
	    temp,
	    price = GetPVarInt(playerid, "PriceCount"),
	    str[256]
	;

	if(x == 9) temp = price + ReturnRadioPrice(SelectedRadio[playerid]);
	else temp = price + ReturnItemPrice(x);

	SelectedItem[playerid] = -1;
	PlayerData[playerid][ItemCache][index_id] = x;
	SetPVarInt(playerid, "PriceCount", temp);

	format(str, sizeof(str), "%s~n~~n~~g~%s was added to your cart", GetBusinessItemDescription(x), GetBusinessItemName(x));
	PlayerTextDrawSetString(playerid, Store_Info[playerid], str);

	PlayerTextDrawBackgroundColor(playerid, Store_Items[playerid][x], 0x9CB7A6FF);
	PlayerTextDrawShow(playerid, Store_Items[playerid][x]);

	if(x >= 2 && x <= 5)
	{
		if(HasOtherWeaponsInCart(playerid, x))
		{
			SendNoticeMessage(playerid, "If you have multiple weapons in your cart, only one will save.");
		}
	}

	format(str, sizeof(str), "Cart: ~g~$%s", MoneyFormat(temp));
	PlayerTextDrawSetString(playerid, Store_Cart[playerid], str);
}

Dialog:BusinessBuy_Radio(playerid, response, listitem, inputtext[])
{
    SelectTextDraw(playerid, 0xC6E5D2FF);

	if(!response || SelectedItem[playerid] != 9)
	{
	    SelectedRadio[playerid] = -1;
	    return true;
	}

	new
	    bizid = -1
	;

    if((bizid = Business_Inside(playerid)) != -1 && response)
    {
		if(BusinessData[bizid][bType] == 3)
		{
		    if(PlayerData[playerid][pRadio] >= ReturnRadioSlots(listitem))
		    {
		        new str[180];
			    format(str, sizeof(str), "%s~n~~n~~r~You already have that, or better radio!", GetBusinessItemDescription(9));
				return ShowStoreInformation(playerid, "Radio", str);
		    }

			SelectedRadio[playerid] = listitem;

			new index_id = PlayerCache_GetFree(playerid);

			if(index_id != -1) AddItemToCart(playerid, 9, index_id);
		}
	}
	return true;
}

ReturnItemPrice(itemid)
{
	switch(itemid)
	{
	    case 0:
			return 400;
	    case 1:
	        return 5000;
	    case 2:
	        return 1500;
	    case 3:
     		return 400;
	    case 4:
     		return 100;
		case 5:
     		return 400;
		case 6:
     		return 1500;
		case 7:
     		return 200;
		case 8:
     		return 400;
	}
	return true;
}

ReturnRadioPrice(itemid)
{
	switch(itemid)
	{
	    case 0:
			return 1000;
	    case 1:
	        return 2000;
	    case 2:
	        return 5000;
	}
	return true;
}

/*ReturnItemPrice(itemid)
{
	switch(itemid)
	{
	    case 0:
			return 500;
	    case 1:
	        return 10000;
	    case 2:
	        return 1500;
	    case 3:
     		return 500;
	    case 4:
     		return 200;
		case 5:
     		return 500;
		case 6:
     		return 5000;
		case 7:
     		return 200;
		case 8:
     		return 500;
	}
	return true;
}

ReturnRadioPrice(itemid)
{
	switch(itemid)
	{
	    case 0:
			return 2000;
	    case 1:
	        return 5000;
	    case 2:
	        return 8000;
	}
	return true;
}*/

ReturnRadioSlots(itemid)
{
	switch(itemid)
	{
	    case 0:
			return 2;
	    case 1:
	        return 5;
	    case 2:
	        return 8;
	}
	return true;
}

OnPlayerPurchaseItem(playerid, type)
{
	new
		bizid = InBusiness[playerid]
	;

	BusinessData[bizid][bProducts]--;

	if(type == 9) BusinessData[bizid][bTill] += floatround(ReturnRadioPrice(SelectedRadio[playerid]) * 0.7);
	else BusinessData[bizid][bTill] += floatround(ReturnItemPrice(type) * 0.7);

	switch(type)
	{
	    case 0: PlayerData[playerid][pGasCan]++;
	    case 1: PlayerData[playerid][pBoombox] = 1;
	    case 2: GivePlayerValidWeapon(playerid, 5, 1, 0, false, false);
	    case 3: GivePlayerValidWeapon(playerid, 14, 1, 0, false, false);
	    case 4: GivePlayerValidWeapon(playerid, 15, 1, 0, false, false);
		case 5: GivePlayerValidWeapon(playerid, 43, 9999, 0, false, false);
		case 6: PlayerData[playerid][pHasMask] = true;
		case 7: PlayerData[playerid][pDrink] += 3;
		case 8: PlayerData[playerid][pCigarettes] += 14;
		case 9: PlayerData[playerid][pRadio] = ReturnRadioSlots(SelectedRadio[playerid]);
	}
	return true;
}

GetBusinessItemName(item)
{
	new
	    name[32]
	;

	switch(item)
	{
	    case 0: name = "Gas Can";
	    case 1: name = "Boombox";
	    case 2: name = "Baseball Bat";
	    case 3: name = "Flowers";
	    case 4: name = "Cane";
	    case 5: name = "Camera";
	    case 6: name = "OOC Mask";
	    case 7: name = "Drink";
	    case 8: name = "Cigarettes";
	    case 9: name = "Radio";
	}

	return name;
}

GetBusinessItemDescription(item)
{
	new
	    desc[256]
	;

	switch(item)
	{
	    case 0: desc = "If you run out of fuel and no gas station~n~is nearby, a gas can sure comes in~n~handy. Contains 3 gallons.";
	    case 1: desc = "Listen to your favourite tunes with friends~n~on a stereo boombox.";
	    case 2: desc = "Firm baseball bat which will suit both~n~begineers and professional baseball~n~players.";
	    case 3: desc = "Boquet of beautiful flowers of your~n~choice.Works for upset wives, mom's~n~birthday or grandma's funeral.";
	    case 4: desc = "";
	    case 5: desc = "Disposable camera to capture~n~the important moments forever.";
	    case 6: desc = "(( Hides your nametag and name in chat.~n~This is purely OOC and provides no IC~n~face coverage. ))";
	    case 7: desc = "Choose from a variety of drinks to~n~refresh your body and mind.";
	    case 8: desc = "A pack of 17 Cancer Sticks cigarettes for~n~the less fond of their health.";
	    case 9: desc = "Short-wave radio that can hold up to~n~eight channels.";
	}

	return desc;
}

GetBusinessItemInfo(item)
{
	new
	    desc[64]
	;

	switch(item)
	{
	    case 0: desc = "Use /fill to use the gas can.";
	    case 1: desc = "";
	    case 2: desc = "";
	    case 3: desc = "";
	    case 4: desc = "";
	    case 5: desc = "";
	    case 6: desc = "";
	    case 7: desc = "Use /bdrink to start drinking.";
	    case 8: desc = "To smoke, use: /cigarette use.";
	    case 9: desc = "Use /radiohelp for info about radios.";
	}

	return desc;
}

HasOtherWeaponsInCart(playerid, idx = -1)
{
	for(new i = 0; i < 10; ++i)
	{
		if(PlayerData[playerid][ItemCache][i] == -1) continue;

		if(PlayerData[playerid][ItemCache][i] == idx) continue;

		if(PlayerData[playerid][ItemCache][i] == 2 || PlayerData[playerid][ItemCache][i] == 3 || PlayerData[playerid][ItemCache][i] == 4 || PlayerData[playerid][ItemCache][i] == 5)
		{
		    return true;
		}
	}

	return false;
}

ShowStoreInformation(playerid, const header[], const body[])
{
	if(strlen(header) > 0)
		PlayerTextDrawSetString(playerid, Store_Header[playerid], header);

	if(strlen(body) > 0)
		PlayerTextDrawSetString(playerid, Store_Info[playerid], body);

	return true;
}

PlayerCache_GetFree(playerid)
{
	for(new i = 0; i < 10; ++i)
	{
		if(PlayerData[playerid][ItemCache][i] == -1)
			return i;
	}
	return -1;
}
