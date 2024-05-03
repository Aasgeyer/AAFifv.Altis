
{
	private _center = markerPos _x;
	private _size = markerSize _x;
	private _angle = markerDir _x;
	//create Objective text marker
	private _textPos = _center getpos [selectmax _size, _angle+135];
	private _markerText = createMarker [format ["%1_t",_x], _textPos];
	_markerText setmarkerTypeLocal "mil_dot_noShadow";
	_markerText setmarkerColorLocal "ColorBlack";
	_markerText setmarkerTextLocal format ["Obj %1",[_foreachIndex+1] call BIS_fnc_phoneticalWord];
	_markerText setmarkerSize [0.01,0.01];

	//spawn enemy groups according to houses in the area
	private _houses = nearestObjects [_center, ["house"], selectmax _size];
	private _numberBuildingPos = 0;
	_houses apply {_numberBuildingPos = _numberBuildingPos + count (_x buildingPos -1);};
	private _group = 
		[["B_G_InfSquad_Assault","IRG_InfSquad","IRG_InfSquad_Weapons"],
		["B_G_InfTeam_Light","IRG_InfAssault","IRG_InfTeam","IRG_InfTeam_AT"]]
		select (_numberBuildingPos<12);
	private _groupCfg = configFile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> (selectrandom _group);
	private _objGrp = [_center, east, _groupCfg] call BIS_fnc_spawnGroup;
	[_objGrp,_objGrp,selectMax _size, 1] call CBA_fnc_taskDefend;
	_markerText setmarkerTextLocal format ["%1",markerText _markerText];

	//create Task for objective
	private _tskID = format ["Task_Obj_%1", _foreachIndex+1];
	private _tskDesc = format [
		'Seize Objective %1 at grid %2. Eliminate all enemy forces inside and outside of buildings. Expect around %3 enemies in the area.',
		[_foreachIndex+1] call BIS_fnc_phoneticalWord,
		mapGridPosition _center,
		count units _objGrp];
	private _tskTitle = format ['Seize Obj %1', [_foreachIndex+1, true] call BIS_fnc_phoneticalWord];
	private _tskDestination = _center;
	private _tskassignment = 'CREATED';//['CREATED','ASSIGNED'] select (_foreachIndex==0);
	private _tskPriority = count AAS_obj_markers - _foreachIndex;
	private _tskType = [_foreachIndex+1, true] call BIS_fnc_phoneticalWord;
	[independent, _tskID, [_tskDesc,_tskTitle,''], _tskDestination, _tskassignment, _tskPriority, false, _tskType] call BIS_fnc_taskCreate;

	//create Trigger for task completion
	private _trgStateActivation = format [
		"[%1, 'SUCCEEDED'] call BIS_fnc_taskSetState;
		AAS_objCleared = (missionNamespace getVariable ['AAS_objCleared',0]) + 1;
		_speakScript = ['objectives', 'AAF_ifv', ['Obj_%2_olymp','Obj_%2_%3'], 'SIDE'] spawn BIS_fnc_kbTell;
		", str _tskID, _foreachIndex+1, ["olymp","at"] select (_foreachIndex == 0)];
	private _objTrigger = [
		_center,
		"AREA:", (_size vectorMultiply 1.5) + [_angle, false],
		"ACT:", ["EAST SEIZED", "NOT PRESENT", false],
		"STATE:", [format ["this && missionNamespace getVariable ['AAS_objCleared',0] == %1", _foreachIndex], _trgStateActivation, ""]
		] call CBA_fnc_createTrigger;
	_objTrigger#0 setTriggerTimeout [30, 45, 60, true];
	missionNamespace setVariable [format ["AAS_ObjTrigger_%1", _foreachIndex+1], _objTrigger#0];
	
	//chance to spawn reinforcement group
	if (random 1 < 0.5) then {
		private _reinfTrigger = [
			_center,
			"AREA:", (_size vectorMultiply 4) + [_angle, false],
			"ACT:", ["GUER", "EAST D", false],
			"STATE:", ["this", "", ""]
			] call CBA_fnc_createTrigger;
		_reinfTrigger#0 setTriggerTimeout [10, 20, 30, false];
		private _group = 
		["B_G_InfSquad_Assault","IRG_InfSquad","IRG_InfSquad_Weapons",
		"B_G_InfTeam_Light","IRG_InfAssault","IRG_InfTeam","IRG_InfTeam_AT"];
		private _groupCfg = configFile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> (selectrandom _group);
		private _reinforcementPos = [[[_center, (selectmax _size)*3]], AAS_obj_markers, {_this getEnvSoundController "forest" > 0}] call BIS_fnc_randomPos;
		private _reinforcementGrp = [_reinforcementPos, east, _groupCfg] call BIS_fnc_spawnGroup;
		private _wp1 = [_reinforcementGrp, _reinforcementGrp, 0, "MOVE", "STEALTH", "WHITE", "NORMAL", "DIAMOND", ""] call CBA_fnc_addWaypoint;
		(_reinfTrigger#0) synchronizeWaypoint [_wp1];
		private _wp2 = [_reinforcementGrp, _center, 25, "SAD", "AWARE", "YELLOW", "NORMAL", "WEDGE"] call CBA_fnc_addWaypoint;
	};
} forEach AAS_obj_markers;

//create Phase line texts
AAS_PL_markers apply {
	private _angle = markerDir _x;
	private _halfSize = markerSize _x;
	private _PL_number = parseNumber (_x select [count _x - 1, 1]);

	//save game or end mission on PLs
	private _trg_PL = [objNull, _x] call BIS_fnc_triggerToMarker;
	_trg_PL setTriggerActivation ["ANYPLAYER", "PRESENT", false];
	private _trg_PL_activation = ["saveGame;", "[] call BIS_fnc_endMission;"] select (_x == AAS_PL_markers select -1);
	private _trg_PL_condition = ["this", format ["this && missionNamespace getVariable ['AAS_objCleared',0] == %1", count AAS_obj_markers]] select (_x == AAS_PL_markers select -1);
	_trg_PL setTriggerStatements [_trg_PL_condition, _trg_PL_activation, ""];
	if (_PL_number == 1) then {AAS_LDtrigger = _trg_PL;};

	//PL numbering
	for "_d" from 0 to 180 step 180 do {
		private _PL_textPos = markerpos _x getPos [selectMax _halfSize, _angle + _d];
		_PL_textMarker = createMarker [format ["mrk_PLtext_%1_%2",_PL_number, _d], _PL_textPos];
		_PL_textMarker setmarkerTypeLocal "mil_dot_noShadow";
		_PL_textMarker setmarkerColorLocal "ColorBlack";
		_PL_textMarker setmarkerTextLocal format ["PL %1", AAS_PL_names#(_PL_number - 1)];
		_PL_textMarker setmarkerSize [0.01,0.01];
	};
	//special PL
	for "_d" from 0 to 180 step 180 do {
		private _PL_textPos = markerpos _x getPos [selectMin _halfSize, _angle + 90];
		private _PL_textPos = _PL_textPos getPos [(selectMax _halfSize )* 0.75, _angle + _d];
		_PL_textMarker = createMarker [format ["mrk_PLtext2_%1_%2",_PL_number, _d], _PL_textPos];
		_PL_textMarker setmarkerTypeLocal "mil_dot_noShadow";
		_PL_textMarker setmarkerColorLocal "ColorBlack";
		_PL_textMarker setmarkerSize [0.01,0.01];
		private _PL_text = switch (_PL_number) do {
			case (1): {"LD"};
			case (count AAS_PL_markers): {"LOA"};
			default {""};
		};
		_PL_textMarker setmarkerText _PL_text;
	};
};

//set up AT positions
[AAS_atPositionMarkers, 0] spawn BIS_fnc_hideMarkerArray;
private _atPosMarker = selectRandom AAS_atPositionMarkers;
private _atGroupCfg = configFile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "IRG_InfTeam_AT";
private _atSpawnDir = markerDir _atPosMarker + 90;
private _atGroup = [markerPos _atPosMarker, east, _atGroupCfg,[],[],[],[],[],_atSpawnDir] call BIS_fnc_spawnGroup;
_atGroup setCombatMode "YELLOW";
_atGroup setbehaviourstrong "COMBAT";
private _atSoldier = units _atGroup select (units _atGroup findIf {!(secondaryWeapon _x isEqualTo "")});
_atSoldier removeWeapon secondaryWeapon _atSoldier;
clearMagazineCargo backpackContainer _atSoldier;
_atSoldier addWeapon "launch_I_Titan_short_F";
_atSoldier addSecondaryWeaponItem "Titan_AT";
for "_i" from 1 to 2 do {_atSoldier addItemToBackpack "Titan_AT";};
_atSoldier setVariable ["AAS_atMarker", _atPosMarker];
_atSoldier addEventHandler ["Fired", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
	if (_weapon isEqualTo secondaryWeapon _unit) then {
		private _atPosMarker = _unit getVariable "AAS_atMarker";
		_atPosMarker setMarkerAlpha 1;
		_atPosMarker setMarkerColor "colorOPFOR";
		hint format ["Enemy AT position at grid %1 revealed!", mapGridPosition markerpos _atPosMarker];
		_unit removeEventHandler [_thisEvent, _thisEventHandler];
	};
}];
private _atTriggerActivation = "
	_grp = thisTrigger getvariable 'AAS_triggerGroup';
	_grp reveal I_ifv;
	_unit = thisTrigger getvariable 'AAS_triggerATunit';
	_unit commandTarget I_ifv;
";
private _atTrigger = [
	markerpos _atPosMarker,
	"AREA:", [600,600, 0, false],
	"ACT:", ["GUER", "EAST D", false],
	"STATE:", ["this", _atTriggerActivation, ""]
	] call CBA_fnc_createTrigger;
_atTrigger#0 setTriggerTimeout [10, 20, 30, false];
_atTrigger#0 setVariable ["AAS_triggerGroup", _atGroup];
_atTrigger#0 setVariable ["AAS_triggerATunit", _atSoldier];

//create markers for the assembly area
private _markerAA = "marker_AA";
private _textPos = markerPos _markerAA getpos [selectmax markerSize _markerAA, markerDir _markerAA + 135];
private _markerText = createMarker [format ["%1_t",_markerAA], _textPos];
_markerText setmarkerTypeLocal "mil_dot_noShadow";
_markerText setmarkerColorLocal "ColorBlack";
_markerText setmarkerTextLocal "AA BLUE";
_markerText setmarkerSize [0.01,0.01];
private _textPos = markerPos _markerAA getpos [selectmax markerSize _markerAA * 1.25, markerDir _markerAA + 45];
private _markerText = createMarker [format ["%1_t2",_markerAA], _textPos];
_markerText setmarkerTypeLocal "n_hq";
_markerText setmarkerTextLocal "";
_markerText setmarkerSize [1,1];
private _markerText = createMarker [format ["%1_t3",_markerAA], _textPos];
_markerText setmarkerTypeLocal "group_3";
_markerText setmarkerTextLocal "";
_markerText setmarkerSize [1,1];
