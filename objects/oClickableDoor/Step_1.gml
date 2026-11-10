if (global.game_paused) {exit;};

if !transition_started {
	if place_meeting(x, y, oPlayer) {
		oPlayer.player_dialogue_key_interacting = true;
		if oPlayer.dialogueKeyPressed {
			transition_started = true;
			oPlayer.start_subarea_transition();
			if (transition_room != EndScreen) {
			    oGameController.save_file.checkpoint.x_pos = transition_x;
			    oGameController.save_file.checkpoint.y_pos = transition_y;
			    oGameController.save_file.checkpoint.checkpoint_room = transition_room;
			    oGameController.Save();
			}
			room_transition(transition_room, tr_spotlight, 60);
		}
	}
}