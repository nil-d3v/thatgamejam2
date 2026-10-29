is_enabled = false;

checkpoint_x_pos = x;
checkpoint_y_pos = y;

if checkpoint_x_pos == global.game_data.checkpoint.x_pos && checkpoint_y_pos == global.game_data.checkpoint.y_pos && room == global.game_data.checkpoint.checkpoint_room {
	is_enabled = true;
}