if (global.game_paused || room == SplashScreen || room == MainMenu || room == EndScreen) {exit;};

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
		player_check_stars();
		player_update_sprite();
	break;
	
	case MainPlayerState.DIALOGUE:
		sprite_index = sPlayerIdle;
	break;
	
	case MainPlayerState.CUTSCENE:
		// cutscene logic
	break;
	
	case MainPlayerState.TRANSITION:
		if instance_exists(oRoomTransition) {
			if oRoomTransition.rmtr_steps == floor(oRoomTransition.rmtr_speed / 2) {
				x = oGameController.save_file.checkpoint.x_pos;
				y = oGameController.save_file.checkpoint.y_pos;
			}
			if oRoomTransition.rmtr_steps > oRoomTransition.rmtr_speed {
				main_player_state = MainPlayerState.NORMAL;
			}
		} else {
			main_player_state = MainPlayerState.NORMAL;
		}
	break;
	
	case MainPlayerState.DEAD:
		respawn_timer--;
		if respawn_timer <= 0 {
			// Restore all broken blocks
			for (i = 0; i < instance_number(oBreakableBlock); i++) {
				var _inst = instance_find(oBreakableBlock, i);
				_inst.broken = false;
				_inst.sprite_index = _inst.base_sprite;
			}
			
			// Respawn
			x = oGameController.save_file.checkpoint.x_pos;
			y = oGameController.save_file.checkpoint.y_pos;
			main_player_state = MainPlayerState.NORMAL;
		}
	break;
}

oGameController.save_file.stats.timer++;

dialogue_game_start_timer++
if !oGameController.save_file.intro_dialogue_done && dialogue_game_start_timer == 60 {
	oDialogueManager.start_dialogue(normal_to_gui_x(x), normal_to_gui_y(y - dialogue_y_offset), 360, 0, "Me", ["The stars are *lost*", "I _need_ to find them!", "...What's this note doing here?", "It talks about using _A_ and _D_ to _move_ and _W_ to _jump_??", "*Weird*."], function() {});
}
if !oGameController.save_file.intro_dialogue_done && room == RoomAurelia {
	dialogue_exit_room_timer++;
}
if !oGameController.save_file.intro_dialogue_done && dialogue_exit_room_timer == 60 {
	oDialogueManager.start_dialogue(normal_to_gui_x(x), normal_to_gui_y(y - dialogue_y_offset), 360, 0, "Me", ["The same note talks about using _S_ to fall *down*", "What's with all of these _letters_?"], function() {oGameController.save_file.intro_dialogue_done = true;});
}
if room == SubareaHouse6 && !collected_valley_note {
	collected_valley_note = true;
	oDialogueManager.start_dialogue(normal_to_gui_x(x), normal_to_gui_y(y - dialogue_y_offset), 360, 0, "Me", ["There we _go_! I *found* it."], function() {});
}
if room == RoomTomb && !talked_at_fall && place_meeting(x, y, oTrigger) {
	oDialogueManager.start_dialogue(normal_to_gui_x(x), normal_to_gui_y(y - dialogue_y_offset), 360, 0, "Me", ["Aaaah. Am I _alive_?", "*Where* am _I_?", "There are so many *carvings* on the _walls_..."], function() {});
	talked_at_fall = true;
}
if room == RoomTomb && !talked_at_tomb_star && place_meeting(x, y, oTrigger_1) {
	oDialogueManager.start_dialogue(normal_to_gui_x(x), normal_to_gui_y(y - dialogue_y_offset), 360, 0, "Me", ["Now, how do _I_ get up...", "Looks like there is a path to _somewhere_.", "I *guess* I should _follow_ it"], function() {});
	talked_at_tomb_star = true;
}