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
	
	// Star Collect
	global.pt_star_collect = part_type_create();
	part_type_shape(global.pt_star_collect, pt_shape_pixel);
	part_type_size(global.pt_star_collect, 3, 3, -0.04, 0);
	part_type_alpha1(global.pt_star_collect, 0.8);
	part_type_life(global.pt_star_collect, 16, 20);
	part_type_speed(global.pt_star_collect, 2.6, 2.8, 0, 0);
	part_type_direction(global.pt_star_collect, 0, 359, 0, 0);
	part_type_color1(global.pt_star_collect, make_color_rgb(255, 255, 255));
	
	// Death
	global.pt_player_death = part_type_create();
	part_type_shape(global.pt_player_death, pt_shape_pixel);
	part_type_size(global.pt_player_death, 3, 3, 0, 0);
	part_type_alpha1(global.pt_player_death, 1);
	part_type_life(global.pt_player_death, 15, 22);
	part_type_speed(global.pt_player_death, 2.5, 3.5, 0, 0);
	part_type_direction(global.pt_player_death, 0, 359, 0, 0);
	part_type_color1(global.pt_player_death, make_color_rgb(255, 255, 255));
}

function particle_destroy() {
	part_type_destroy(global.pt_first_jump);
	part_type_destroy(global.pt_second_jump);
	part_type_destroy(global.pt_block_break);
	part_type_destroy(global.pt_star_collect);
	part_type_destroy(global.pt_player_death);
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

function particle_emit_star_collect(_x, _y) {
	part_particles_create(global.ps, _x, _y, global.pt_star_collect, 20);
}

function particle_emit_player_death(_x, _y) {
	part_particles_create(global.ps, _x, _y, global.pt_player_death, 40);
}