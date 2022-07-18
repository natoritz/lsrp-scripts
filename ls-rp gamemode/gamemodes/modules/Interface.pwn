TextHud_Update(playerid, vehicleid = 0)
{
    if(!HudStatus{playerid}) 
	{
		ToggleHudTextdraw(playerid, true);
	}

    new slot = PlayerData[playerid][pMainSlot], channel, string[200];

	if(slot >= 1)
	{
		channel = PlayerData[playerid][pRadioChan][slot];
	}
	else channel = 0;

	if(channel == -1) slot = 0;

    if(!vehicleid)
    {
		switch(PlayerData[playerid][pHUDStyle])
		{
		    case 0:
		    {
		        if(channel > 99999)
		        {
		            format(string, sizeof(string), "~b~RADIO INFO~n~~b~Chan: ~g~~n~%d~n~~b~Slot: ~g~%d", channel, slot);
		            PlayerTextDrawSetString(playerid, HudTextDraw[playerid], string);
		        }
		        else
		        {
		            format(string, sizeof(string), "~b~RADIO INFO~n~~b~Chan: ~g~%d~n~~b~Slot: ~g~%d", channel, slot);
		            PlayerTextDrawSetString(playerid, HudTextDraw[playerid], string);
		        }
			}
            case 1:
            {
 				format(string, sizeof(string), "_~n~~w~Radio Info: ~y~%d~n~~w~Slot: ~y~%d", channel, slot);
	            PlayerTextDrawSetString(playerid, HudTextDraw[playerid], string);
            }
            case 2, 3:
			{
				if(HudStatus{playerid}) 
				{
					ToggleHudTextdraw(playerid, false);
				}
			}
            case 4:
            {
  				format(string, sizeof(string), "~w~Radio Info:~n~%d ~n~slot: %d", channel, slot);
	            PlayerTextDrawSetString(playerid, HudTextDraw[playerid], string);
            }
		}
    }
    else
    {
	    new model = GetVehicleModel(vehicleid), Float: kmh_speed = floatround(CoreVehicles[vehicleid][vSpeed] * 195.12), Float: mph_speed = floatround(CoreVehicles[vehicleid][vSpeed] * 121.30);

        switch(PlayerData[playerid][pHUDStyle])
        {
			case 0:
			{
		        if(!IsABicycle(vehicleid))
		        {
		            if(channel > 99999)
		            {
		                format(string, sizeof(string), "~b~Km/h: ~g~%.0f~n~~b~Fuel: ~g~%d~n~ ~n~~b~RADIO INFO~n~~b~Chan: ~g~~n~%d~n~~b~Slot: ~g~%d", kmh_speed, floatround(floatdiv(CoreVehicles[vehicleid][vehFuel], GetVehicleDataFuel(model))*100, floatround_round), channel, slot);
		                PlayerTextDrawSetString(playerid, HudTextDraw[playerid], string);
		            }
		            else
		            {
		                format(string, sizeof(string), "~b~Km/h: ~g~%.0f~n~~b~Fuel: ~g~%d~n~ ~n~~b~RADIO INFO~n~~b~Chan: ~g~%d~n~~b~Slot: ~g~%d", kmh_speed, floatround(floatdiv(CoreVehicles[vehicleid][vehFuel], GetVehicleDataFuel(model))*100, floatround_round), channel, slot);
		                PlayerTextDrawSetString(playerid, HudTextDraw[playerid], string);
		            }
		        }
		        else
		        {
		            if(channel > 99999)
		            {
		                format(string, sizeof(string), "~b~Km/h: ~g~%.0f~n~~b~Fuel: ~g~--~n~ ~n~~b~RADIO INFO~n~~b~Chan: ~g~~n~%d~n~~b~Slot: ~g~%d", kmh_speed, channel, slot);
		                PlayerTextDrawSetString(playerid, HudTextDraw[playerid], string);
		            }
		            else
		            {
		                format(string, sizeof(string), "~b~Km/h: ~g~%.0f~n~~b~Fuel: ~g~--~n~ ~n~~b~RADIO INFO~n~~b~Chan: ~g~%d~n~~b~Slot: ~g~%d", kmh_speed, channel, slot);
		                PlayerTextDrawSetString(playerid, HudTextDraw[playerid], string);
		            }
		        }
			}
			case 1:
			{
				if(CoreVehicles[vehicleid][vHasEngine])
					format(string, sizeof(string), "~w~%s~r~ %d %.0f~y~KMH~w~/~y~%.0f~r~MPH", ReturnVehicleName(vehicleid), floatround(floatdiv(CoreVehicles[vehicleid][vehFuel], GetVehicleDataFuel(model))*100, floatround_round), kmh_speed, mph_speed);
				else
					format(string, sizeof(string), "~w~%s~r~ -- %.0f~y~KMH~w~/~y~%.0f~r~MPH", ReturnVehicleName(vehicleid), kmh_speed, mph_speed);

				format(string, sizeof(string), "%s~n~~w~Radio Info: ~y~%d~n~~w~Slot: ~y~%d", string, channel, slot);

				PlayerTextDrawSetString(playerid, HudTextDraw[playerid], string);
			}
			case 2:
			{
			    new Float:vehicleHealth;
			    GetVehicleHealth(vehicleid, vehicleHealth);

				if(CoreVehicles[vehicleid][vHasEngine])
					format(string, sizeof(string), "~l~%s~n~ ~w~%.0f  ~l~%.0f ~w~%.0f ~l~%d", ReturnVehicleName(vehicleid), mph_speed, kmh_speed, vehicleHealth, floatround(floatdiv(CoreVehicles[vehicleid][vehFuel], GetVehicleDataFuel(model)) * 100, floatround_round));
				else
					format(string, sizeof(string), "~l~%s~n~ ~w~%.0f  ~l~%.0f ~w~%.0f ~l~--", ReturnVehicleName(vehicleid), mph_speed, kmh_speed, vehicleHealth);

				PlayerTextDrawSetString(playerid, HudTextDraw[playerid], string);
			}
			case 3:
			{
				if(CoreVehicles[vehicleid][vHasEngine])
					format(string, sizeof(string), "~g~%d ~r~%d ~w~%d", floatround(floatdiv(CoreVehicles[vehicleid][vehFuel], GetVehicleDataFuel(model))*100, floatround_round), floatround(mph_speed), floatround(kmh_speed));
				else
					format(string, sizeof(string), "~g~-- ~r~%d- ~w~%d", floatround(mph_speed), floatround(kmh_speed));

				PlayerTextDrawSetString(playerid, HudTextDraw[playerid], string);
			}
			case 4:
			{
				new shortstr[128];

				if(CoreVehicles[vehicleid][vHasEngine])
				{
					format(string, sizeof(string), "~w~Radio Info:~n~%d ~n~slot: %d", channel, slot);

					switch(floatround(mph_speed))
					{
					    case 0..10: shortstr = "~n~~w~-";
					    case 11..20: shortstr = "~n~~w~--";
					    case 21..30: shortstr = "~n~~w~---";
					    case 31..40: shortstr = "~n~~w~---~g~-";
					    case 41..50: shortstr = "~n~~w~---~g~--";
					    case 51..60: shortstr = "~n~~w~---~g~---";
					    case 61..70: shortstr = "~n~~w~---~g~---~y~-";
					    case 71..80: shortstr = "~n~~w~---~g~---~y~--";
					    case 81..90: shortstr = "~n~~w~---~g~---~y~---";
					    case 91..100: shortstr = "~n~~w~---~g~---~y~---~r~-";
					    case 101..110: shortstr = "~n~~w~---~g~---~y~---~r~--";
					    case 111..400: shortstr = "~n~~w~---~g~---~y~---~r~---";
					}

					strcat(string, shortstr);
				}
				else format(string, sizeof(string), "~w~Radio Info:~n~%d ~n~slot: %d", channel, slot);

				PlayerTextDrawSetString(playerid, HudTextDraw[playerid], string);
			}
		}
    }
    return true;
}

