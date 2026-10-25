add_target(oPlayer);

// Set Delta Time
var dt = 1 / game_get_speed(gamespeed_fps);

// Zone Detection
var best_zone = noone;
var best_priority = -999999;

with (oCameraZone) {
    if place_meeting(x, y, other.follow_targets) {
        if zone_priority > best_priority {
            best_priority = zone_priority;
            best_zone = id;
        }
    }
}

active_zone = best_zone;

// Check Target Validity
var valid_targets = [];

for (var i = 0; i < array_length(follow_targets); i++) {
    if instance_exists(follow_targets[i]) {
        array_push(valid_targets, follow_targets[i]);
	}
}

follow_targets = valid_targets;

if array_length(follow_targets) == 0 {
	exit;
}

// Target Box Bounds Calculation
var first = follow_targets[0];

var minX = first.x;
var maxX = first.x;
var minY = first.y;
var maxY = first.y;

for (var i = 1; i < array_length(follow_targets); i++) {
    var t = follow_targets[i];
    minX = min(minX, t.x);
    maxX = max(maxX, t.x);
    minY = min(minY, t.y);
    maxY = max(maxY, t.y);
}

var targetX = (minX + maxX) * 0.5;
var targetY = (minY + maxY) * 0.5;

// Directional Bias
if (array_length(follow_targets) == 1) {
    var inst = follow_targets[0];
	
    if variable_instance_exists(inst, "face") {
        var bias = directional_offset / 100;
        var view_w = base_w / cam_scale;
		
        // Relative offset
        var offset = (bias - 0.5) * view_w;
        // Target direction
		var target_dir = inst.face;
		// Interpolation
		bias_dir += (target_dir - bias_dir) * bias_speed * dt;
		// Apply interpolated bias
		targetX += offset * bias_dir;
    }
}

// Zoom to Contain
var box_w = maxX - minX;
var box_h = maxY - minY;

var desired_w = box_w + zoom_margin * 2;
var desired_h = box_h + zoom_margin * 2;

var scale_x = base_w / desired_w;
var scale_y = base_h / desired_h;

if (array_length(follow_targets) == 1) {
    target_scale = 1;
} else {
    target_scale = min(scale_x, scale_y);
    target_scale = clamp(target_scale, min_zoom, max_zoom);
}

// Reset Override
directional_offset = default_directional_offset;
camera_area = default_camera_area;
follow_percent = default_follow_percent;

// Zone Override
if (instance_exists(active_zone)) {
    if (active_zone.override_bounds) {
        camera_area = {
            x : active_zone.x,
            y : active_zone.y,
            width  : active_zone.sprite_width,
            height : active_zone.sprite_height
        };
    }
    if (active_zone.override_zoom) {
        target_scale = active_zone.zone_zoom;
    }
    if (active_zone.override_bias) {
        directional_offset = active_zone.zone_bias;
    }
	if (active_zone.override_follow) {
        follow_percent = active_zone.follow_percent;
    }
    if (active_zone.override_target) {
        targetX = active_zone.fixed_target_x;
        targetY = active_zone.fixed_target_y;
    }
}

// Effects Override
if zoom_to_time > 0 {
    zoom_to_time -= dt;
	target_scale = zoom_to_zoom;
}

if pan_to_time > 0 {
	pan_to_time -= dt;
	targetX = pan_to_x;
	targetY = pan_to_y;
}

// Smooth Zoom
var zoom_lag = 30 * dt;
cam_scale += (target_scale - cam_scale) * zoom_lag;

// Clamp Camera
var view_w = base_w / cam_scale;
var view_h = base_h / cam_scale;

var half_w = view_w * 0.5;
var half_h = view_h * 0.5;

if (is_struct(camera_area)) {
    targetX = clamp(
        targetX,
        camera_area.x + half_w,
        camera_area.x + camera_area.width - half_w
    );

    targetY = clamp(
        targetY,
        camera_area.y + half_h,
        camera_area.y + camera_area.height - half_h
    );
}

// Smooth Follow
var followLag = follow_percent / 100;
var lag = followLag * 30 * dt;

cam_x += (targetX - cam_x) * lag;
cam_y += (targetY - cam_y) * lag;

// Shake
var shakeX = 0;
var shakeY = 0;

if (shake_time > 0) {
    shake_time -= dt;
	var fade = shake_time / shake_total_time;
    shakeX = random_range(-shake_strength, shake_strength) * fade;
    shakeY = random_range(-shake_strength, shake_strength) * fade;
}

// Apply Camera
camera_set_view_size(cam, view_w, view_h);
camera_set_view_pos(cam,
    cam_x - half_w + shakeX,
    cam_y - half_h + shakeY
);