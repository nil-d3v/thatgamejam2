var _offset_x = lengthdir_x(ground_offset, image_angle - 90);
var _offset_y = lengthdir_y(ground_offset, image_angle - 90);

draw_sprite_ext(sprite_index, image_index, x + _offset_x, y + _offset_y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);