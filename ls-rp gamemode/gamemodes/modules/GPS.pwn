#include <GPS>
#include <player-gangzones>

// Defines 

#define MAX_DOTS           (300)
#define GPS_ERROR_NODE      (0)

// Variables

enum E_GPS_DATA
{
    bool:gpsEnabled,
    Float:gpsCoordinates[3]
};

static GPS_DATA[MAX_PLAYERS][E_GPS_DATA];
static Routes[MAX_PLAYERS][MAX_DOTS];

// Functions

hook OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
    GPS_DATA[playerid][gpsEnabled] = true;
    GPS_DATA[playerid][gpsCoordinates][0] = fX;
    GPS_DATA[playerid][gpsCoordinates][1] = fY;
    GPS_DATA[playerid][gpsCoordinates][2] = fZ;

    SetPlayerPath(playerid, fX, fY, fZ);

    SendClientMessage(playerid, COLOR_GRAD2, "GPS waypoint set.");
    return true;
}

stock Float:GDBP(Float:X2, Float:Y2, Float:Z2, Float: PointX, Float: PointY, Float: PointZ)
{
	return floatsqroot(floatadd(floatadd(floatpower(floatsub(X2, PointX), 2.0), floatpower(floatsub(Y2, PointY), 2.0)), floatpower(floatsub(Z2, PointZ), 2.0)));
}

stock HasWaypointSet(playerid)
{
    return GPS_DATA[playerid][gpsEnabled];
}

stock UpdateWaypoint(playerid)
{
    return SetPlayerPath(playerid, GPS_DATA[playerid][gpsCoordinates][0], GPS_DATA[playerid][gpsCoordinates][1], GPS_DATA[playerid][gpsCoordinates][2]);
}

stock CreateMapRoute(playerid, Float:X1, Float:Y1, Float:X2, Float:Y2, color)
{
	new 
		Float: Dis = 4, 
		Float: TotalDis = GDBP(X1, Y1, 0.0, X2, Y2, 0.0), 
		Points = floatround(TotalDis / Dis)
	;

	for(new i = 1; i <= Points; ++i)
	{
		new Float: x, Float: y;

		if(i != 0)
		{
			x = X1 + (((X2 - X1) / Points) * i);
			y = Y1 + (((Y2 - Y1) / Points) * i);
		}
		else
		{
			x = X1;
			y = Y1;
		}

		new slot = 0;

		while(slot <= MAX_DOTS)
		{
			if(slot == MAX_DOTS)
			{
				slot = -1;
				break;
			}

			if(Routes[playerid][slot] == -1)
			{
				break;
			}
			slot++;
		}

		if(slot == -1) return;

		Routes[playerid][slot] = PlayerGangZoneCreate(playerid, x-(Dis / 2)-2.5, y-(Dis / 2)-2.5, x+(Dis / 2)+2.5, y+(Dis / 2)+2.5);
		PlayerGangZoneShow(playerid, Routes[playerid][slot], color);
	}
}

stock DestroyRoutes(playerid)
{
	for(new x; x < MAX_DOTS; ++x)
	{
		if(Routes[playerid][x] != -1)
		{
		    PlayerGangZoneDestroy(playerid, Routes[playerid][x]);
		    Routes[playerid][x] = -1;
		}
	}
}

stock ForcePlayerEndLastRoute(playerid)
{
	GPS_DATA[playerid][gpsEnabled] = false;
	DestroyRoutes(playerid);
	DisablePlayerCheckpoint(playerid);
}

stock SetPlayerPath(playerid, Float:X2, Float:Y2, Float:Z2)
{
	new Float:x, Float:y, Float:z, MapNode:start, MapNode:target;
    GetPlayerPos(playerid, x, y, z);

	if((GDBP(X2, Y2, 0.0, x, y, 0.0) <= 7.5))
	{
		SendClientMessage(playerid, COLOR_GRAD2, "You have reached your destination.");
		ForcePlayerEndLastRoute(playerid);
		return true;
	}

    if(GetClosestMapNodeToPoint(x, y, z, start) != 0) return print("Error [G01].");
    if(GetClosestMapNodeToPoint(X2, Y2, Z2, target)) return print("Error [G02].");

    if(FindPathThreaded(start, target, "OnPathFound", "i", playerid))
    {
    	SendClientMessage(playerid, -1, "There was an error while the GPS was starting.");
    	return true;
    }
    return true;
}

FUNX::OnPathFound(Path:pathid, playerid)
{
    if(!IsValidPath(pathid)) return SendErrorMessage(playerid, "Error [G03].");

    DestroyRoutes(playerid);

    new size, Float:length;
    GetPathSize(pathid, size);
    GetPathLength(pathid, length);
    
    if(size == 1)
    {
    	ForcePlayerEndLastRoute(playerid);
		return SendClientMessage(playerid, COLOR_ORANGE, "You have reached your destination.");
    }
    
	new MapNode:nodeid, index, Float:lastx, Float:lasty,Float:lastz;
	GetPlayerPos(playerid, lastx, lasty, lastz);
	GetClosestMapNodeToPoint(lastx, lasty, lastz, nodeid);
	GetMapNodePos(nodeid, lastx, lasty, lastz);

	new _max = MAX_DOTS, firstpos = 1;
	if(MAX_DOTS > size) _max = size;

	new Float:X,Float:Y,Float:Z,
	Float:PX, Float:PY, Float:PZ;
	GetPlayerPos(playerid, PX, PY, PZ);

	for(new i = 0; i < _max; ++i)
	{
		GetPathNode(pathid, i, nodeid);
		GetPathNodeIndex(pathid, nodeid, index);
		GetMapNodePos(nodeid, X, Y, Z);
		if(firstpos) // to connect the path with the player's position
		{
		    CreateMapRoute(playerid, PX, PY, X, Y, COLOR_GPS);
		    firstpos = 0;
		}
		else
		{
			if(i == index) CreateMapRoute(playerid, lastx, lasty, X, Y, COLOR_GPS);
			lastx = X + 0.1;
			lasty = Y + 0.1;
		}
	}

    DestroyPath(pathid);
    return true;
}