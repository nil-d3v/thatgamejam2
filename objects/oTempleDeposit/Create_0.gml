star_image_xscale = 0;
star_image_yscale = 0;
star_image_alpha = 0;
star_image_angle = 0;

star_x = 0;
star_y = 0;

star_target_x = 400;
star_target_y = 120;

star_start_x = 0;
star_start_y = 0;

star_phase = 0;
star_timer = 0;

star_appear_duration = 25;
star_travel_duration = 50;
star_burst_duration = 20;

star_burst_duration = 20;
star_hold_duration = 12;
star_disappear_duration = 8;

star_rotation_speed = 2;

star_active = false;

// Easing helper
function ease_out_cubic(_t) {
    return 1 - power(1 - _t, 3);
}

function ease_in_out_cubic(_t) {
    if (_t < 0.5) {
        return 4 * _t * _t * _t;
    }

    return 1 - power(-2 * _t + 2, 3) / 2;
}

// Data
star_given = false;
star_growth = false;