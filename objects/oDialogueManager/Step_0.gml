if (global.game_paused) {exit;};

if room == MainMenu {
	dialogue_active = false;
}

if dialogue_active {
	var _text = dialogue_text_array[dialogue_index];
	visible_chars += text_speed;
	visible_chars = min(visible_chars, string_length(_text));
	if instance_exists(oPlayer) ? oPlayer.dialogueKeyPressed : (keyboard_check_pressed(vk_return) || keyboard_check_pressed(ord("E")) || keyboard_check_pressed(ord("X")) || gamepad_button_check_pressed(0, gp_face3)) {
		if visible_chars < string_length(_text) {
			visible_chars = string_length(_text);
		} else {
			dialogue_index++;
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