if checkpoint_x_pos == oGameController.save_file.checkpoint.x_pos && checkpoint_y_pos == oGameController.save_file.checkpoint.y_pos && room == oGameController.save_file.checkpoint.checkpoint_room {
	is_enabled = true;
} else {
	if place_meeting(x, y, oPlayer) {
		oGameController.save_file.checkpoint.x_pos = checkpoint_x_pos;
		oGameController.save_file.checkpoint.y_pos = checkpoint_y_pos;
		oGameController.save_file.checkpoint.checkpoint_room = room;
		is_enabled = true;
	} else {
		is_enabled = false;
	}
}