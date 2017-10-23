#include <iostream>

using namespace std;

extern "C"
{
#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"
}

int getInfo(lua_State *L)
{
	printf("[Main.cpp] %s\n",lua_tostring(L,-1));
	lua_pushstring(L, "love lua");
	return 1;
}

string Gettype(lua_State*L, int index)
{
	return lua_typename(L, lua_type(L, index));
}

int main(int argc, char**argv)
{
	lua_State*L = luaL_newstate();
	luaL_openlibs(L);

	lua_register(L, "getinfo", getInfo);

    if (0 != luaL_dofile(L, "main.lua"))
	{
		printf("%s", lua_tostring(L, -1));
	}

	lua_getglobal(L, "foo");
	if (lua_isfunction(L,-1))
	{
		printf("total count %d\n", lua_gettop(L));
		lua_pushnumber(L, 1);
		lua_pushstring(L, "lol");
		lua_pushboolean(L, 0);
		printf("total count %d\n", lua_gettop(L));
		if (lua_pcall(L,3,3,0)!=0)
		{
			printf("error:%s\n", lua_tostring(L,-1));
		}else
		{
			printf("total count now .. %d\n", lua_gettop(L));
			printf("return value type %s,%s,%s\n", Gettype(L,-1), Gettype(L, -2), Gettype(L, -3));
			printf("return value %d,%s,%f", lua_toboolean(L, -1), lua_tostring(L, -2), lua_tonumber(L, -3));
		}
	}

	return 0;
}

