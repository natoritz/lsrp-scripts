#define MAX_CLIENT_MSG_LENGTH (144)
#define MAX_FUNC_NAME (32)

#define CMD:%1(%2)          \
			forward cmd_%1(%2); \
			public cmd_%1(%2)

#define CMD_SUCCESS 1
#define CMD_FAILURE 0

#if defined OnPlayerCommandReceived
	forward OnPlayerCommandReceived(playerid, cmdtext[]);
#endif

#if defined OnPlayerCommandPerformed
	forward OnPlayerCommandPerformed(playerid, cmdtext[], success);
#endif

public OnPlayerCommandText(playerid, cmdtext[])
{
	static funcname[MAX_CLIENT_MSG_LENGTH] = "cmd_";

	new pos = 1, tmp;

	while((tmp = cmdtext[pos]) > ' ')
		if('A' <= tmp <= 'Z') funcname[pos++ + 3] = tmp | 0x20;
		else funcname[pos++ + 3] = tmp;

	funcname[pos + 3] = 0;

	while (cmdtext[pos] == ' ') pos++;
	
	if(cmdtext[pos])
	{
	  	#if defined OnPlayerCommandPerformed
			return OnPlayerCommandPerformed(playerid, cmdtext, CallLocalFunction(funcname, "is", playerid, cmdtext[pos]));
		#else
			return CallLocalFunction(funcname, "is", playerid, cmdtext[pos]);
		#endif
	}
	else
	{
		#if defined OnPlayerCommandPerformed
			return OnPlayerCommandPerformed(playerid, cmdtext, CallLocalFunction(funcname, "is", playerid, "\1"));
		#else
			return CallLocalFunction(funcname, "is", playerid, "\1");
		#endif
	}
}