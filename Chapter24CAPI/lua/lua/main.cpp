#include <iostream>

using namespace std;

extern "C"
{
#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"
}

int main(int argc, char**argv)
{
	lua_State*L = luaL_newstate();
	luaL_openlibs(L);

	if (0 != luaL_dofile(L, "main.lua"))
	{
		printf("%s", lua_tostring(L, -1));
	}

	return 0;
}