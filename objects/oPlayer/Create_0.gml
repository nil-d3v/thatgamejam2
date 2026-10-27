depth = -10;

// Functions
function update_status() {
	jumpMax = global.game_data.abilities.double_jump ? 2 : 1;
}

function get_inputs() {
	// Inputs
	rightKey = keyboard_check(vk_right) || keyboard_check(ord("D")) || gamepad_button_check(0, gp_padr);
	leftKey = keyboard_check(vk_left) || keyboard_check(ord("A")) || gamepad_button_check(0, gp_padl);
	downKey = keyboard_check(vk_down) || keyboard_check(ord("S")) || gamepad_button_check(0, gp_padd);
	downKeyPressed = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S")) || gamepad_button_check_pressed(0, gp_padd);
	jumpKey = keyboard_check(vk_up) || keyboard_check(ord("W")) || keyboard_check(vk_space) || gamepad_button_check(0, gp_face1);
	jumpKeyPressed = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(0, gp_face1);
	actionKey = keyboard_check(vk_shift) || keyboard_check(ord("Z")) || gamepad_button_check(0, gp_face2);
	actionKeyPressed = keyboard_check_pressed(vk_shift) || keyboard_check_pressed(ord("Z")) || gamepad_button_check_pressed(0, gp_face2);
	dialogueKey = keyboard_check(vk_return) || keyboard_check(ord("E")) || keyboard_check(ord("X")) || gamepad_button_check(0, gp_face3);
	dialogueKeyPressed = keyboard_check_pressed(vk_return) || keyboard_check_pressed(ord("E")) || keyboard_check_pressed(ord("X")) || gamepad_button_check_pressed(0, gp_face3);
	
	// Buffering
	if jumpKeyPressed {
		jumpKeyBufferTimer = jumpBufferTime;
	}
	if jumpKeyBufferTimer > 0 {
		jumpKeyBuffered = true;
		jumpKeyBufferTimer--;
	} else {
		jumpKeyBuffered = false;
	}
	
	if actionKeyPressed {
		actionKeyBufferTimer = actionBufferTime;
	}
	if actionKeyBufferTimer > 0 {
		actionKeyBuffered = true;
		actionKeyBufferTimer--;
	} else {
		actionKeyBuffered = false;
	}
}

function set_on_ground(_val) {
	if _val == true {
		if !onGround {
			jumpAnimationLandingTimer = jumpAnimationLandingDuration;
			xscale = 1.5;
			yscale = 0.5;
		}
		onGround = true;
		coyoteHangTimer = coyoteHangFrames;
	} else {
		onGround = false;
		coyoteHangTimer = 0;
		groundPlatform = noone;
	}
}

function is_on_semisolid() {
	var on_platform = collision_rectangle(bbox_left, bbox_bottom + 1, bbox_right, bbox_bottom + 1, oSemiSolid, false, true);
	if (!on_platform) {
	    return noone;
	}
	var inside_platform = collision_rectangle(bbox_left,bbox_bottom, bbox_right, bbox_bottom, oSemiSolid, false, true);
	if (!inside_platform) {
	    return on_platform;
	}
	if (on_platform == inside_platform) {
	    return noone;
	}
	return on_platform;
}

// Player Updating
function player_update_movement() {
	dashCooldownTimer--;
	if movement_player_state != MovementPlayerState.DASHING && dialogueKeyPressed && dashCooldownTimer <= 0 {
		movement_player_state = MovementPlayerState.DASHING;
		dashTimer = dashDuration;
		dashDirection = face;
	} else if movement_player_state != MovementPlayerState.DASHING {
		if !onGround && yspd > 0 && global.game_data.abilities.glide && actionKey {
	        movement_player_state = MovementPlayerState.GLIDING;
		} else {
			movement_player_state = MovementPlayerState.CLASSIC;
		}
	}
}

function player_update_platform_movement() {
	if !instance_exists(groundPlatform) {
		return;
	}
	var _platform = groundPlatform;
	move_x(_platform.xspd);
	if (_platform.yspd < 0 && place_meeting(x, y + _platform.yspd, tileset_id)) {
		var _subpixel = 0.25;
		while (place_meeting(x, y + _platform.yspd, tileset_id)) {
			y += _subpixel;
		}
		while (place_meeting(x, y, tileset_id)) {
			y += _subpixel;
		}
		y = round(y);
		yspd = 0;
		yspdInt = 0;
		yspdFrac = 0;
		jumpHoldTimer = 0;
		set_on_ground(false);
		return;
	}
	if !move_y(_platform.yspd) {
		groundPlatform = noone;
	}
}

