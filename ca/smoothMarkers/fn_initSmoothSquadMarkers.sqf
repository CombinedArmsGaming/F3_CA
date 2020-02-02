#include "macros.hpp"

CLIENT_ONLY;

INIT_SQUADS();

if (IS_TRUE(f_var_smoothMarkers)) then
{
    [] call ca_fnc_beginSquadMarkers;
};
