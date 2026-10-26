if dialogue_active {
	var _text = dialogue_text_array[dialogue_index];
	visible_chars += text_speed;
	visible_chars = min(visible_chars, string_length(_text));
	if oPlayer.dialogueKeyPressed {
		if visible_chars < string_length(_text) {
			visible_chars = string_length(_text);
		} else {
			dialogue_index++;
			if dialogue_index >= array_length(dialogue_text_array) {
				dialogue_active = false;
				oPlayer.main_player_state = MainPlayerState.NORMAL;
			} else {
				visible_chars = 0;
				set_dialogue_dimensions();
			}
		}
	}
}