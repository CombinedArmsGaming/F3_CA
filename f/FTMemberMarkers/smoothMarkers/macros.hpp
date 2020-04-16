#define CLIENT_ONLY if (!hasInterface) exitWith {}
#define IS_TRUE(VAR) ((!isNil #VAR) and {VAR})


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
