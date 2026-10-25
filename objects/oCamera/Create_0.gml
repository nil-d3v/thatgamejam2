//--------------------------------------------------
// Camera System
// Version 1.0.0
// Created by 0xNil
// https://0xnil-dev.itch.io/gamemaker-camera-system
//--------------------------------------------------

// Camera Setup
cam = view_camera[0];

cam_x = camera_get_view_x(cam) + camera_get_view_width(cam) * 0.5;
cam_y = camera_get_view_y(cam) + camera_get_view_height(cam) * 0.5;

cam_scale = 1;
target_scale = 1;

// Defaults
default_camera_area = {
    x : 0,
    y : 0,
    width  : room_width,
    height : room_height
};
default_directional_offset = 60; // directional offset
bias_speed = 4; // directional offset direction change speed
default_follow_percent = 60; // reactivity
zoom_margin = 64; // minimal margin while zooming
min_zoom = 0.5;
max_zoom = 2;

// Follow
follow_targets = [];
follow_percent = default_follow_percent;

// Directional Bias
directional_offset = default_directional_offset;
bias_dir = 1;

// Bounds
camera_area = default_camera_area;

// Effects
shake_strength = 0;
shake_time = 0;
shake_total_time = 0;
zoom_to_zoom = 0;
zoom_to_time = 0;
pan_to_x = 0;
pan_to_y = 0;
pan_to_time = 0;

// Zones
active_zone = noone;

// View base size
base_w = camera_get_view_width(cam);
base_h = camera_get_view_height(cam);

// Target Functions
/// @function add_target(inst)
/// Add an instance to the follow target list.
function add_target(inst) {
	// Check validity
    if !instance_exists(inst) {
		return;
	}
    // Avoid duplicates
    for (var i = 0; i < array_length(follow_targets); i++) {
        if follow_targets[i] == inst {
            return;
		}
    }
	// Add the target
    array_push(follow_targets, inst);
}

/// @function remove_target(inst)
/// Remove an instance from the follow target list.
function remove_target(inst) {
    var new_array = [];
    for (var i = 0; i < array_length(follow_targets); i++) {
        if follow_targets[i] != inst {
            array_push(new_array, follow_targets[i]);
		}
    }
    follow_targets = new_array;
}

/// @function set_target(inst)
/// Replace all current targets with a single target.
function set_target(inst) {
	clear_targets();
	add_target(inst);
}

/// @function clear_targets()
/// Clear the follow target list.
function clear_targets() {
    follow_targets = [];
}

/// @function has_target(inst)
/// Return whether the instance is in the follow target list.
function has_target(inst) {
	for (var i = 0; i < array_length(follow_targets); i++) {
	    if follow_targets[i] == inst {
	        return true;
		}
	}
	return false;
}

// Effects Functions
/// @function shake(strength, duration)
/// Camera shake in pixels for duration in seconds.
function shake(strength, duration) {
    shake_strength = strength;
    shake_time = duration;
	shake_total_time = duration;
}

/// @function zoom_to(zoom, duration)
/// Set the camera zoom to a fixed value for duration in seconds.
function zoom_to(zoom, duration) {
	zoom_to_zoom = zoom;
	zoom_to_time = duration;
}

/// @function stop_zoom()
/// Cancel zoom_to() effect before the end of the duration.
function stop_zoom() {
	zoom_to_time = 0;
}

/// @function pan_to(x_pos, y_pos, duration)
/// Set the camera target to a fixed point for duration in seconds.
function pan_to(x_pos, y_pos, duration) {
	pan_to_x = x_pos;
	pan_to_y = y_pos;
	pan_to_time = duration;
}

/// @function stop_pan()
/// Cancel pan_to() effect before the end of the duration.
function stop_pan() {
	pan_to_time = 0;
}