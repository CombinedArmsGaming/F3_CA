
#include "macros.hpp"

WAIT_UNTIL_MISSION_STARTED();
WAIT_UNTIL_PLAYER_EXISTS();

[] call ca_fnc_createSquadMarkerHook;
[] call ca_fnc_initSquadMarkerManager;
