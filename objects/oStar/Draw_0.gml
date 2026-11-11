if was_collected {
	draw_sprite(sprite_index, 1, x, y);
} else {
	gpu_set_blendmode(bm_add);

	// Large outer glow
	draw_sprite_ext(
	    sprite_index, 0,
	    x, y,
	    1.8, 1.8,
	    image_angle,
	    c_white,
	    0.08
	);

	// Medium glow
	draw_sprite_ext(
	    sprite_index, 0,
	    x, y,
	    1.5, 1.5,
	    image_angle,
	    c_white,
	    0.18
	);

	// Inner glow
	draw_sprite_ext(
	    sprite_index, 0,
	    x, y,
	    1.2, 1.2,
	    image_angle,
	    c_white,
	    0.3
	);

	gpu_set_blendmode(bm_normal);

	// Original sprite
	draw_sprite(sprite_index, 0, x, y);
}