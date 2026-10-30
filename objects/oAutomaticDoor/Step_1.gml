if !transition_started {
	if place_meeting(x, y, oPlayer) {
		transition_started = true;
		oPlayer.start_subarea_transition();
		oGameController.save_file.checkpoint.x_pos = transition_x;
		oGameController.save_file.checkpoint.y_pos = transition_y;
		room_transition(transition_room, tr_spotlight, 60);
	}
}