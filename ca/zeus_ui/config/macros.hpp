// ------------------------------------------------------------------------------------------------------------------------------------------------
//	COLOURS
// ------------------------------------------------------------------------------------------------------------------------------------------------

	#define MACRO_COLOUR_BACKGROUND                                         0.05, 0.05, 0.05, 0.5
	#define MACRO_COLOUR_BUTTON                                             0.0, 0.0, 0.0, 0.7

	#define MACRO_COLOUR_WHITE_OPAQUE                                       1, 1, 1, 1
	#define MACRO_COLOUR_WHITE_TEXT                                         1, 1, 1, 0.8
	#define MACRO_COLOUR_WHITE_SLIDER                                       1, 1, 1, 0.5
	#define MACRO_COLOUR_RED                                                1, 0, 0, 0.6
	#define MACRO_COLOUR_RED_DIM                                            1, 0, 0, 0.15
	#define MACRO_COLOUR_GREEN_DIM                                          0, 1, 0, 0.15





// ------------------------------------------------------------------------------------------------------------------------------------------------
//	IDCS
// ------------------------------------------------------------------------------------------------------------------------------------------------

	// Main UI
	#define MACRO_IDC_MAIN_CTRLGRP                                          1000
	#define MACRO_IDC_MAIN_DRAGGING_FRAME                                   1001
	#define MACRO_IDC_MAIN_CATEGORIES_LISTBOX                               1002
	#define MACRO_IDC_MAIN_UNITS_LISTBOX                                    1003
	#define MACRO_IDC_MAIN_PRESETS_LISTBOX                                  1004

	// Presets UI
	#define MACRO_IDC_PRESETS_CTRLGRP                                       2000
	#define MACRO_IDC_PRESETS_DUMMYCTRL                                     2001

	// Presets - Guerrilla AI
	#define MACRO_IDC_PRESETS_GAI_CHECKBOX                                  2100
	#define MACRO_IDC_PRESETS_GAI_SETTINGS_COVER                            2101
	#define MACRO_IDC_PRESETS_GAI_FLANKONLY_CHECKBOX                        2102
	#define MACRO_IDC_PRESETS_GAI_MAXAPPROACHVARIATION_SLIDER               2103
	#define MACRO_IDC_PRESETS_GAI_MAXAPPROACHVARIATION_TEXT                 2104
	#define MACRO_IDC_PRESETS_GAI_MINAPPROACHDISTANCE_SLIDER                2105
	#define MACRO_IDC_PRESETS_GAI_MINAPPROACHDISTANCE_TEXT                  2106
	#define MACRO_IDC_PRESETS_GAI_MAXAPPROACHDISTANCE_SLIDER                2107
	#define MACRO_IDC_PRESETS_GAI_MAXAPPROACHDISTANCE_TEXT                  2108
	#define MACRO_IDC_PRESETS_GAI_MAXSEARCHDURATION_SLIDER                  2109
	#define MACRO_IDC_PRESETS_GAI_MAXSEARCHDURATION_TEXT                    2110
	#define MACRO_IDC_PRESETS_GAI_SEARCHAREASIZE_SLIDER                     2111
	#define MACRO_IDC_PRESETS_GAI_SEARCHAREASIZE_TEXT                       2112

	// Presets - Suppressive AI
	#define MACRO_IDC_PRESETS_SAI_CHECKBOX                                  2200
	#define MACRO_IDC_PRESETS_SAI_SETTINGS_COVER                            2201
	#define MACRO_IDC_PRESETS_SAI_SUPPRESSIONMUL_SLIDER                     2202
	#define MACRO_IDC_PRESETS_SAI_SUPPRESSIONMUL_TEXT                       2203
	#define MACRO_IDC_PRESETS_SAI_SUPPRESSIONDURATIONMUL_SLIDER             2204
	#define MACRO_IDC_PRESETS_SAI_SUPPRESSIONDURATIONMUL_TEXT               2205
	#define MACRO_IDC_PRESETS_SAI_USEANIMS_CHECKBOX                         2206

	// Presets - Lambs AI
	#define MACRO_IDC_PRESETS_LAMBS_CHECKBOX                                2300
	#define MACRO_IDC_PRESETS_LAMBS_SETTINGS_COVER                          2301
	#define MACRO_IDC_PRESETS_LAMBS_REINFORCE_CHECKBOX                      2302

	// Presets - VCOM
	#define MACRO_IDC_PRESETS_VCOM_CHECKBOX                                 2400
	#define MACRO_IDC_PRESETS_VCOM_SETTINGS_COVER                           2401






