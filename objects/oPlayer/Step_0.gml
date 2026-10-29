get_inputs();
update_status();

switch (main_player_state) {
	case MainPlayerState.NORMAL:
		player_update_movement();
		player_update_platform_movement()
		player_update_horizontal_control();
		player_update_vertical_control();
		round_speeds();
		player_update_horizontal_physics();
		player_update_vertical_physics();
		player_check_hazards();
		player_update_sprite();
	break;
	
	case MainPlayerState.DIALOGUE:
		// dialogue logic
		// not move
	break;
	
	case MainPlayerState.CUTSCENE:
		// cutscene logic
	break;
	
	case MainPlayerState.TRANSITION:
		if instance_exists(oRoomTransition) {
			if oRoomTransition.rmtr_steps == floor(oRoomTransition.rmtr_speed / 2) {
				x = global.game_data.checkpoint.x_pos;
				y = global.game_data.checkpoint.y_pos;
			}
			if oRoomTransition.rmtr_steps > oRoomTransition.rmtr_speed {
				main_player_state = MainPlayerState.NORMAL;
				init_tileset();
			}
		} else {
			main_player_state = MainPlayerState.NORMAL;
			init_tileset();
		}
	break;
	
	case MainPlayerState.DEAD:
		respawn_timer--;
		if respawn_timer <= 0 {
			x = global.game_data.checkpoint.x_pos;
			y = global.game_data.checkpoint.y_pos;
			main_player_state = MainPlayerState.NORMAL;
		}
	break;
}