is_enabled = false;

checkpoint_x_pos = x;
checkpoint_y_pos = y;

if checkpoint_x_pos == oGameController.save_file.checkpoint.x_pos && checkpoint_y_pos == oGameController.save_file.checkpoint.y_pos && room == oGameController.save_file.checkpoint.checkpoint_room {
	is_enabled = true;
}