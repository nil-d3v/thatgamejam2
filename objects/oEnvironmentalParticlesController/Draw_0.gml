if (global.game_paused) exit;

if (fx_mode == "none") exit;

gpu_set_blendmode(bm_add);

for (var i = 0; i < array_length(particles); i++) {
    var _p = particles[i];

    var _alpha = _p.alpha;

    // Motes fade in and out
    if (fx_mode == "motes") {
        var _life_ratio = _p.life / _p.max_life;

        _alpha *= sin(_life_ratio * pi);
    }

    draw_set_alpha(_alpha);

    switch (fx_mode) {
        case "snow":
            draw_set_color(c_white);
            draw_circle(_p.x, _p.y, _p.size, false);
            break;

        case "moss":
            draw_set_color(_p.color);
            draw_circle(_p.x, _p.y, _p.size, false);

            // Small glow around the particle
            draw_set_alpha(_alpha * 0.2);
            draw_circle(_p.x, _p.y, _p.size * 2.5, false);
            break;

        case "motes":
            draw_set_color(_p.color);
            draw_circle(_p.x, _p.y, _p.size, false);

            draw_set_alpha(_alpha * 0.2);
            draw_circle(_p.x, _p.y, _p.size * 3, false);
            break;
    }
}

draw_set_alpha(1);
draw_set_color(c_white);
gpu_set_blendmode(bm_normal);