class CfgCommunicationMenu
{
	class uavRecon
	{
		text = "UAV Recon";		// Text displayed in the menu and in a notification
		submenu = "";					// Submenu opened upon activation (expression is ignored when submenu is not empty.)
		expression = "[caller, pos, target, is3D, id] call AAS_fnc_supportRequest;";	// Code executed upon activation
		icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\call_ca.paa";				// Icon displayed permanently next to the command menu
		cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";				// Custom cursor displayed when the item is selected
		enable = "1";					// Simple expression condition for enabling the item
		removeAfterExpressionCall = 1;	// 1 to remove the item after calling
	};
};