ToggleHudTextdraw(playerid, bool:status)
{
	HudStatus{playerid} = status;

	if(status) 
	{
		PlayerTextDrawShow(playerid, HudTextDraw[playerid]);
	}
	else 
	{
		PlayerTextDrawHide(playerid, HudTextDraw[playerid]);
	}

	return true;
}

CreatePlayerHUD(playerid)
{
    HUD_Created{playerid} = false;

    PlayerTextDrawDestroy(playerid, HudTextDraw[playerid]);

	switch(PlayerData[playerid][pHUDStyle])
	{
		case 0:
		{
			HudTextDraw[playerid] = CreatePlayerTextDraw(playerid, 545.000000, 110.000000, ""); //~b~RADIO INFO~n~~b~Chan: ~g~0~n~~b~Slot: ~g~1
			PlayerTextDrawLetterSize(playerid, HudTextDraw[playerid], 0.480000, 1.120000);
			PlayerTextDrawTextSize(playerid, HudTextDraw[playerid], 60.000000, 100.000000);
			PlayerTextDrawAlignment(playerid, HudTextDraw[playerid], 2);
			PlayerTextDrawColor(playerid, HudTextDraw[playerid], -1);
			PlayerTextDrawSetShadow(playerid, HudTextDraw[playerid], 2);
			PlayerTextDrawSetOutline(playerid, HudTextDraw[playerid], 0);
			PlayerTextDrawBackgroundColor(playerid, HudTextDraw[playerid], 255);
			PlayerTextDrawFont(playerid, HudTextDraw[playerid], 3);
			PlayerTextDrawSetProportional(playerid, HudTextDraw[playerid], 1);
  		}
		case 1:
		{
			HudTextDraw[playerid] = CreatePlayerTextDraw(playerid, 12.999976, 125.288810, ""); //BMX -- 62KMH/39MPH~n~Radio Info: 0~n~Slot: 1
			PlayerTextDrawLetterSize(playerid, HudTextDraw[playerid], 0.297999, 1.550219);
			PlayerTextDrawTextSize(playerid, HudTextDraw[playerid], 1705.000000, 0.000000);
			PlayerTextDrawAlignment(playerid, HudTextDraw[playerid], 1);
			PlayerTextDrawColor(playerid, HudTextDraw[playerid], -1);
			PlayerTextDrawSetShadow(playerid, HudTextDraw[playerid], 0);
			PlayerTextDrawSetOutline(playerid, HudTextDraw[playerid], 1);
			PlayerTextDrawBackgroundColor(playerid, HudTextDraw[playerid], 0x000000AA);
			PlayerTextDrawFont(playerid, HudTextDraw[playerid], 1);
			PlayerTextDrawSetProportional(playerid, HudTextDraw[playerid], 1);
		}
		case 2:
		{
			HudTextDraw[playerid] = CreatePlayerTextDraw(playerid, 507.666748, 400.725708, "");
			PlayerTextDrawLetterSize(playerid, HudTextDraw[playerid], 0.601332, 2.392297);
			PlayerTextDrawTextSize(playerid, HudTextDraw[playerid], 0.000000, 2366.000000);
			PlayerTextDrawAlignment(playerid, HudTextDraw[playerid], 2);
			PlayerTextDrawColor(playerid, HudTextDraw[playerid], 255);
			PlayerTextDrawSetShadow(playerid, HudTextDraw[playerid], 0);
			PlayerTextDrawSetOutline(playerid, HudTextDraw[playerid], 1);
			PlayerTextDrawBackgroundColor(playerid, HudTextDraw[playerid], -1431655681);
			PlayerTextDrawFont(playerid, HudTextDraw[playerid], 2);
			PlayerTextDrawSetProportional(playerid, HudTextDraw[playerid], 1);
		}
		case 3:
		{
			HudTextDraw[playerid] = CreatePlayerTextDraw(playerid, 553.524169, 96.426689, ""); //~g~0 ~r~0 ~w~0
			PlayerTextDrawLetterSize(playerid, HudTextDraw[playerid], 0.571142, 2.406401);
			PlayerTextDrawAlignment(playerid, HudTextDraw[playerid], 2);
			PlayerTextDrawColor(playerid, HudTextDraw[playerid], -1);
			PlayerTextDrawSetShadow(playerid, HudTextDraw[playerid], 0);
			PlayerTextDrawSetOutline(playerid, HudTextDraw[playerid], 1);
			PlayerTextDrawBackgroundColor(playerid, HudTextDraw[playerid], 255);
			PlayerTextDrawFont(playerid, HudTextDraw[playerid], 3);
			PlayerTextDrawSetProportional(playerid, HudTextDraw[playerid], 1);
		}
		case 4:
		{
			HudTextDraw[playerid] = CreatePlayerTextDraw(playerid, 554.286499, 369.493011, ""); //~w~Radio Info:~n~911 ~n~slot: 1~n~~w~---~g~---~y~---~r~---
			PlayerTextDrawLetterSize(playerid, HudTextDraw[playerid], 0.366190, 1.190400);
			PlayerTextDrawAlignment(playerid, HudTextDraw[playerid], 1);
			PlayerTextDrawColor(playerid, HudTextDraw[playerid], -1);
			PlayerTextDrawSetShadow(playerid, HudTextDraw[playerid], 0);
			PlayerTextDrawSetOutline(playerid, HudTextDraw[playerid], 1);
			PlayerTextDrawBackgroundColor(playerid, HudTextDraw[playerid], 255);
			PlayerTextDrawFont(playerid, HudTextDraw[playerid], 3);
			PlayerTextDrawSetProportional(playerid, HudTextDraw[playerid], 1);
		}
	}

	HUD_Created{playerid} = true;
}
