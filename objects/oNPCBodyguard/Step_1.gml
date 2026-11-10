if (global.game_paused) {exit;};

dialogue_timer++
if !dialogue_ongoing && !dialogue_done && dialogue_timer >= 60 {
	oDialogueManager.start_dialogue(normal_to_gui_x(x), normal_to_gui_y(y), 360, 0, "Guard", ["Your *honor*, someone wishes to visit _you_"], function() {
		dialogue_ongoing = false;
		dialogue_done = true;
		oDialogueManager.start_dialogue(normal_to_gui_x(oNPCMayor.x), normal_to_gui_y(oNPCMayor.y), 360, 0, "Mayor", ["Come *in*"], function() {});
	});
	dialogue_ongoing = true;
}