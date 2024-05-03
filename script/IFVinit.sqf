I_ifv addEventHandler ["GetIn", {
	params ["_vehicle", "_role", "_unit", "_turret"];
	if (tolower _role isEqualTo "cargo") then {
		_unit spawn {
			sleep 60;
			while {!(isNull objectParent _this) && damage _this > 0} do {
				private _oldDamage = damage _this;
				private _damageDelta = 0.25;
				private _newDamage = (_oldDamage-_damageDelta) max 0;
				_this setDamage _newDamage;
				sleep 60;
			};
		};
	};
}];

I_ifv addBackpackCargo ["I_Fieldpack_oli_Repair",1];

(units I_grp_player) apply {
	if (_x in [I_ifvD, I_ifvG, I_ifvC]) then {
		_x assignTeam "GREEN";
		//_x moveInCargo I_ifv;
	} else {
		_x assignTeam "RED";
		_x assignAsCargo I_ifv;
	};
};