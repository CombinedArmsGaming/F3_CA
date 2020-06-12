
#define FACTION NONE
#define SQUADS f_dict_squadmarkers

#define RED	        [0.9,0,0,1]
#define ORANGE      [1,0.5,0,1]
#define YELLOW      [1,1,0,1]
#define GREEN       [0,1,0,1]
#define BLUE        [0.2,0.2,1,1]
#define CYAN        [0,1,1,1]
#define MAGENTA     [1,0,1,1]
#define PINK	    [1,0.3,0.4,1]
#define PURPLE      [0.5,0,1,1]
#define WHITE       [1,1,1,1]
#define LIGHTGREY   [0.7,0.7,0.7,1]
#define DARKGREY    [0.3,0.3,0.3,1]
#define BLACK	    [0,0,0,1]
#define GREY	    [0.5,0.5,0.5,1]
#define BROWN	    [0.5,0.25,0,1]
#define KHAKI	    [0.5,0.6,0.4,1]

#define DEFAULT_COLOUR [0.999,1,1,1]


#define HELO        "res\images\squadMarkers\squad_air.paa"
#define ANTIAIR     "res\images\squadMarkers\squad_antiair.paa"
#define ANTITANK     "res\images\squadMarkers\squad_antitank.paa"
#define HEAVYANTITANK     "res\images\squadMarkers\squad_heavyantitank.paa"
#define ARMOR       "res\images\squadMarkers\squad_armor.paa"
#define ARTILLERY   "res\images\squadMarkers\squad_art.paa"
#define HEAVYWEAPONS "res\images\squadMarkers\squad_heavyweapons.paa"
#define HQ          "res\images\squadMarkers\squad_hq.paa"
#define INFANTRY    "res\images\squadMarkers\squad_inf.paa"
#define REPAIR      "res\images\squadMarkers\squad_maint.paa"
#define EOD      "res\images\squadMarkers\squad_eod.paa"
#define MECHINF     "res\images\squadMarkers\squad_mech_inf.paa"
#define MEDIC       "res\images\squadMarkers\squad_med.paa"
#define MORTAR      "res\images\squadMarkers\squad_mortar.paa"
#define MOTORINF    "res\images\squadMarkers\squad_motor_inf.paa"
#define NAVAL       "res\images\squadMarkers\squad_naval.paa"
#define PLANE       "res\images\squadMarkers\squad_plane.paa"
#define RECON       "res\images\squadMarkers\squad_recon.paa"
#define SUPPLY      "res\images\squadMarkers\squad_supply.paa"
#define SPECIALFORCES     "res\images\squadMarkers\squad_sf.paa"
#define UNKNOWN     "res\images\squadMarkers\squad_unknown.paa"

#define INIT_SQUADS() DICT_CREATE(SQUADS)

#define SQUAD_INDEX(NAME) (format ["%1_%2",#FACTION,#NAME])
#define SQUAD_INDEX_DYNAMIC(NAME,SIDE) (format ["%1_%2",SIDE,NAME])

#define SQUAD_VAR(NAME) DICT_GET(SQUADS,SQUAD_INDEX(NAME))
#define SQUAD_VAR_DYNAMIC(NAME,SIDE) DICT_GET(SQUADS,SQUAD_INDEX_DYNAMIC(NAME,SIDE))

#define NEW_SQUAD() [true,[],"","",[]]
#define MAKE_SQUAD_EDITABLE(NAME) DICT_SET(SQUADS,SQUAD_INDEX(NAME),NEW_SQUAD())
#define MAKE_SQUAD_EDITABLE_DYNAMIC(NAME,SIDE) DICT_SET(SQUADS,SQUAD_INDEX_DYNAMIC(NAME,SIDE),NEW_SQUAD())
#define IS_SQUAD_EDITABLE(NAME) DICT_CONTAINS(SQUADS,SQUAD_INDEX(NAME))
#define IS_SQUAD_EDITABLE_DYNAMIC(NAME,SIDE) DICT_CONTAINS(SQUADS,SQUAD_INDEX_DYNAMIC(NAME,SIDE))

#define SET_SQUAD_VISIBILITY(NAME,VISIBLE) (SQUAD_VAR(NAME)) set [0,VISIBLE]
#define HIDE_SQUAD(NAME) (SQUAD_VAR(NAME)) set [0,false]
#define UNHIDE_SQUAD(NAME) (SQUAD_VAR(NAME)) set [0,true]

#define SET_SQUAD_ICON(NAME,ICON) (SQUAD_VAR(NAME)) set [2,ICON]
#define SET_SQUAD_ICON_DYNAMIC(NAME,SIDE,ICON) (SQUAD_VAR_DYNAMIC(NAME,SIDE)) set [2,ICON]
#define SET_SQUAD_COLOUR(NAME,COLOUR) (SQUAD_VAR(NAME)) set [1,COLOUR]
#define SET_SQUAD_COLOUR_DYNAMIC(NAME,SIDE,COLOUR) (SQUAD_VAR_DYNAMIC(NAME,SIDE)) set [1,COLOUR]
#define SET_SQUAD_NAME(NAME,OVERRIDE) (SQUAD_VAR(NAME)) set [3,OVERRIDE]
#define SET_SQUAD_NAME_DYNAMIC(NAME,SIDE,OVERRIDE) (SQUAD_VAR_DYNAMIC(NAME,SIDE)) set [3,OVERRIDE]
#define ADD_SPECIAL_MARKER(NAME,UNIT) ((SQUAD_VAR(NAME)) select 4) pushBack UNIT
#define ADD_SPECIAL_MARKER_DYNAMIC(NAME,SIDE,UNIT) ((SQUAD_VAR_DYNAMIC(NAME,SIDE)) select 4) pushBack UNIT

#define SQUAD_VISIBLE(VAR) (VAR) select 0
#define SQUAD_COLOUR(VAR) (VAR) select 1
#define SQUAD_ICON(VAR) (VAR) select 2
#define SQUAD_NAME(VAR) (VAR) select 3
#define SQUAD_SPECIALS(VAR) (VAR) select 4
