function particle_init() {
	// Create Particle System
    global.ps = part_system_create();
	
	// First Jump
	global.pt_first_jump = part_type_create();
	part_type_shape(global.pt_first_jump, pt_shape_pixel);
	part_type_alpha1(global.pt_first_jump, 1);
	part_type_life(global.pt_first_jump, 10, 12);
	part_type_speed(global.pt_first_jump, 1.5, 1.5, 0, 0);
	part_type_direction(global.pt_first_jump, 180, 360, 0, 0);
	part_type_color1(global.pt_first_jump, make_color_rgb(255, 255, 255));
	
	// Second Jump
	global.pt_second_jump = part_type_create();
	part_type_shape(global.pt_second_jump, pt_shape_pixel);
	part_type_alpha1(global.pt_second_jump, 1);
	part_type_life(global.pt_second_jump, 10, 12);
	part_type_speed(global.pt_second_jump, 1.5, 1.5, 0, 0);
	part_type_direction(global.pt_second_jump, 180, 360, 0, 0);
	part_type_color1(global.pt_second_jump, make_color_rgb(255, 255, 255));
	
	// Tile Break
	global.pt_block_break = part_type_create();
	part_type_shape(global.pt_block_break, pt_shape_pixel);
	part_type_alpha1(global.pt_block_break, 1);
	part_type_life(global.pt_block_break, 8, 10);
	part_type_speed(global.pt_block_break, 0.8, 1.2, 0, 0);
	part_type_direction(global.pt_block_break, 0, 359, 0, 0);
	part_type_color1(global.pt_block_break, make_color_rgb(71, 30, 76));
}

function particle_destroy() {
	part_type_destroy(global.pt_first_jump);
	part_type_destroy(global.pt_second_jump);
	part_type_destroy(global.pt_block_break);
	part_system_destroy(global.ps);
}

// Emit
function particle_emit_first_jump(_x, _y) {
	part_particles_create(global.ps, _x, _y, global.pt_first_jump, 11);
}

function particle_emit_second_jump(_x, _y) {
	part_particles_create(global.ps, _x, _y, global.pt_second_jump, 8);
}

function particle_emit_block_break(_x, _y) {
	part_particles_create(global.ps, _x, _y, global.pt_block_break, 14);
}