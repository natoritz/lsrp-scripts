ListPlayerFines(playerid, targetid)
{
	mysql_format(dbCon, gquery, sizeof(gquery), "SELECT `ID`, `fineDate`, `fineAmount`, `fineReason` FROM `fines` WHERE `fineName` = '%e' AND `fineType` = '0'", ReturnName(targetid));
	mysql_tquery(dbCon, gquery, "ShowPlayerFines", "dd", playerid, targetid);
	return true;
}

PlacePlayerFine(playerid, copid, price, const reason[])
{
	new query[500];
	mysql_format(dbCon, query, sizeof(query), "INSERT INTO `fines` (`fineBy`, `fineName`, `fineAgency`, `fineAmount`, `fineReason`, `fineType`, `fineDate`, `fineExpire`) VALUES ('%e', '%e', '%e', '%d', '%e', '%d', '%e', '%d')", ReturnName(copid), ReturnName(playerid), Faction_GetName(copid), price, reason, 0, ReturnSiteDate(), gettime() + 259200);
	mysql_pquery(dbCon, query);
	return true;
}

FUNX::ShowPlayerFines(playerid, targetid)
{
	if(cache_num_rows())
	{
		new
			fineID,
			fineDate[60],
			fineAmount,
			fineReason[256]
		;

		format(gstr, sizeof(gstr), "{7e98b6}#\tDate and time\tFine\tReason\n");

		for(new i = 0, j = cache_num_rows(); i < j; ++i)
		{
			cache_get_value_name_int(0, "ID", fineID);
			cache_get_value_name(0, "fineDate", fineDate, 60);
			cache_get_value_name_int(0, "fineAmount", fineAmount);
			cache_get_value_name(0, "fineReason", fineReason, 256);

			format(gstr, sizeof(gstr), "%s{A9C4E4}%03d\t%s\t$%d\t%s\n", gstr, fineID, fineDate, fineAmount, fineReason);
		}

        Dialog_Show(playerid, Fines, DIALOG_STYLE_MSGBOX, "Fine list", gstr, "Close", "");
		return true;
	}
	else
	{
	    Dialog_Show(playerid, Fines, DIALOG_STYLE_MSGBOX, "Clean", "No fines found", "Close", "");
	}
	return true;
}