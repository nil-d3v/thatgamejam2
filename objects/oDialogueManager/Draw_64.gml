if (dialogue_active) {
	var _text = dialogue_text_array[dialogue_index];
	var _text_x = dialogue_x + bubble_padding;
	var _text_y = dialogue_y - dialogue_height + bubble_padding;
	var _layout = build_dialogue_layout(_text, _text_x, _text_y, dialogue_max_width, floor(visible_chars));

	dialogue_width = _layout.width + bubble_padding * 2;
	dialogue_height = _layout.height + bubble_padding * 2 + bubble_arrow_height;

	// Bubble
	draw_sprite_ext(dialogue_style == 0 ? sDialogueBubbleSpeech : sDialogueBubbleThought, 0, dialogue_x, dialogue_y, dialogue_width / sprite_get_width(sDialogueBubbleSpeech), dialogue_height / sprite_get_height(sDialogueBubbleSpeech), 0, c_white, 1);
	
	// Name
	draw_set_font(fDialogueNameBox);
	var _namebox_x = dialogue_x + 6;
	var _namebox_y = dialogue_y - dialogue_height + 4;
	var _namebox_width = string_width(dialogue_character_name) + (namebox_padding * 2);
	var _namebox_height = string_height(dialogue_character_name) + (namebox_padding * 2);
	draw_sprite_ext(sDialogueNameBox, 0, _namebox_x, _namebox_y, _namebox_width / sprite_get_width(sDialogueNameBox), _namebox_height / sprite_get_height(sDialogueNameBox), 0, c_white, 1);
	draw_text(_namebox_x + namebox_padding, _namebox_y - _namebox_height + namebox_padding, dialogue_character_name)
	draw_set_font(-1);

	// Input Prompt
	if visible_chars >= string_length(_text) {
		var _input_prompt_x = dialogue_x + dialogue_width;
		var _input_prompt_y = dialogue_y - bubble_arrow_height;
		draw_sprite(sKeyboardInviteE, 0, _input_prompt_x, _input_prompt_y);
	}

	// Text
	draw_set_color(c_black);
	for (var i = 0; i < array_length(_layout.commands); i++) {
		var _command = _layout.commands[i];
		draw_set_font(_command.font);
		var _offset_x = 0;
		var _offset_y = 0;
		if (_command.shaky) {
			_offset_x = irandom_range(-1, 1);
			_offset_y = irandom_range(-1, 1);
		}
		draw_text(_command.x + _offset_x, _command.y + _offset_y, _command.char);
	}
	draw_set_font(-1);
	draw_set_color(c_white);
}
