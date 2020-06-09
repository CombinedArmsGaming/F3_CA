params ["_target", "_impact", "_part", "_injuryIndex", "_injury", "_bandage"]; 
; 
_injury params ["_classID", "_bodyPartN"]; 
private _className = ace_medical_damage_woundClassNamesComplex select _classID; 
private _reopeningChance = 0.1; 
private _reopeningMinDelay = 120; 
private _reopeningMaxDelay = 200; 
private _config = configFile >> "ace_medical_treatment" >> "Bandaging"; 
if (isClass (_config >> _bandage)) then { 
_config = _config >> _bandage; 
_reopeningChance = getNumber (_config >> "reopeningChance"); 
_reopeningMinDelay = getNumber (_config >> "reopeningMinDelay"); 
_reopeningMaxDelay = getNumber (_config >> "reopeningMaxDelay") max _reopeningMinDelay; 
} else { 
diag_log text format ['[%1] (%2) %3: %4', toUpper 'ace', 'medical_treatment', 'WARNING', format["No config for bandage [%1] config base [%2]",  _bandage,  _config]]; 
}; 
if (isClass (_config >> _className)) then { 
private _woundTreatmentConfig = _config >> _className; 
if (isNumber (_woundTreatmentConfig >> "reopeningChance")) then { 
_reopeningChance = getNumber (_woundTreatmentConfig >> "reopeningChance"); 
_reopeningChance = _reopeningChance * 500; 
}; 
if (isNumber (_woundTreatmentConfig >> "reopeningMinDelay")) then { 
_reopeningMinDelay = getNumber (_woundTreatmentConfig >> "reopeningMinDelay"); 
}; 
if (isNumber (_woundTreatmentConfig >> "reopeningMaxDelay")) then { 
_reopeningMaxDelay = getNumber (_woundTreatmentConfig >> "reopeningMaxDelay") max _reopeningMinDelay; 
}; 
} else { 
diag_log text format ['[%1] (%2) %3: %4', toUpper 'ace', 'medical_treatment', 'WARNING', format["No config for wound type [%1] config base [%2]",  _className,  _config]]; 
}; 
; 
private _bandagedWounds = (_target getVariable ["ace_medical_bandagedWounds", []]); 
private _exist = false; 
{ 
_x params ["_id", "_partN", "_amountOf"]; 
if (_id == _classID && {_partN == _bodyPartN}) exitWith { 
_x set [2, _amountOf + _impact]; 
; 
_exist = true; 
}; 
} forEach _bandagedWounds; 
if (!_exist) then { 
; 
private _bandagedInjury = +_injury; 
_bandagedInjury set [2, _impact]; 
_bandagedWounds pushBack _bandagedInjury; 
}; 
_target setVariable ["ace_medical_bandagedWounds", _bandagedWounds, true]; 
; 
_reopeningChance = _reopeningChance * .5;
if (random 1 <= _reopeningChance) then { 
private _delay = _reopeningMinDelay + random (_reopeningMaxDelay - _reopeningMinDelay); 
; 
[{ 
params ["_target", "_impact", "_part", "_injuryIndex", "_injury"]; 
; 
private _openWounds = (_target getVariable ["ace_medical_openWounds", []]); 
if (count _openWounds - 1 < _injuryIndex) exitWith { ; }; 
_injury params ["_classID", "_bodyPartN"]; 
private _selectedInjury = _openWounds select _injuryIndex; 
_selectedInjury params ["_selClassID", "_selBodyPart", "_selAmmount"]; 
if ((_selClassID == _classID) && {_selBodyPart == _bodyPartN}) then {  
private _bandagedWounds = (_target getVariable ["ace_medical_bandagedWounds", []]); 
private _exist = false; 
{ 
_x params ["_id", "_partN", "_amountOf"]; 
if ((_id == _classID) && {_partN == _bodyPartN}) exitWith { 
; 
_x set [2, 0 max (_amountOf - _impact)]; 
_exist = true; 
}; 
} forEach _bandagedWounds; 
if (_exist) then { 
; 
_selectedInjury set [2, _selAmmount + _impact]; 
_target setVariable ["ace_medical_bandagedWounds", _bandagedWounds, true]; 
_target setVariable ["ace_medical_openWounds", _openWounds, true]; 
[_target] call ace_medical_status_fnc_updateWoundBloodLoss; 
if ((ace_medical_limping == 1) && {_bodyPartN > 3}) then { 
[_target] call ace_medical_engine_fnc_updateDamageEffects; 
}; 
}; 
} else { 
; 
}; 
}, [_target, _impact, _part, _injuryIndex, +_injury], _delay] call CBA_fnc_waitAndExecute; 
}; 