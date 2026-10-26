depth = -10;

// Functions
function update_status() {
	jumpMax = global.game_data.abilities.double_jump ? 2 : 1;
}

function get_inputs() {
	// Inputs
	rightKey = keyboard_check(vk_right) || keyboard_check(ord("D")) || gamepad_button_check(0, gp_padr);
	leftKey = keyboard_check(vk_left) || keyboard_check(ord("A")) || gamepad_button_check(0, gp_padl);
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
			xscale = 1.5;
			yscale = 0.5;
		}
		onGround = true;
		coyoteHangTimer = coyoteHangFrames;
	} else {
		onGround = false;
		coyoteHangTimer = 0;
	}
}

function is_on_semisolid() {
	var on_platform = collision_rectangle(
		bbox_left,
		bbox_bottom + 1,
		bbox_right,
		bbox_bottom + 1,
		oSemiSolid,
		false,
		true
	);

	if (!on_platform) {
	    return noone;
	}

	var inside_platform = collision_rectangle(
	    bbox_left,
	    bbox_bottom,
	    bbox_right,
	    bbox_bottom,
	    oSemiSolid,
	    false,
	    true
	);

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
			set_on_ground(false);
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
		}

		if !jumpKey {
			jumpHoldTimer = 0;
		}
		if jumpHoldTimer > 0 {
			yspd = jspd[jumpCount - 1];
			jumpHoldTimer--;
		}
	
		var _currentTermVel = (movement_player_state == MovementPlayerState.GLIDING) ? gliderTermVel : normalTermVel;
		if yspd > _currentTermVel {
			yspd = _currentTermVel;
		}
	}
}

function player_update_horizontal_physics() {
	var _subPixel = 0.5;
	if place_meeting(x + xspd, y, tileset_id) {
		var _pixelCheck = _subPixel * sign(xspd);
		while !place_meeting(x + _pixelCheck, y, tileset_id) {
			x += _pixelCheck
		}
		xspd = 0;
	}
	x += xspd;	
}

function player_update_vertical_physics() {
	var _subPixel = 0.5;
	if place_meeting(x, y + yspd, tileset_id) {
		var _pixelCheck = _subPixel * sign(yspd);
		while !place_meeting(x, y + _pixelCheck, tileset_id) {
			y += _pixelCheck
		}
		if yspd < 0 {
			jumpHoldTimer = 0;
		}
		yspd = 0;
	}

	if yspd >= 0 && place_meeting(x, y + 1, tileset_id) {
		set_on_ground(true);
	}
	y += yspd;
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
		} else {
			sprite_index = sPlayerJump;
			if yspd <= 3 && yspd >= -3 {
				image_index += 0.25;
				if image_index >= 6 {
				    image_index = 2;
				}
			} else {
				image_index = 1;
			}
		}
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

// Setup Inputs
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