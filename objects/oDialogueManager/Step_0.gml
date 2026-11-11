if (global.game_paused) {exit;};

if room == MainMenu {
	dialogue_active = false;
}

if dialogue_active {
	var _text = dialogue_text_array[dialogue_index];
	var _previous_visible_chars = floor(visible_chars);

	visible_chars += text_speed;
	visible_chars = min(visible_chars, string_length(_text));

	var _current_visible_chars = floor(visible_chars);

	if (_current_visible_chars > _previous_visible_chars) {
	    text_sound_timer++;

	    if (text_sound_timer >= text_sound_interval) {
	        play_sfx(choose(zNPC1, zNPC2, zNPC3), 1, true, 0.7, 1.3, false);
	        text_sound_timer = 0;
	    }
	} else {
	    text_sound_timer = 0;
	}
	if instance_exists(oPlayer) ? oPlayer.dialogueKeyPressed : (keyboard_check_pressed(vk_return) || keyboard_check_pressed(ord("E")) || keyboard_check_pressed(ord("X")) || gamepad_button_check_pressed(0, gp_face3)) {
		if visible_chars < string_length(_text) {
			visible_chars = string_length(_text);
		} else {
			dialogue_index++;
			text_sound_timer = 0;
			if dialogue_index >= array_length(dialogue_text_array) {
				dialogue_active = false;
				if instance_exists(oPlayer) {
					oPlayer.main_player_state = MainPlayerState.NORMAL;
				}
				dialogue_callback();
			} else {
				visible_chars = 0;
				set_dialogue_dimensions();
			}
		}
	}
}