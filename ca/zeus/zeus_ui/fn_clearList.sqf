// Needed to stop error message appearing when holding control references in serializable context.

params ["_listIDC"];
disableSerialization;

_list = (findDisplay 312) displayCtrl _listIDC;
lbClear _list;