function player_update_horizontal_control() {
	switch (movement_player_state) {
		case MovementPlayerState.CLASSIC:
		case MovementPlayerState.GLIDING:
			var _currentMoveSpeed = 0;
			if onGround && global.game_data.abilities.sprint && actionKey {
				_currentMoveSpeed = sprintSpeed;
			} else {
				_currentMoveSpeed = moveSpeed;
			}
			moveDir = rightKey - leftKey;
			if moveDir != 0 {
				face = moveDir;
			}
			if moveDir != 0 {
				xspd = moveDir * _currentMoveSpeed;
			} else {
				var _target = moveDir * _currentMoveSpeed;
				var _accel = onGround ? 0.5 : (movement_player_state == MovementPlayerState.CLASSIC ? 0.2 : 0.05);
				xspd = approach(xspd, _target, _accel);
			}
		break;

		case MovementPlayerState.DASHING:
			dashTimer--;
			xspd = approach(xspd, dashDirection * dashSpeed, 0.3);
			if dashTimer <= 0 {
				movement_player_state = MovementPlayerState.CLASSIC;
				dashCooldownTimer = dashCooldownDuration;
			}
		break;
	}
}

function player_update_vertical_control() {
	if movement_player_state == MovementPlayerState.DASHING {
		yspd = 0;
	} else {
		if coyoteHangTimer > 0 {
			coyoteHangTimer--;
		} else {
			if yspd < 0 {
				yspd += normalGravity;
			} else if movement_player_state == MovementPlayerState.GLIDING {
				yspd += gliderGravity;
			} else {
				yspd += fastGravity;
			}
		}
		
		if onGround {
			jumpCount = 0;
			jumpHoldTimer = 0;
			coyoteJumpTimer = coyoteJumpFrames;
		} else {
			coyoteJumpTimer--;
			if jumpCount == 0 && coyoteJumpTimer <= 0 {
				jumpCount = 1;
			}
		}

		if jumpKeyBuffered && jumpCount < jumpMax {
			jumpKeyBuffered = false;
			jumpKeyBufferTimer = 0;
			jumpCount++;
			jumpHoldTimer = jumpHoldFrames[jumpCount - 1];
			set_on_ground(false);
			if jumpCount <= 1 {
				jumpAnimationTakeoffTimer = jumpAnimationTakeoffDuration;
			}
		}

		if !jumpKey {
			jumpHoldTimer = 0;
		}
		if jumpHoldTimer > 0 {
			yspd = jspd[jumpCount - 1];
			jumpHoldTimer--;
		}
		
		if onGround && downKeyPressed && instance_exists(groundPlatform) {
			dropThroughPlatform = groundPlatform;
			groundPlatform = noone;
			onGround = false;
			y += 1;
			yspd = 1;
			yspdFrac = 0;
		}
	
		var _currentTermVel = (movement_player_state == MovementPlayerState.GLIDING) ? gliderTermVel : normalTermVel;
		if yspd > _currentTermVel {
			yspd = _currentTermVel;
		}
	}
}

function round_speeds() {
	xspdFrac += xspd;
	xspdInt = floor(xspdFrac);
	xspdFrac -= xspdInt;
	yspdFrac += yspd;
	yspdInt = floor(yspdFrac);
	yspdFrac -= yspdInt;
}

function move_x(_amount) {
	var _remaining = abs(_amount);
	var _dir = sign(_amount);
	var _step_size = 0.2;
	var _success = true;

	while (_remaining > 0.0001) {
		var _step = min(_step_size, _remaining);
		var _move = _dir * _step;
		if (place_meeting(x + _move, y, tileset_id)) {
			_success = false;
			break;
		}
		x += _move;
		_remaining -= _step;
	}
	return _success;
}

function move_y(_amount) {
	var _remaining = abs(_amount);
	var _dir = sign(_amount);
	var _step_size = 0.2;
	var _success = true;

	while (_remaining > 0.0001) {
		var _step = min(_step_size, _remaining);
		var _move = _dir * _step;
		var _old_bottom = bbox_bottom;
		var _next_y = y + _move;
		if (place_meeting(x, _next_y, tileset_id)) {
			_success = false;
			break;
		}
		if (_dir > 0) {
			var _count = instance_number(oSemiSolid);

			for (var i = 0; i < _count; i++) {
				var _platform = instance_find(oSemiSolid, i);
				if (!instance_exists(_platform)) {
					continue;
				}
				if (_platform == dropThroughPlatform) {
					continue;
				}
				var _overlap_x = bbox_right > _platform.bbox_left && bbox_left < _platform.bbox_right;
				var _crossing_top = _old_bottom <= _platform.bbox_top && _old_bottom + _move >= _platform.bbox_top;
				if (_overlap_x && _crossing_top) {
					y += _platform.bbox_top - _old_bottom;
					groundPlatform = _platform;
					_success = false;
					return _success;
				}
			}
		}
		y = _next_y;
		_remaining -= _step;
	}
	return _success;
}

function player_update_horizontal_physics() {
	if !move_x(xspdInt) {
		xspd = 0;
		xspdFrac = 0;
		if movement_player_state == MovementPlayerState.DASHING {
			movement_player_state = MovementPlayerState.CLASSIC;
			dashCooldownTimer = dashCooldownDuration;
		}
	}
}

