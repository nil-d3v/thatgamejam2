get_inputs();
update_status();

switch (main_player_state) {
	case MainPlayerState.NORMAL:
		player_update_movement();
		player_update_horizontal_control();
		player_update_vertical_control();
		player_update_horizontal_physics();
		player_update_vertical_physics();
		player_update_sprite();
	break;
	
	case MainPlayerState.DIALOGUE:
		// dialogue logic
		// not move
	break;
	
	case MainPlayerState.CUTSCENE:
		// cutscene logic
	break;
	
	case MainPlayerState.DEAD:
		// death anim
	break;
}