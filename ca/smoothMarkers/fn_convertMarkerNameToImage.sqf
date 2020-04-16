#include "macros.hpp"

params ["_iconName"];

switch (_iconName) do
{
    case "b_hq": {HQ};
    case "b_inf": {INFANTRY};
    case "b_support": {SUPPLY};
    case "b_motor_inf": {MOTORINF};
    case "b_mortar": {MORTAR};
    case "b_maint": {REPAIR};
    case "b_mech_inf": {MECHINF};
    case "b_armor": {ARMOR};
    case "b_recon": {RECON};
    case "b_air": {HELO};
    case "b_plane": {PLANE};
    case "b_art": {ARTILLERY};
    default {UNKNOWN};
}
