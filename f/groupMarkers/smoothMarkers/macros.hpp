// String-keyed dictionary convenience macros
#define DICT_CREATE(NAME) NAME = createLocation ["CBA_NamespaceDummy", [0,0,0], 0, 0]
#define DICT_CREATE_VALS(NAME,VALUES) DICT_CREATE(NAME); {NAME setVariable [_x select 0, _x select 1]} foreach VALUES
#define DICT_GET(NAME,KEY) NAME getVariable [KEY, []]
#define DICT_CONTAINS(NAME,KEY) !((NAME getVariable [KEY, "q£fsDSd4&&<"]) isEqualTo "q£fsDSd4&&<")
#define DICT_SET(NAME,KEY,VALUE) NAME setVariable [KEY, VALUE]
#define DICT_DELETE(NAME,KEY) NAME setVariable [KEY, nil]
#define DICT_REMOVE(NAME,KEY) DICT_DELETE(NAME,KEY)
#define DICT_FOREACH(NAME,FUNC) {private _key = _x; private _value = DICT_GET(NAME,_x); call _code;} forEach (allVariables NAME)

#define CLIENT_ONLY if (!hasInterface) exitWith {}
#define IS_TRUE(VAR) ((!isNil #VAR) and {VAR})
#define RUN_AS_ASYNC(FUNC) if (!canSuspend) exitWith { _this spawn FUNC }


#define WAIT_UNTIL_MISSION_STARTED() \
waitUntil                            \
{                                    \
    time > 0                         \
};


#define WAIT_UNTIL_PLAYER_EXISTS()  \
if (isNull player) then             \
{                                   \
    waitUntil                       \
    {                               \
        !isNull player              \
    };                              \
                                    \
}


#include "squadmarker_macros.hpp"
