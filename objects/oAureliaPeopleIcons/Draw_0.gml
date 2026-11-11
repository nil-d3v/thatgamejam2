for (var i = 0; i < 4; i++) {
    var t = current_time / 1000;
    var _x = start_x[i] + sin(t * move_speed[i] + move_phase[i]) * move_amplitude;
    draw_sprite_ext(sprite_index, i, _x, start_y[i], 1, 1, 0, c_white, 1);
}