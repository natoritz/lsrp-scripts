//Custom skin support Include RogueDrifter 2018-1-13
GetPlayerSkinEx(playerid)
   return (GetPlayerCustomSkin(playerid) <= 0) ? GetPlayerSkin(playerid) : GetPlayerCustomSkin(playerid);
  
#if defined _ALS_GetPlayerSkin 
   #undef GetPlayerSkin 
#else
#define _ALS_GetPlayerSkin
   #endif
#define GetPlayerSkin GetPlayerSkinEx