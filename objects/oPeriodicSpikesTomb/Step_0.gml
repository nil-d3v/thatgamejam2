if (global.game_paused) exit;

timer--;

if (timer <= 0) {
    enabled = !enabled;
    timer = enabled ? enabled_time : disabled_time;

    ground_offset_target = enabled ? 0 : sprite_get_height(base_sprite_index);
}

ground_offset = lerp(ground_offset, ground_offset_target, ground_offset_speed);

if (abs(ground_offset - ground_offset_target) < 0.5) {
    ground_offset = ground_offset_target;
}

sprite_index = (ground_offset == sprite_get_height(base_sprite_index)) ? sPeriodicSpikesEmpty : base_sprite_index;