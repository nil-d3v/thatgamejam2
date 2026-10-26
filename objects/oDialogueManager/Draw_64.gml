if (dialogue_active) {
	var _text = dialogue_text_array[dialogue_index];

	var _text_x = dialogue_x + bubble_padding;
	var _text_y = dialogue_y - dialogue_height + bubble_padding;

	var _layout = build_dialogue_layout(_text, _text_x, _text_y, dialogue_max_width, floor(visible_chars));

	dialogue_width = _layout.width + bubble_padding * 2;
	dialogue_height = _layout.height + bubble_padding * 2 + bubble_arrow_height;

	// Bubble
	draw_sprite_ext(sDialogueBubble, 0, dialogue_x, dialogue_y, dialogue_width / sprite_get_width(sDialogueBubble), dialogue_height / sprite_get_height(sDialogueBubble), 0, c_white, 1);

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
