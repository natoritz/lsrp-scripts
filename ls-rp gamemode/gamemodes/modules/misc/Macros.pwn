#define FUNX::%0(%1) forward %0(%1); public %0(%1)

#if defined _ALS_GetPlayerSkin
   #undef GetPlayerSkin
#else

#define _ALS_GetPlayerSkin
   #endif
#define GetPlayerSkin GetPlayerSkinEx

#define GetDynamicObjectModel(%0) Streamer_GetIntData(STREAMER_TYPE_OBJECT, %0, E_STREAMER_MODEL_ID)

#define AC_COOLDOWN (10)

#define MAX_MSG_LENGTH	(144)

#define Pressed(%0)	\
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

#define Holding(%0) \
	((newkeys & (%0)) == (%0))

#define Released(%0) \
	(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))
	
native gpci(playerid, serial[], len);
native IsValidVehicle(vehicleid);
