if !dialogue_ongoing {
	player_on_range = point_distance(oPlayer.x, oPlayer.y, x, y) <= range;
	if player_on_range {
		oPlayer.player_dialogue_key_interacting = true;
	}
	player_available = oPlayer.onGround && oPlayer.movement_player_state == MovementPlayerState.CLASSIC;
	if player_on_range && player_available {
		if oPlayer.dialogueKeyPressed {
			oDialogueManager.start_dialogue(normal_to_gui_x(x), normal_to_gui_y(y), 360, 0, "Cool NPC", ["Hi", "I'm a *cool* NPC", "_what about you ?_"], function() {dialogue_ongoing = false;})
			dialogue_ongoing = true;
		}
	}
}