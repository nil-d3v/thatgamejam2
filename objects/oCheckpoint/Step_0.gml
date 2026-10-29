if checkpoint_x_pos == global.game_data.checkpoint.x_pos && checkpoint_y_pos == global.game_data.checkpoint.y_pos && room == global.game_data.checkpoint.checkpoint_room {
	is_enabled = true;
} else {
	if place_meeting(x, y, oPlayer) {
		global.game_data.checkpoint.x_pos = checkpoint_x_pos;
		global.game_data.checkpoint.y_pos = checkpoint_y_pos;
		global.game_data.checkpoint.checkpoint_room = room;
		is_enabled = true;
	} else {
		is_enabled = false;
	}
}