function player_update_vertical_physics() {
	var _previous_bottom = bbox_bottom;
    if !move_y(yspdInt) {
        if (yspdInt < 0) {
            jumpHoldTimer = 0;
        }
        if (yspdInt > 0) {
            set_on_ground(true);
        }
        yspd = 0;
        yspdFrac = 0;
    }
    if (yspd >= 0) {
        var _count = instance_number(oSemiSolid);
        for (var i = 0; i < _count; i++) {
            var _p = instance_find(oSemiSolid, i);
            if (!instance_exists(_p)) {
                continue;
            }
            var _prev_top = _p.platform_prev_y + (_p.bbox_top - _p.y);
            var _prev_left = _p.platform_prev_x + (_p.bbox_left - _p.x);
            var _prev_right = _p.platform_prev_x + (_p.bbox_right - _p.x);
            if (_p != dropThroughPlatform && bbox_right > min(_prev_left, _p.bbox_left) && bbox_left < max(_prev_right, _p.bbox_right) && _previous_bottom <= _prev_top && bbox_bottom >= _p.bbox_top - 1) {
                y += _p.bbox_top - bbox_bottom;
                groundPlatform = _p;
                yspd = 0;
                yspdInt = 0;
                yspdFrac = 0;
                set_on_ground(true);
                break;
            }
        }
    }
    if yspd >= 0 {
        if place_meeting(x, y + 1, tileset_id) {
            groundPlatform = noone;
            set_on_ground(true);
        } else {
            var _platform = collision_rectangle(bbox_left, bbox_bottom, bbox_right, bbox_bottom + 1, oSemiSolid, false, true);
            if _platform != noone && _platform != dropThroughPlatform && bbox_bottom <= _platform.bbox_top {
                groundPlatform = _platform;
                set_on_ground(true);
            }
        }
    }
	if (instance_exists(dropThroughPlatform)) {
	    if (bbox_top > dropThroughPlatform.bbox_bottom) {
	        dropThroughPlatform = noone;
	    }
	} else {
	    dropThroughPlatform = noone;
	}
}

function player_update_sprite() {
	if movement_player_state == MovementPlayerState.CLASSIC {
		if onGround {
			if xspd != 0 {
				if xspd > moveSpeed {
					sprite_index = sPlayerSprint;
				} else {
					sprite_index = sPlayerWalk;
				}
			} else {
				sprite_index = sPlayerIdle;
			}
			if jumpAnimationLandingTimer > 0 {
				sprite_index = sPlayerJump;
				image_index = 7;
			}
		} else {
			sprite_index = sPlayerJump;
			if jumpAnimationTakeoffTimer > 0 {
				image_index = 0;
			} else if yspd <= 2 && yspd >= -2 {
				image_index += 0.5;
				if image_index >= 6 {
				    image_index = 2;
				}
			} else if yspd < 0 {
				image_index = 1;
			} else {
				image_index = 6;
			}
		}
		jumpAnimationTakeoffTimer--;
		jumpAnimationLandingTimer--;
	} else if movement_player_state == MovementPlayerState.GLIDING {
		sprite_index = sPlayerGlide;
	} else {
		sprite_index = sPlayerDash;
		image_index = ceil((1 - (dashTimer / dashDuration)) * sprite_get_number(sPlayerDash) - 1)
	}
}

// States
enum MainPlayerState {
    NORMAL,
	DIALOGUE,
	CUTSCENE,
	DEAD
}

enum MovementPlayerState {
    CLASSIC,
	GLIDING,
	DASHING
}

main_player_state = MainPlayerState.NORMAL;
movement_player_state = MovementPlayerState.CLASSIC;

// Inputs
rightKey = false;
leftKey = false;
jumpKey = false;
jumpKeyPressed = false;
actionKey = false;
actionKeyPressed = false;
dialogueKey = false;
dialogueKeyPressed = false;
jumpBufferTime = 3;
jumpKeyBuffered = false;
jumpKeyBufferTimer = 0;
actionBufferTime = 3;
actionKeyBuffered = false;
actionKeyBufferTimer = 0;

// Tileset
var _tile_layer_id = layer_get_id("CollisionTiles");
tileset_id = layer_tilemap_get_id(_tile_layer_id);

// Moving
moveDir = 0;
moveSpeed = 2.5;
sprintSpeed = 4;
face = 1;
xspd = 0;
yspd = 0;
xspdInt = 0;
yspdInt = 0;
xspdFrac = 0;
yspdFrac = 0;
groundPlatform = noone;
dropThroughPlatform = noone;

// Jumping
normalGravity = 0.3;
fastGravity = 0.46;
gliderGravity = 0.1;
normalTermVel = 6;
gliderTermVel = 3;
onGround = true;
jumpMax = 1;
jumpCount = 0;
jumpHoldTimer = 0;

// Jump Values
jumpHoldFrames[0] = 12;
jspd[0] = -3.4;
jumpHoldFrames[1] = 1;
jspd[1] = -4;

// Coyote Time
coyoteHangFrames = 2;
coyoteHangTimer = 0;
coyoteJumpFrames = 5;
coyoteJumpTimer = 0;

// Dash
dashSpeed = 5;
dashDirection = 0;
dashDuration = 30;
dashTimer = 0;
dashCooldownDuration = 60;
dashCooldownTimer = 0;

// Sprites
jumpAnimationTakeoffTimer = 0;
jumpAnimationLandingTimer = 0;
jumpAnimationTakeoffDuration = 3;
jumpAnimationLandingDuration = 3;