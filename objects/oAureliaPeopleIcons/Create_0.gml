var _count = 4;

start_x = array_create(_count);
start_y = array_create(_count);

move_phase = array_create(_count);
move_speed = array_create(_count);
move_amplitude = 8;

for (var i = 0; i < _count; i++) {
    start_x[i] = 0;
    start_y[i] = 0;
    move_phase[i] = random(360);
    move_speed[i] = random_range(1.5, 2.5);
}