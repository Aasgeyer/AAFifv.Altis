"<marker name='MARKER'>TEXT</marker>";
private _biefingText = "
<marker name='marker_AA_t2'>Olymp</marker> - Headquarters<br/>
<marker name='marker_alpha_1'>Alpha 1-1</marker> - Mechanized squad (your squad)<br/>
<marker name='marker_alpha_2'>Alpha 1-2</marker> - Infantry squad to the right<br/>
<marker name='marker_alpha_3'>Alpha 1-3</marker> - Infantry squad headed north<br/>
Kilo - UAV recon squad<br/>
<br/>
AA - Assembly Area; an area in which a command is assembled preparatory to further action.<br/>
LD - Line of Departure; line designated to coordinate the departure of attack elements<br/>
LOA - Limit of Advance; easily recognized terrain feature beyond which attacking elements will not advance. <br/>
OBJ - Objective Area; a defined geographical area within which is located an objective to be captured or reached by the military forces<br/>
PL - Phaseline; line utilized for control and coordination of military operations<br/>
";
player createDiaryRecord ["Diary", ["Signal", _biefingText], taskNull, "", false];

private _biefingText = format ["
1. Stage the assault in the <marker name='marker_AA'>Assembly Area</marker><br/>
2. Head to the <marker name='marker_PL_1'>Line of Departure</marker><br/>
3. Take the five Objectives <marker name='marker_obj_1'>Alpha</marker> to <marker name='marker_obj_5'>Echo</marker><br/>
4. Continue to the <marker name='marker_PL_3'>Limit of Advance</marker> and hold the position<br/>
<br/>
When utilizing the dismounted squad, focus on clearing buildings and difficult terrain.
They can also be effective in neutralizing anti-tank capabilities.
However, keep in mind that dismounted squads are more vulnerable and slower,
so it's advisable to engage in mounted combat whenever possible.<br/>
<br/>
Passengers of the Infantry Fighting Vehicle (IFV) will regenerate health while inside the vehicle.<br/>
You are capable of providing basic repairs to the vehicle. There is a backpack for that in the IFV.",
AAS_PL_names#1
];
player createDiaryRecord ["Diary", ["Execution", _biefingText], taskNull, "", false];

private _biefingText = "
Neutralize the enemy presence and seize the designated objectives!";
player createDiaryRecord ["Diary", ["Mission", _biefingText], taskNull, "", false];

private _biefingText = "
AAF is launching a counter insurgency operation, codename “Myrmidon”,
to reclaim a valley in the north east of Altis.
Your mechanized squad, <marker name='marker_AA_t2'>Alpha 1-1</marker>,
has been assigned to secure five key objectives in the valley near the village of Nidasos.
The enemy consists of a well-organized company of FIA insurgents in suspected section strength.
They have taken position in gatherings of buildings.
Reinforcements may hide close by in the forest.
Our mission is to neutralize their presence, secure the objectives,
and restore stability to the region.<br/>
Friendly forces are deployed in the Assembly Area west of Molos in platoon strength.
";
player createDiaryRecord ["Diary", ["Situation", _biefingText], taskNull, "", false];
