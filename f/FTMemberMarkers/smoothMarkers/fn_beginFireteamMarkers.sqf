
#include "macros.hpp"

WAIT_UNTIL_MISSION_STARTED();
WAIT_UNTIL_PLAYER_EXISTS();

[] call f_fnc_createFireteamMarkerHook;
