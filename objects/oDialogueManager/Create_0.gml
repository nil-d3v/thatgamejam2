if instance_number(oDialogueManager) > 1 {
	instance_destroy();
}

// Preset Info
bubble_arrow_height = 10;
bubble_padding = 8;
namebox_padding = 4;

// Dialogue Info
dialogue_active = false;

dialogue_x = 0;
dialogue_y = 0;
dialogue_max_width = 0;
dialogue_width = 0;
dialogue_height = 0;
dialogue_style = 0; // 0 : speech / 1 : thought
dialogue_callback = undefined;

dialogue_character_name = "";
dialogue_text_array = [];
dialogue_index = 0;

visible_chars = 0;
text_speed = 0.5;

function start_dialogue(_xpos, _ypos, _max_width, _style, _character_name, _text_array, _callback) {
	dialogue_x = _xpos;
	dialogue_y = _ypos;
	dialogue_max_width = _max_width;
	dialogue_character_name = _character_name;
	dialogue_style = _style;
	dialogue_callback = _callback;

	dialogue_text_array = _text_array;
	dialogue_index = 0;
	visible_chars = 0;

	dialogue_active = true;
	
	oPlayer.main_player_state = MainPlayerState.DIALOGUE;
	
	set_dialogue_dimensions();
}

function set_dialogue_dimensions() {
	draw_set_font(fDialogueRegular);
	var _w = string_width_ext(dialogue_text_array[dialogue_index], -1, dialogue_max_width);
	var _h = string_height_ext(dialogue_text_array[dialogue_index], -1, dialogue_max_width);
	draw_set_font(-1);
	dialogue_width = _w + (bubble_padding * 2);
	dialogue_height = _h + (bubble_padding * 2) + bubble_arrow_height;
}

function measure_dialogue_word(_text, _start, _italic, _shaky) {
	var _width = 0;
	var _i = _start;
	var _length = string_length(_text);
	var _italic_state = _italic;
	var _shaky_state = _shaky;

	while (_i <= _length) {
		var _char = string_char_at(_text, _i);

		if (_char == "*" || _char == "_") {
			if (_char == "*") {
				_italic_state = !_italic_state;
			} else {
				_shaky_state = !_shaky_state;
			}

			_i++;
			continue;
		}

		if (_char == " " || _char == "\t" || _char == "\n") {
			break;
		}

		draw_set_font(_italic_state ? fDialogueItalic : fDialogueRegular);
		_width += string_width(_char);

		_i++;
	}

	return _width;
}


function build_dialogue_layout(_text, _x, _y, _max_width, _visible_chars) {
	var _commands = [];
	var _cursor_x = _x;
	var _cursor_y = _y;
	var _max_line_width = 0;
	var _line_height = max(
		string_height("Ay"),
		(string_width("Ay") > 0 ? 1 : 0)
	);

	draw_set_font(fDialogueRegular);
	_line_height = string_height("Ay");

	draw_set_font(fDialogueItalic);
	_line_height = max(_line_height, string_height("Ay"));

	var _italic = false;
	var _shaky = false;
	var _visible_count = 0;
	var _i = 1;
	var _length = string_length(_text);

	while (_i <= _length && _visible_count < _visible_chars) {
		var _char = string_char_at(_text, _i);

		if (_char == "*" || _char == "_") {
			if (_char == "*") {
				_italic = !_italic;
			} else {
				_shaky = !_shaky;
			}

			_i++;
			continue;
		}

		if (_char == "\n") {
			_max_line_width = max(_max_line_width, _cursor_x - _x);
			_cursor_x = _x;
			_cursor_y += _line_height;
			_i++;
			_visible_count++;
			continue;
		}

		if (_char != " " && _char != "\t") {
			var _word_width = measure_dialogue_word(
				_text, _i, _italic, _shaky
			);

			if (_cursor_x > _x && _cursor_x + _word_width > _x + _max_width) {
				_max_line_width = max(_max_line_width, _cursor_x - _x);
				_cursor_x = _x;
				_cursor_y += _line_height;
			}
		}

		draw_set_font(_italic ? fDialogueItalic : fDialogueRegular);

		var _char_width = string_width(_char);

		if (_char == " " || _char == "\t") {
			if (_cursor_x + _char_width > _x + _max_width) {
				_max_line_width = max(_max_line_width, _cursor_x - _x);
				_cursor_x = _x;
				_cursor_y += _line_height;
			} else {
				_cursor_x += _char_width;
			}

			_i++;
			_visible_count++;
			continue;
		}

		array_push(_commands, {
			char: _char,
			x: _cursor_x,
			y: _cursor_y,
			font: _italic ? fDialogueItalic : fDialogueRegular,
			shaky: _shaky
		});

		_cursor_x += _char_width;
		_visible_count++;
		_i++;
	}

	_max_line_width = max(_max_line_width, _cursor_x - _x);

	draw_set_font(-1);

	return {
		commands: _commands,
		width: _max_line_width,
		height: _cursor_y - _y + _line_height
	};
}