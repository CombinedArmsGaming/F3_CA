/*
 * Author: Poulern
 * Set default values for the parameters and then set the correct ones after postinit(Or at least thats the idea)
 *
 *
 */
if (!isServer) exitwith {};
missionNamespace setVariable ["ca_defaultside",east, true];
missionNamespace setVariable ["ca_hcshowmarkers",false, true];
missionNamespace setVariable ["ca_deletevehicles",false, true];

switch (ca_param_defaultside) do {
  case (0): {
    missionNamespace setVariable ["ca_defaultside",west, true];
  };
  case (1): {
    missionNamespace setVariable ["ca_defaultside",east, true];
  };
  case (2): {
    missionNamespace setVariable ["ca_defaultside",independent, true];
  };
};
switch (ca_param_hcshowmarkers) do {
  case (0): {
    missionNamespace setVariable ["ca_hcshowmarkers",false, true];
  };
  case (1): {
    missionNamespace setVariable ["ca_hcshowmarkers",true, true];
  };
};
switch (ca_param_bodymanage) do {
  case (0): {
    missionNamespace setVariable ['ca_bodymanageon',false, true];
  };
  case (1): {
    missionNamespace setVariable ['ca_bodymanageon',true, true];
    [] spawn ca_fnc_bodymanage;
  };
};
