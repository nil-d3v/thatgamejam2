if (instance_number(oEnvironmentalParticlesController) > 1) {
    instance_destroy();
    exit;
}

depth = -100;

particles = [];

particle_timer = 0;

max_particles = 100;
fx_mode = "none";
spawn_interval = 2;

cam = -1;

// Camera tracking
last_cam_x = 0;
last_cam_y = 0;
camera_initialized = false;

// Spawn buffer around camera
spawn_margin_x = 480;
spawn_margin_y = 270;

// Function
function scr_ambient_particle_spawn(_mode, _x, _y) {
    var _p = {};

    _p.x = _x;
    _p.y = _y;

    _p.life = 1;
    _p.max_life = 1;

    _p.size = 1;
    _p.alpha = 1;

    _p.vx = 0;
    _p.vy = 0;

    _p.phase = random(360);
    _p.phase_speed = random_range(1, 3);

    switch (_mode) {
        case "snow":
            _p.size = random_range(1, 2.5);
            _p.vx = random_range(-0.3, 0.3);
            _p.vy = random_range(0.6, 1.5);
            _p.alpha = random_range(0.35, 0.85);
            _p.max_life = 800;
            break;

        case "moss":
            _p.size = random_range(1, 2);
            _p.vx = random_range(0.3, 0.8);
            _p.vy = random_range(0.6, 1.0);
            _p.alpha = random_range(0.5, 1);
            _p.max_life = 800;

            _p.color = choose(
                make_color_rgb(150, 255, 90),
                make_color_rgb(220, 255, 100),
                make_color_rgb(100, 220, 80)
            );
            break;

        case "motes":
            _p.size = random_range(1, 2);
            _p.vx = random_range(-0.2, 0.2);
            _p.vy = random_range(-0.8, -0.3);
            _p.alpha = random_range(0.4, 0.8);
            _p.max_life = 800;

            _p.color = choose(
                make_color_rgb(170, 100, 255),
                make_color_rgb(205, 140, 255),
                make_color_rgb(130, 80, 220)
            );
            break;
    }

    _p.life = _p.max_life;

    array_push(particles, _p);
}
