#include "macros.hpp"

params ["_iconName"];

switch (_iconName) do
{
    case "b_hq": {HQ};
    case "b_inf": {INFANTRY};
    case "b_sf": {SPECIALFORCES};
    case "b_supply": {SUPPLY};
    case "b_motor_inf": {MOTORINF};
    case "b_mortar": {MORTAR};
    case "b_maint": {REPAIR};
    case "b_eod": {EOD};
    case "b_med": {MEDIC};
    case "b_mech_inf": {MECHINF};
    case "b_armor": {ARMOR};
    case "b_recon": {RECON};
    case "b_air": {HELO};
    case "b_plane": {PLANE};
    case "b_art": {ARTILLERY};
    case "b_naval": {NAVAL};
    case "b_antiair": {ANTIAIR};
    case "b_antitank": {ANTITANK};
    case "b_heavyantitank": {HEAVYANTITANK};
    case "b_heavyweapons": {HEAVYWEAPONS};
  default {UNKNOWN};
}