// ------------------------------------------------------------------------------------------------------------------------------------------------
//	UI ELEMENT POSITIONING AND SCALING
// ------------------------------------------------------------------------------------------------------------------------------------------------

	// Main UI
	#define MACRO_POS_MAIN_WIDTH                                            0.12
	#define MACRO_POS_MAIN_HEIGHT                                           0.22

	#define MACRO_POS_MAIN_GAP_TEXT_Y                                       0.008
	#define MACRO_POS_MAIN_GAP_DRAGGING_Y                                   0.02

	// Presets UI
	#define MACRO_POS_PRESETS_WIDTH                                         0.25
	#define MACRO_POS_PRESETS_INDENT_X                                      0.01
	#define MACRO_POS_PRESETS_INDENT_SLIDER_X                               0.1

	// Other
	#define MACRO_POS_GAP_X                                                 0.002
	#define MACRO_POS_GAP_Y                                                 0.004
	#define MACRO_POS_TEXT_HEIGHT                                           0.016
	#define MACRO_POS_LISTBOX_HEIGHT                                        0.022
	#define MACRO_POS_CHECKBOX_WIDTH                                        0.013
	#define MACRO_POS_CHECKBOX_HEIGHT                                       0.022
	#define MACRO_POS_PRESETS_SETTING_HEIGHT                                0.02
	#define MACRO_POS_PRESETS_SETTING_GAP_Y                                 0.015
	#define MACRO_POS_TEXTBOX_WIDTH                                         0.025





