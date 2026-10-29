if !transition_started {
	if place_meeting(x, y, oPlayer) {
		oPlayer.player_dialogue_key_interacting = true;
		if oPlayer.dialogueKeyPressed {
			transition_started = true;
			oPlayer.start_subarea_transition();
			global.game_data.checkpoint.x_pos = transition_x;
			global.game_data.checkpoint.y_pos = transition_y;
			room_transition(transition_room, tr_spotlight, 60);
		}
	}
}