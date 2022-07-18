#define SERVER_SITE "legacy-rp.net"
#define SERVER_MODE "L:RP 10.9.8"

#if IS_LOCAL_HOST == true
	#define SERVER_NAME "[0.3-DL] Legacy Roleplay | Development Server"
	#define SQL_HOSTNAME "localhost"
	#define SQL_USERNAME "root"
	#define SQL_DATABASE "roleplay"
	#define SQL_PASSWORD ""
#else
	#define SERVER_NAME "[0.3-DL] Legacy Roleplay | legacy-rp.net"
	#define SQL_HOSTNAME "localhost"
	#define SQL_USERNAME "root"
	#define SQL_DATABASE "roleplay"
	#define SQL_PASSWORD ""
#endif

#define MAX_CHARACTERS (6)

new
	modelsURL[] = "",
	RegistrationEnabled = false,
	MySQL:dbCon
;