// ------------------------------------------------------------------------------------------------------------------------------------------------
//	VARIABLE NAMES
// ------------------------------------------------------------------------------------------------------------------------------------------------

	// UI
	#define MACRO_VARNAME_UI_LISTSCOMPILED                                  "ca_zeusUI_listsCompiled"
	#define MACRO_VARNAME_UI_MAINCTRLGRP                                    "ca_zeusUI_mainCtrlGrp"
	#define MACRO_VARNAME_UI_PRESETSCTRLGRP                                 "ca_zeusUI_presetsCtrlGrp"
	#define MACRO_VARNAME_UI_CATEGORYINDEX                                  "ca_zeusUI_categoryIndex"
	#define MACRO_VARNAME_UI_UNITINDEX                                      "ca_zeusUI_unitIndex"
	#define MACRO_VARNAME_UI_PRESETINDEX                                    "ca_zeusUI_presetIndex"
	#define MACRO_VARNAME_UI_PRESETS_ISSHOWN                                "ca_zeusUI_presets_isShown"
	#define MACRO_VARNAME_UI_POS_MAINCTRLGRP                                "ca_zeusUI_pos_mainCtrlGrp"
	#define MACRO_VARNAME_UI_ACTIVESLIDER                                   "ca_zeusUI_activeCtrl"
	#define MACRO_VARNAME_UI_DRAW3D_EH                                      "ca_zeusUI_draw3D_EH"

	#define MACRO_VARNAME_UI_CHILDCONTROLS                                  "childControls"
	#define MACRO_VARNAME_UI_ISBEINGDRAGGED                                 "isBeingDragged"
	#define MACRO_VARNAME_UI_DRAGGING_EH                                    "draggingEH"
	#define MACRO_VARNAME_UI_DRAGGING_STOP_EH                               "draggingStopEH"
	#define MACRO_VARNAME_UI_MOUSEOFFSET                                    "mouseOffset"
	#define MACRO_VARNAME_UI_ID_MAIN                                        0
	#define MACRO_VARNAME_UI_ID_PRESETS                                     1
	#define MACRO_VARNAME_UI_SLIDER_CTRLFILL                                "ctrlFill"
	#define MACRO_VARNAME_UI_SLIDER_CTRLTEXTBOX                             "ctrlTextBox"
	#define MACRO_VARNAME_UI_SLIDER_CTRLSLIDER                              "ctrlSlider"
	#define MACRO_VARNAME_UI_SLIDER_MAXSIZE                                 "maxSize"
	#define MACRO_VARNAME_UI_SETTING_MIN                                    "min"
	#define MACRO_VARNAME_UI_SETTING_MAX                                    "max"

	// Custom Preset Settings
	#define MACRO_VARNAME_PRESET_GAI                                        "ca_zeusUI_preset_gAI"
	#define MACRO_VARNAME_PRESET_GAI_FLANKONLY                              "ca_zeusUI_preset_gAI_flankOnly"
	#define MACRO_VARNAME_PRESET_GAI_MAXAPPROACHVARIATION                   "ca_zeusUI_preset_gAI_maxApproachVariation"
	#define MACRO_VARNAME_PRESET_GAI_MINAPPROACHDISTANCE                    "ca_zeusUI_preset_gAI_maxApproachDistance"
	#define MACRO_VARNAME_PRESET_GAI_MAXAPPROACHDISTANCE                    "ca_zeusUI_preset_gAI_minApproachDistance"
	#define MACRO_VARNAME_PRESET_GAI_MAXSEARCHDURATION                      "ca_zeusUI_preset_gAI_maxSearchDuration"
	#define MACRO_VARNAME_PRESET_GAI_SEARCHAREASIZE                         "ca_zeusUI_preset_gAI_searchAreaSize"
	#define MACRO_VARNAME_PRESET_SAI                                        "ca_zeusUI_preset_sAI"
	#define MACRO_VARNAME_PRESET_SAI_SUPPRESSIONMUL                         "ca_zeusUI_preset_sAI_suppressionMul"
	#define MACRO_VARNAME_PRESET_SAI_SUPPRESSIONDURATIONMUL                 "ca_zeusUI_preset_sAI_suppressionDurationMul"
	#define MACRO_VARNAME_PRESET_SAI_USEANIMS                               "ca_zeusUI_preset_sAI_useAnims"
	#define MACRO_VARNAME_PRESET_VCOM                                       "ca_zeusUI_preset_VCOM"
	#define MACRO_VARNAME_PRESET_LAMBS                                      "ca_zeusUI_preset_Lambs"
	#define MACRO_VARNAME_PRESET_LAMBS_REINFORCE                            "ca_zeusUI_preset_Lambs_reinforce"

	// Namespaces
	#define MACRO_VARNAME_NAMESPACE_CATEGORIES                              "ca_zeusUI_categories"
	#define MACRO_VARNAME_NAMESPACE_PRESETS                                 "ca_zeusUI_presets"
	#define MACRO_VARNAME_NAMESPACE_ALLVARIABLES                            "allVariables"

	#define MACRO_VARNAME_CATEGORY_GEAR                                     "gear"
	#define MACRO_VARNAME_CATEGORY_SIDE                                     "side"

	#define MACRO_VARNAME_UNIT_ROLES                                        "roles"
	#define MACRO_VARNAME_UNIT_VEHICLE                                      "vehicle"

	// Third-party mods/scripts
	#define MACRO_VARNAME_LAMBS_NOAI                                        "lambs_danger_disableAI"		// Found at https://github.com/nk3nny/LambsDanger/wiki/variables
	#define MACRO_VARNAME_LAMBS_REINFORCE                                   "lambs_danger_enableGroupReinforce"	// Found at https://github.com/nk3nny/LambsDanger/wiki/variables
	#define MACRO_VARNAME_VCOM_NOAI                                         "Vcm_Disable"				// Found in "vcomai\Vcom\Functions\VcomAI_DefaultSettings.sqf"





// ------------------------------------------------------------------------------------------------------------------------------------------------
//	MACRO FUNCTIONS
// ------------------------------------------------------------------------------------------------------------------------------------------------

	#define CURLY(VARIABLE)                                                 {##VARIABLE##}
	#define SQUARE(VARIABLE)                                                [##VARIABLE##]
	#define STR(VARIABLE)                                                   #VARIABLE
