// Needed to stop error message appearing when holding control references in serializable context.

params ["_listIDC", "_name"];
disableSerialization;

_list = (findDisplay 312) displayCtrl _listIDC;
_list lbAdd _name;