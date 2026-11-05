if !transition_started {
	if place_meeting(x, y, oPlayer) || place_meeting(x + (image_xscale * sprite_get_width(sprite_index)), y, oPlayer) || place_meeting(x - (image_xscale * sprite_get_width(sprite_index)), y, oPlayer) {
		if place_meeting(x, y, oPlayer) {
			draw_sprite_ext(sInputPromptKeyE, 0, x, y - image_yscale * sprite_get_height(sprite_index), 0.5, 0.5, 0, c_white, 1);
		} else {
			draw_sprite_ext(sInputPromptPoints, 0, x, y - image_yscale * sprite_get_height(sprite_index), 0.5, 0.5, 0, c_white, 1);
		}
	}
}