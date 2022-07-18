static vehicleid, carid = -1;

task Vehicles[1000]()
{
    foreach (new i : sv_activevehicles) // faster, optimized timer that loops only through active vehicles, skipping hundreds of inactive ones in most cases.
    {
		vehicleid = i;

		if(vehicleid < 5)
		{
			if(aTolls[vehicleid][E_tOpenTime] > 0)
			{
				aTolls[vehicleid][E_tOpenTime] --;

				if(!aTolls[vehicleid][E_tOpenTime])
				{
					Toll_CloseToll(vehicleid);

					if(!AdvertData[vehicleid][ad_id] && !VehicleLabel[vehicleid][vLabelTime]) Iter_SafeRemove(sv_activevehicles, vehicleid, i);
				}
			}

			if(AdvertData[vehicleid][ad_id])
			{
				AdvertData[vehicleid][ad_time] --;

				if(AdvertData[vehicleid][ad_time] <= 0)
				{
				    if(AdvertData[vehicleid][ad_type])
					{
						if(strlen(AdvertData[vehicleid][ad_text]) > 70)
						{
							format(vgstr, sizeof(vgstr), "[Company Advertisement] %.70s ...", AdvertData[vehicleid][ad_text]);
							SendClientMessageToAll(COLOR_GREEN, vgstr);
							format(vgstr, sizeof(vgstr), "[Company Advertisement] ... %s", AdvertData[vehicleid][ad_text][70]);
							SendClientMessageToAll(COLOR_GREEN, vgstr);
						}
						else
						{
							format(vgstr, sizeof(vgstr), "[Company Advertisement] %s", AdvertData[vehicleid][ad_text]);
							SendClientMessageToAll(COLOR_GREEN, vgstr);
						}
				    }
				    else
					{
						if(strlen(AdvertData[vehicleid][ad_text]) > 70)
						{
							format(vgstr, sizeof(vgstr), "[Advertisement] %.70s ...", AdvertData[vehicleid][ad_text]);
							SendClientMessageToAll(COLOR_GREEN, vgstr);
							format(vgstr, sizeof(vgstr), "[Advertisement] ... %s [PH: %d]", AdvertData[vehicleid][ad_text][70], PlayerData[AdvertData[vehicleid][ad_owner]][pPnumber]);
							SendClientMessageToAll(COLOR_GREEN, vgstr);
						}
						else
						{
							format(vgstr, sizeof(vgstr), "[Advertisement] %s [PH: %d]", AdvertData[vehicleid][ad_text], PlayerData[AdvertData[vehicleid][ad_owner]][pPnumber]);
							SendClientMessageToAll(COLOR_GREEN, vgstr);
						}
				    }

				    SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "Ad Placed by %s id[%d]", ReturnName(AdvertData[vehicleid][ad_owner]), AdvertData[vehicleid][ad_owner]);

				    AdvertData[vehicleid][ad_id] = 0;
				    AdvertData[vehicleid][ad_time] = 0;
				    AdvertData[vehicleid][ad_owner] = INVALID_PLAYER_ID;

					if(!aTolls[vehicleid][E_tOpenTime] && !VehicleLabel[vehicleid][vLabelTime]) Iter_SafeRemove(sv_activevehicles, vehicleid, i);
				}
			}			
		}

        carid = CoreVehicles[vehicleid][vehicleCarID];

		if(carid != -1)
		{
			if(CoreVehicles[vehicleid][vbreaktime])
			{
				CoreVehicles[vehicleid][vbreaktime]--;

				if(CoreVehicles[vehicleid][vbreakdelay]) CoreVehicles[vehicleid][vbreakdelay]--;

				if(CoreVehicles[vehicleid][vbreaktime] <= 0)
				{
					if(!VehicleLabel[vehicleid][vLabelTime])
					{
						Iter_SafeRemove(sv_activevehicles, vehicleid, i);
					}

					CoreVehicles[vehicleid][vbreakin] = 0;
					CoreVehicles[vehicleid][vbreaktime] = 0;
					CoreVehicles[vehicleid][vbreakeffect] = 0;												

					new
						engine,
						lights,
						alarm,
						doors,
						bonnet,
						boot,
						objective;

					GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
					SetVehicleParamsEx(vehicleid, engine, lights, 0, doors, bonnet, boot, 0);
				}
			}
		}

		if(CoreVehicles[vehicleid][vehicleIsCargoLoad])
		{
			new industryid = CoreVehicles[vehicleid][vehicleCargoStorage];

			if(IsVehicleInRangeOfPoint(vehicleid, 20.0, StorageData[industryid][in_posx], StorageData[industryid][in_posy], StorageData[industryid][in_posz]))
			{
				new playerid = CoreVehicles[vehicleid][vehicleCargoPlayer];

				if(IsPlayerConnected(playerid))
				{
					CoreVehicles[vehicleid][vehicleCargoTime]--;

					if(CoreVehicles[vehicleid][vehicleCargoTime] < 1)
					{
						if(!CoreVehicles[vehicleid][vehicleCargoAction])
						{
							CoreVehicles[vehicleid][vehicleCrate][StorageData[industryid][in_item]] += CoreVehicles[vehicleid][vehicleIsCargoLoad];

							if(playerid != INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_WHITE, "Cargo loading finished.");
						}
						else
						{
							SendPlayerMoney(playerid, StorageData[industryid][in_price] * CoreVehicles[vehicleid][vehicleIsCargoLoad]);

							CoreVehicles[vehicleid][vehicleCrate][StorageData[industryid][in_item]] = 0;

							if(playerid != INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_WHITE, "Cargo unloading finished.");
						}

						CoreVehicles[vehicleid][vehicleCargoAction] = 0;
						CoreVehicles[vehicleid][vehicleIsCargoLoad] = 0;
						CoreVehicles[vehicleid][vehicleCargoStorage] = 0;
						CoreVehicles[vehicleid][vehicleCargoPlayer] = 0;
						CoreVehicles[vehicleid][vehicleCargoTime] = 0;

						Iter_SafeRemove(sv_activevehicles, vehicleid, i);
					}
					else
					{
						format(vgstr, 128, "~r~Cargo is being (un)loaded,~n~~b~Please wait...~n~(%d Seconds left)", CoreVehicles[vehicleid][vehicleCargoTime]);
						GameTextForPlayer(playerid, vgstr, 1000, 3);
					}
				}
				else
				{
					CoreVehicles[vehicleid][vehicleCargoAction] = 0;
					CoreVehicles[vehicleid][vehicleIsCargoLoad] = 0;
					CoreVehicles[vehicleid][vehicleCargoStorage] = 0;
					CoreVehicles[vehicleid][vehicleCargoPlayer] = 0;
					CoreVehicles[vehicleid][vehicleCargoTime] = 0;

					Iter_SafeRemove(sv_activevehicles, vehicleid, i);
				}
			}
		}

		if(VehicleLabel[vehicleid][vLabelTime] > 0)
		{
		    VehicleLabel[vehicleid][vLabelCount]++;

			switch(VehicleLabel[vehicleid][vLabelType])
			{
			    case VLT_TYPE_TOWING:
				{
				    new labelstring[32], first = VehicleLabel[vehicleid][vLabelCount], second = VehicleLabel[vehicleid][vLabelTime], Float:percent = (float(second-first)/float(second))*float(10);

					for(new x = 10; x > 0; --x)
					{
					    if(x - floatround(percent) > 0)
							format(labelstring, sizeof(labelstring), "%s|", labelstring);
					    else
							format(labelstring, sizeof(labelstring), "%s-", labelstring);
     				}

					format(vgstr, sizeof(vgstr), "(( %s ))\nTOWING VEHICLE", labelstring);
		            UpdateDynamic3DTextLabelText(VehicleLabel[vehicleid][vLabel], COLOR_GREEN2, vgstr);

				    if(VehicleLabel[vehicleid][vLabelCount] >= VehicleLabel[vehicleid][vLabelTime])
					{
						new
							engine,
							lights,
							alarm,
							doors,
							bonnet,
							boot,
							objective;

						GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
						SetVehicleParamsEx(vehicleid, engine, lights, alarm, 1, bonnet, boot, objective);

						SaveVehicleDamage(vehicleid);
						SetVehicleToRespawn(vehicleid);

						if(!CoreVehicles[vehicleid][vbreaktime]) Iter_SafeRemove(sv_activevehicles, vehicleid, i);

                        ResetVehicleLabel(vehicleid);

				        new targetid = CoreVehicles[vehicleid][vOwnerID];

						if(PlayerData[targetid][pCash] >= 2000)
						{
						    SendClientMessageEx(targetid, COLOR_RADIO, "%s has been towed to its parking place.", g_arrVehicleNames[GetVehicleModel(vehicleid) - 400]);

							TakePlayerMoney(targetid, 2000);
						}
					}
				}
				case VLT_TYPE_REFILL:
				{
				    new bool:dealership, id = -1;

					foreach (new x : Business)
					{
						if(BusinessData[x][bType] == 1)
						{
							if(IsVehicleInRangeOfPoint(vehicleid, 20, BusinessData[x][bEntranceX], BusinessData[x][bEntranceY], BusinessData[x][bEntranceZ]))
							{
							    id = x;

								dealership = true;
								break;
							}
						}
					}

					if(dealership)
					{
					    new labelstring[32], first = VehicleLabel[vehicleid][vLabelCount], second = VehicleLabel[vehicleid][vLabelTime], Float:percent = (float(second-first)/float(second))*float(10);

						for(new x = 10; x > 0; x--)
						{
						    if(x - floatround(percent) > 0)
								format(labelstring, sizeof(labelstring), "%s|", labelstring);
						    else
								format(labelstring, sizeof(labelstring), "%s-", labelstring);
	     				}

						format(vgstr, sizeof(vgstr), "(( %s ))\nREFUELING", labelstring);
			            UpdateDynamic3DTextLabelText(VehicleLabel[vehicleid][vLabel], COLOR_GREEN2, vgstr);

					    if(VehicleLabel[vehicleid][vLabelCount] >= VehicleLabel[vehicleid][vLabelTime])
						{
							new
								targetid = CoreVehicles[vehicleid][vOwnerID],
							    Float:maxfuel = GetVehicleDataFuel(GetVehicleModel(vehicleid)),
							    Float:fueladd = maxfuel - CoreVehicles[vehicleid][vehFuel],
								uprice = floatround(fueladd*float(BusinessData[id][bItems][0]), floatround_ceil)
							;

							SendClientMessageEx(targetid, COLOR_RADIO, "This operation required $%d", uprice);

							if(PlayerData[targetid][pCash] >= uprice)
							{
								TakePlayerMoney(targetid, uprice);

		                        CoreVehicles[vehicleid][vehFuel] = GetVehicleDataFuel(GetVehicleModel(vehicleid));
							}

							if(!CoreVehicles[vehicleid][vbreaktime]) Iter_SafeRemove(sv_activevehicles, vehicleid, i);

                            ResetVehicleLabel(vehicleid);
						}
					}
					else
					{
						if(!CoreVehicles[vehicleid][vbreaktime]) Iter_SafeRemove(sv_activevehicles, vehicleid, i);

                        ResetVehicleLabel(vehicleid);

					    SetVehicleLabel(vehicleid, VLT_TYPE_OPERAOUTOFRANG, 5);
					}
				}
			    case VLT_TYPE_ARMOUR:
				{
				    new bool:dealership;

					foreach (new x : Business)
					{
						if(BusinessData[x][bType] == 4)
						{
							if(IsVehicleInRangeOfPoint(vehicleid, 10, BusinessData[x][bEntranceX], BusinessData[x][bEntranceY], BusinessData[x][bEntranceZ]))
							{
								dealership = true;
								break;
							}
						}
					}

					if(dealership)
					{
					    new labelstring[32], first = VehicleLabel[vehicleid][vLabelCount], second = VehicleLabel[vehicleid][vLabelTime], Float:percent = (float(second-first)/float(second))*float(10);

						for(new x = 10; x > 0; --x)
						{
						    if(x - floatround(percent) > 0)
								format(labelstring, sizeof(labelstring), "%s|", labelstring);
						    else
								format(labelstring, sizeof(labelstring), "%s-", labelstring);
	     				}

						format(vgstr, sizeof(vgstr), "(( %s ))\nUPGRADING ARMOUR", labelstring);
			            UpdateDynamic3DTextLabelText(VehicleLabel[vehicleid][vLabel], COLOR_GREEN2, vgstr);

					    if(VehicleLabel[vehicleid][vLabelCount] >= VehicleLabel[vehicleid][vLabelTime])
						{
							new
								targetid = CoreVehicles[vehicleid][vOwnerID],
								uplevel = CoreVehicles[vehicleid][vUpgradeID],
								uprice = uplevel * GetVehicleDataArmourCost(CarData[carid][carModel])
							;

							SendClientMessageEx(targetid, COLOR_YELLOW3, "This operation required %s", FormatNumber(uprice));

							if(PlayerData[targetid][pCash] >= uprice)
							{
								TakePlayerMoney(targetid, uprice);

		                        CarData[carid][carArmour] += float(uplevel);

								SetVehicleHealth(vehicleid, CoreVehicles[vehicleid][vehCrash] + float(uplevel));

		                        format(vgstr, sizeof(vgstr), "Armour added: %d~n~Armour will result in a more durable vehicle~n~and aid protection to the occupants", uplevel);
		                        ShowPlayerFooter(targetid, vgstr, 10000);

		                        Car_SaveID(carid);
							}

							if(!CoreVehicles[vehicleid][vbreaktime]) Iter_SafeRemove(sv_activevehicles, vehicleid, i);

                            ResetVehicleLabel(vehicleid);
						}
					}
					else
					{
						if(!CoreVehicles[vehicleid][vbreaktime]) Iter_SafeRemove(sv_activevehicles, vehicleid, i);

                        ResetVehicleLabel(vehicleid);

					    SetVehicleLabel(vehicleid, VLT_TYPE_OPERAFAILED, 5);
					}
				}
				case VLT_TYPE_PERMITFACTION, VLT_TYPE_LOCK, VLT_TYPE_OPERAFAILED, VLT_TYPE_BREAKIN, VLT_TYPE_OPERAOUTOFRANG:
				{
				    if(VehicleLabel[vehicleid][vLabelCount] >= VehicleLabel[vehicleid][vLabelTime])
				    {
						if(!CoreVehicles[vehicleid][vbreaktime]) Iter_SafeRemove(sv_activevehicles, vehicleid, i);

                        ResetVehicleLabel(vehicleid);
				    }
				}
		        case VLT_TYPE_UPGRADELOCK, VLT_TYPE_UPGRADEALARM, VLT_TYPE_UPGRADEIMMOB, VLT_TYPE_UPGRADEINSURANCE, VLT_TYPE_UPGRADEBATTERY, VLT_TYPE_UPGRADEENGINE:
				{
					new bool:dealership;

					foreach (new x : Business)
					{
						if(BusinessData[x][bType] == 4)
						{
							if(IsVehicleInRangeOfPoint(vehicleid, 10, BusinessData[x][bEntranceX], BusinessData[x][bEntranceY], BusinessData[x][bEntranceZ]))
							{
								dealership = true;
								break;
							}
						}
					}

					if(dealership)
					{
						new labelstring[32], first = VehicleLabel[vehicleid][vLabelCount], second = VehicleLabel[vehicleid][vLabelTime], Float:percent = (float(second-first)/float(second))*float(10);

						for(new x = 10; x > 0; --x)
						{
						    if(x - floatround(percent) > 0)
								format(labelstring, sizeof(labelstring), "%s|", labelstring);
						    else
								format(labelstring, sizeof(labelstring), "%s-", labelstring);
	     				}

	     				switch(VehicleLabel[vehicleid][vLabelType])
	     				{
							case VLT_TYPE_UPGRADELOCK:
								format(vgstr, sizeof(vgstr), "(( %s ))\nUPGRADING LOCK", labelstring);
							case VLT_TYPE_UPGRADEIMMOB:
								format(vgstr, sizeof(vgstr), "(( %s ))\nUPGRADING IMMOBILISER", labelstring);
							case VLT_TYPE_UPGRADEALARM:
								format(vgstr, sizeof(vgstr), "(( %s ))\nUPGRADING ALARM", labelstring);
							case VLT_TYPE_UPGRADEINSURANCE:
								format(vgstr, sizeof(vgstr), "(( %s ))\nINSURANCE UPGRADE", labelstring);
							case VLT_TYPE_UPGRADEBATTERY:
								format(vgstr, sizeof(vgstr), "(( %s ))\nBATTERY REPLACEMENT", labelstring);
							case VLT_TYPE_UPGRADEENGINE:
								format(vgstr, sizeof(vgstr), "(( %s ))\nENGINE CHANGE", labelstring);
						}

			            UpdateDynamic3DTextLabelText(VehicleLabel[vehicleid][vLabel], COLOR_GREEN2, vgstr);

					    if(VehicleLabel[vehicleid][vLabelCount] >= VehicleLabel[vehicleid][vLabelTime])
						{
							new
								targetid = CoreVehicles[vehicleid][vOwnerID],
								uplevel = CoreVehicles[vehicleid][vUpgradeID]
							;

                            if(carid != 9999)
							{
			     				switch(VehicleLabel[vehicleid][vLabelType])
			     				{
									case VLT_TYPE_UPGRADELOCK:
									{
										new uprice = floatround(VehicleData[CarData[carid][carModel] - 400][c_price] / VehicleUpgradeLock[uplevel-1][u_rate]) + VehicleUpgradeLock[uplevel-1][u_price];

                                        SendClientMessageEx(targetid, COLOR_YELLOW3, "This operation required %s", FormatNumber(uprice));

										if(PlayerData[targetid][pCash] >= uprice)
										{
					                     	TakePlayerMoney(targetid, uprice);

					                     	CarData[carid][carLock] = uplevel;

					                     	switch(uplevel)
					                     	{
					                     	    case 1: ShowPlayerFooter(targetid, "~g~LOCK Level 1~n~+~w~500 second wait time protection against prying break-in method.~n~~g~+~w~Stronger armor- better defense against physical attack breaching. -Fist & melee.", 10000);
					                     	    case 2: ShowPlayerFooter(targetid, "~g~LOCK Level 2~n~+~w~750 second wait time protection against prying break-in method.~n~~g~+~w~Special armor- better defense x2 against melee attack breaching.", 10000);
					                     	    case 3: ShowPlayerFooter(targetid, "~g~LOCK Level 3~n~+~w~750 second wait time protection against prying break-in method.~n~~g~+~w~Special armor- better defense x2 against melee attack breaching.~n~~g~+~w~Special armor protection blocks physical attack breaching. -Fist", 10000);
					                     	    case 4: ShowPlayerFooter(targetid, "~g~LOCK Level 4~n~+~w~1,250 second wait time protection against prying break-in method.~n~~g~+~w~Special armor protection blocks all types of physical attack breaching.", 10000);
					                     	}
									   	}
									}
									case VLT_TYPE_UPGRADEIMMOB:
									{
										new uprice = floatround(VehicleData[CarData[carid][carModel] - 400][c_price] / VehicleUpgradeImmob[uplevel-1][u_rate]) + VehicleUpgradeImmob[uplevel-1][u_price];

                                        SendClientMessageEx(targetid, COLOR_YELLOW3, "This operation required %s", FormatNumber(uprice));

										if(PlayerData[targetid][pCash] >= uprice)
										{
					                     	TakePlayerMoney(targetid, uprice);

					                     	CarData[carid][carImmob] = uplevel;

					                     	switch(uplevel)
					                     	{
					                     	    case 1: ShowPlayerFooter(targetid, "~y~IMMOBILSER Level 1~n~+~w~The Engine Immobiliser will help prevent your ~n~vehicle from running without an authorized key.", 10000);
					                     	    case 2: ShowPlayerFooter(targetid, "~y~IMMOBILSER Level 2~n~+~w~The Engine Immobiliser will help prevent your ~n~vehicle from running without an authorized key.", 10000);
					                     	    case 3: ShowPlayerFooter(targetid, "~y~IMMOBILSER Level 3~n~+~w~The Engine Immobiliser will help prevent your ~n~vehicle from running without an authorized key.", 10000);
					                     	    case 4: ShowPlayerFooter(targetid, "~y~IMMOBILSER Level 4~n~+~w~The Engine Immobiliser will help prevent your ~n~vehicle from running without an authorized key.", 10000);
					                     	}
									   	}
									}
									case VLT_TYPE_UPGRADEALARM:
									{
										new uprice = floatround(VehicleData[CarData[carid][carModel] - 400][c_price] / VehicleUpgradeAlarm[uplevel-1][u_rate]) + VehicleUpgradeAlarm[uplevel-1][u_price];

                                        SendClientMessageEx(targetid, COLOR_YELLOW3, "This operation required %s", FormatNumber(uprice));

										if(PlayerData[targetid][pCash] >= uprice)
										{
					                     	TakePlayerMoney(targetid, uprice);

					                     	CarData[carid][carAlarm] = uplevel;

					                     	switch(uplevel)
					                     	{
					                     	    case 1: ShowPlayerFooter(targetid, "~r~ALARM Level 1~n~+~w~Loud vehicle alarm.", 10000);
					                     	    case 2: ShowPlayerFooter(targetid, "~r~ALARM Level 2~n~+~w~Loud vehicle alarm.~n~~r~+~w~Vehicle alerts the owner of a possible breach.", 10000);
					                     	    case 3: ShowPlayerFooter(targetid, "~r~ALARM Level 3~n~+~w~Loud vehicle alarm.~n~~r~+~w~Vehicle alerts the owner of a possible breach.~n~~r~+~w~Vehicle alerts the local police department of a possible breach.", 10000);
					                     	    case 4: ShowPlayerFooter(targetid, "~r~ALARM Level 4~n~+~w~Loud vehicle alarm.~n~~r~+~w~Vehicle alerts the owner of a possible breach.~n~~r~+~w~Vehicle alerts the local police department of a possible breach.~n~~r~+~w~Vehicle blip will appear on the law enforcement's radar.", 10000);
					                     	}
									   	}
									}
									case VLT_TYPE_UPGRADEINSURANCE:
									{
										new uprice = (IsABike(vehicleid)) ? (1000) : (2500) * uplevel;

                                        SendClientMessageEx(targetid, COLOR_YELLOW3, "This operation required %s", FormatNumber(uprice));

										if(PlayerData[targetid][pCash] >= uprice)
										{
					                     	TakePlayerMoney(targetid, uprice);

					                     	CarData[carid][carInsurance] = uplevel;

					                     	switch(uplevel)
					                     	{
					                     	    case 1: ShowPlayerFooter(targetid, "~b~INSURANCE Level 1~n~+~w~Vehicle will always respawn with its max health.", 10000);
					                     	    case 2: ShowPlayerFooter(targetid, "~b~INSURANCE Level 2~n~+~w~Vehicle will always respawn with its max health.~n~~b~+~w~Protection against vehicle damage. Vehicle will re-spawn good as new.", 10000);
					                     	    case 3: ShowPlayerFooter(targetid, "~b~INSURANCE Level 3~n~+~w~Vehicle will always respawn with its max health.~n~~b~+~w~Protection against vehicle damage. Vehicle will re-spawn good as new.~n~~b~+~w~Vehicle modification coverage. We got your fancy layout and XM tunes covered!", 10000);
					                     	}
									   	}
									}
									case VLT_TYPE_UPGRADEBATTERY:
									{
										new uprice = floatround(VehicleData[CarData[carid][carModel] - 400][c_price] / 2.48) + floatround(VehicleData[CarData[carid][carModel] - 400][c_battery] * 13.0);

                                        SendClientMessageEx(targetid, COLOR_YELLOW3, "This operation required %s", FormatNumber(uprice));

										if(PlayerData[targetid][pCash] >= uprice)
										{
					                     	TakePlayerMoney(targetid, uprice);

					                     	CarData[carid][carBatteryL] = VehicleData[CarData[carid][carModel] - 400][c_battery];

					                     	ShowPlayerFooter(targetid, "~w~BATTERY REPLACED!", 10000);
									   	}
									}
									case VLT_TYPE_UPGRADEENGINE:
									{
										new uprice = floatround(VehicleData[CarData[carid][carModel] - 400][c_price] / 1.72) + floatround(VehicleData[CarData[carid][carModel] - 400][c_engine] * 13.0);

                                        SendClientMessageEx(targetid, COLOR_YELLOW3, "This operation required %s", FormatNumber(uprice));

										if(PlayerData[targetid][pCash] >= uprice)
										{
					                     	TakePlayerMoney(targetid, uprice);

					                     	CarData[carid][carEngineL] = VehicleData[CarData[carid][carModel] - 400][c_engine];

					                     	ShowPlayerFooter(targetid, "~w~ENGINE REPLACED!", 10000);
									   	}
									}
								}

								Car_SaveID(carid);
							}

							CoreVehicles[vehicleid][vOwnerID] = INVALID_PLAYER_ID;
							CoreVehicles[vehicleid][vUpgradeID] = 0;

							if(!CoreVehicles[vehicleid][vbreaktime]) Iter_SafeRemove(sv_activevehicles, vehicleid, i);

                            ResetVehicleLabel(vehicleid);
						}
					}
					else
					{
						if(!CoreVehicles[vehicleid][vbreaktime]) Iter_SafeRemove(sv_activevehicles, vehicleid, i);

                        ResetVehicleLabel(vehicleid);

					    SetVehicleLabel(vehicleid, VLT_TYPE_OPERAFAILED, 5);
					}
				}
				case VLT_TYPE_REGISTER:
				{
				    new bool:dealership;

					foreach (new x : Business)
					{
						if(BusinessData[x][bType] == 4)
						{
							if(IsVehicleInRangeOfPoint(vehicleid, 10, BusinessData[x][bEntranceX], BusinessData[x][bEntranceY], BusinessData[x][bEntranceZ]))
							{
								dealership = true;
								break;
							}
						}
					}

					if(dealership)
					{
						new labelstring[32], first = VehicleLabel[vehicleid][vLabelCount], second = VehicleLabel[vehicleid][vLabelTime], Float:percent = (float(second-first)/float(second))*float(10);

						for(new x = 10; x > 0; --x)
						{
						    if(x-floatround(percent) > 0)
								format(labelstring, sizeof(labelstring), "%s|", labelstring);
						    else
								format(labelstring, sizeof(labelstring), "%s-", labelstring);
	     				}

						format(vgstr, sizeof(vgstr), "(( %s ))\nVehicle registration", labelstring);
			            UpdateDynamic3DTextLabelText(VehicleLabel[vehicleid][vLabel], COLOR_GREEN2, vgstr);

					    if(VehicleLabel[vehicleid][vLabelCount] >= VehicleLabel[vehicleid][vLabelTime])
						{
							new targetid = CoreVehicles[vehicleid][vOwnerID];

							if(PlayerData[targetid][pCash] >= 100)
							{
	                            SendClientMessage(targetid, COLOR_YELLOW3, "This operation required $100");

								if(carid != 9999)
								{
									new plate[8];
									format(plate, 8, "%s", RandomVehiclePlate());

									mysql_format(dbCon, vgstr,sizeof(vgstr),"SELECT * FROM cars WHERE carPlate = '%s'", plate);
									mysql_tquery(dbCon, vgstr, "RegisterPlates", "iis", targetid, carid, plate);

                                    Car_SaveID(carid);

                                    TakePlayerMoney(targetid, 100);

		                            CoreVehicles[vehicleid][vOwnerID] = INVALID_PLAYER_ID;

									if(!CoreVehicles[vehicleid][vbreaktime]) Iter_SafeRemove(sv_activevehicles, vehicleid, i);

                                    ResetVehicleLabel(vehicleid);
						        }
						   	}
						   	else SendClientMessage(targetid, COLOR_YELLOW3, "This operation requires $100");
						}
					}
					else
					{
						if(!CoreVehicles[vehicleid][vbreaktime]) Iter_SafeRemove(sv_activevehicles, vehicleid, i);

                        ResetVehicleLabel(vehicleid);

					    SetVehicleLabel(vehicleid, VLT_TYPE_OPERAFAILED, 5);
					}
				}
				case VLT_TYPE_UNREGISTER:
				{
					if(IsVehicleInRangeOfPoint(vehicleid, 10, 2520.3499,-1486.5232,23.9993)) // Black Market
					{
					    new labelstring[32], first = VehicleLabel[vehicleid][vLabelCount], second = VehicleLabel[vehicleid][vLabelTime], Float:percent = (float(second-first)/float(second))*float(10);

						for(new x = 10; x > 0; --x)
						{
						    if(x - floatround(percent) > 0)
								format(labelstring, sizeof(labelstring), "%s|", labelstring);
						    else
								format(labelstring, sizeof(labelstring), "%s-", labelstring);
	     				}

						format(vgstr, sizeof(vgstr), "(( %s ))\nRemoving registration", labelstring);
			            UpdateDynamic3DTextLabelText(VehicleLabel[vehicleid][vLabel], COLOR_GREEN2, vgstr);

					    if(VehicleLabel[vehicleid][vLabelCount] >= VehicleLabel[vehicleid][vLabelTime])
						{
							new targetid = CoreVehicles[vehicleid][vOwnerID];

							if(carid != 9999)
							{
								new Float: vPos[4]; // x, y, z + z angle

							    GetVehiclePos(vehicleid, vPos[0], vPos[1], vPos[2]);
							    GetVehicleZAngle(vehicleid, vPos[3]);

								format(CarData[carid][carPlate], 32, "_");
						        SetVehicleNumberPlate(vehicleid, CarData[carid][carPlate]);
						        SaveVehicleDamage(vehicleid);
						        SetVehicleToRespawn(vehicleid);
						        SetVehicleDamage(vehicleid);

								SetVehiclePos(vehicleid, vPos[0], vPos[1], vPos[2]);
								SetVehicleZAngle(vehicleid, vPos[3]);

						        if(GetVehicleDriver(vehicleid) != INVALID_PLAYER_ID) PutPlayerInVehicle(targetid, vehicleid, 0);

						        Car_SaveID(carid);

								ShowPlayerFooter(targetid, "~w~Your plate has been ~y~removed~n~Keep in mind It's illegal, don't let the cops notice.");

	                            CoreVehicles[vehicleid][vOwnerID] = INVALID_PLAYER_ID;

								if(!CoreVehicles[vehicleid][vbreaktime]) Iter_SafeRemove(sv_activevehicles, vehicleid, i);

                                ResetVehicleLabel(vehicleid);
					        }
						}
					}
					else
					{
						if(!CoreVehicles[vehicleid][vbreaktime]) Iter_SafeRemove(sv_activevehicles, vehicleid, i);

                        ResetVehicleLabel(vehicleid);

					    SetVehicleLabel(vehicleid, VLT_TYPE_OPERAFAILED, 5);
					}
				}
			}
		}  
    }    
}