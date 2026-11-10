
// ---------------------------------
// CAMERA
// ---------------------------------

cam = view_camera[0];

if (cam == -1) exit;

var _cam_x = camera_get_view_x(cam);
var _cam_y = camera_get_view_y(cam);

var _cam_w = camera_get_view_width(cam);
var _cam_h = camera_get_view_height(cam);


// ---------------------------------
// SELECT ENVIRONMENT
// ---------------------------------

var _new_mode = "none";

switch (room) {
    case RoomAurelia:
        _new_mode = "snow";
        break;

    case RoomWoods:
        _new_mode = "moss";
        break;

    case RoomValley:
        _new_mode = "motes";
        break;
}

// Reset when changing environment
if (fx_mode != _new_mode) {
    fx_mode = _new_mode;
    particles = [];
    particle_timer = 0;
    camera_initialized = false;
}

if (fx_mode == "none") exit;
if (global.game_paused) exit;


// ---------------------------------
// PARTICLE SETTINGS
// ---------------------------------

switch (fx_mode) {
    case "snow":
        spawn_interval = 2;
        max_particles = 360;
        break;

    case "moss":
        spawn_interval = 3;
        max_particles = 200;
        break;

    case "motes":
        spawn_interval = 5;
        max_particles = 140;
        break;
}

// ---------------------------------
// SPAWN AREA
// ---------------------------------

var _left = _cam_x - spawn_margin_x;
var _right = _cam_x + _cam_w + spawn_margin_x;

var _top = _cam_y - spawn_margin_y;
var _bottom = _cam_y + _cam_h + spawn_margin_y;

//
if (!camera_initialized) {
    var _initial_count = max_particles;

    for (var i = 0; i < _initial_count; i++) {
        var _spawn_x = random_range(_left, _right);
        var _spawn_y = random_range(_top, _bottom);

        scr_ambient_particle_spawn(
            fx_mode,
            _spawn_x,
            _spawn_y
        );
    }

    camera_initialized = true;
}

// ---------------------------------
// SPAWN PARTICLES
// ---------------------------------

particle_timer++;

if (particle_timer >= spawn_interval) {
    particle_timer = 0;

    var _available = max_particles - array_length(particles);

    if (_available > 0) {
        var _spawn_count = min(_available, 3);

        for (var j = 0; j < _spawn_count; j++) {
            var _spawn_x = random_range(_left, _right);
            var _spawn_y;

            switch (fx_mode) {
                case "snow":
                case "moss":
                    _spawn_y = _top;
                    break;

                case "motes":
                    _spawn_y = _bottom;
                    break;
            }

            scr_ambient_particle_spawn(
                fx_mode,
                _spawn_x,
                _spawn_y
            );
        }
    }
}


// ---------------------------------
// UPDATE PARTICLES
// ---------------------------------

for (var i = array_length(particles) - 1; i >= 0; i--) {
    var _p = particles[i];

    _p.phase += _p.phase_speed;

    switch (fx_mode) {
        case "snow":
            _p.x += _p.vx + sin(_p.phase) * 0.25;
            _p.y += _p.vy;
            break;

        case "moss":
            _p.x += _p.vx + sin(_p.phase) * 0.2;
            _p.y += _p.vy;
            break;

        case "motes":
            _p.x += _p.vx + sin(_p.phase) * 0.15;
            _p.y += _p.vy;
            break;
    }

    _p.life--;

	var _outside =
	    _p.x < _left ||
	    _p.x > _right ||
	    _p.y < _top ||
	    _p.y > _bottom;

    if (_p.life <= 0 || _outside) {
        array_delete(particles, i, 1);
    } else {
        particles[i] = _p;
    }
}
