if (global.game_paused) {exit;};

if !star_given && oGameController.save_file.star_carried && place_meeting(x, y, oPlayer) && oPlayer.onGround && oPlayer.movement_player_state == MovementPlayerState.CLASSIC && oPlayer.dialogueKeyPressed {
	star_given = true;
	oGameController.save_file.star_carried = false;
	oGameController.save_file.stars += 1;
	
	star_x = oPlayer.x;
	star_y = oPlayer.y - 60;

	star_start_x = star_x;
	star_start_y = star_y;

	star_target_x = x;
	star_target_y = y;

	star_image_xscale = 0;
	star_image_yscale = 0;
	star_image_alpha = 0;
	star_image_angle = 0;

	star_phase = 0;
	star_timer = 0;

	star_active = true;
}


//

if !star_given && oPlayer.star_carried && place_meeting(x, y, oPlayer) && oPlayer.onGround && oPlayer.movement_player_state == MovementPlayerState.CLASSIC {
	oPlayer.player_dialogue_key_interacting = true;
}
//


if (star_active) {
    star_timer++;

    // ---------------------------------
    // PHASE 0: APPEAR
    // ---------------------------------

    if (star_phase == 0) {
        var _t = clamp(star_timer / star_appear_duration, 0, 1);
        var _ease = 1 - power(1 - _t, 3);

        star_image_xscale = _ease;
        star_image_yscale = _ease;
        star_image_alpha = _ease;

        if (_t >= 1) {
            star_phase = 1;
            star_timer = 0;

            star_start_x = star_x;
            star_start_y = star_y;
        }
    }

    // ---------------------------------
    // PHASE 1: TRAVEL
    // ---------------------------------

    else if (star_phase == 1) {
        var _t = clamp(star_timer / star_travel_duration, 0, 1);

        var _ease = (_t < 0.5)
            ? 4 * _t * _t * _t
            : 1 - power(-2 * _t + 2, 3) / 2;

        star_x = lerp(star_start_x, star_target_x, _ease);
        star_y = lerp(star_start_y, star_target_y, _ease);

        star_image_angle += 360 / star_travel_duration;

        if (_t >= 1) {
            star_x = star_target_x;
            star_y = star_target_y;

            star_phase = 2;
            star_timer = 0;
        }
    }

    // ---------------------------------
    // PHASE 2: DEPOSIT BURST
    // ---------------------------------

    else if (star_phase == 2) {
        var _t = clamp(star_timer / star_burst_duration, 0, 1);
        var _ease = 1 - power(1 - _t, 3);

        star_image_xscale = lerp(1, 2, _ease);
        star_image_yscale = lerp(1, 2, _ease);
        star_image_alpha = 1;

        if (_t >= 1) {
            star_phase = 3;
            star_timer = 0;
        }
    }

    // ---------------------------------
    // PHASE 3: HOLD
    // ---------------------------------

    else if (star_phase == 3) {
        if (star_timer >= star_hold_duration) {
            star_phase = 4;
            star_timer = 0;
			particle_emit_star_collect(star_x, star_y);
        }
    }

    // ---------------------------------
    // PHASE 4: DISAPPEAR
    // ---------------------------------

    else if (star_phase == 4) {
        var _t = clamp(star_timer / star_disappear_duration, 0, 1);

        // Very fast ease-in disappearance
        var _ease = _t * _t;

        star_image_xscale = lerp(2, 0, _ease);
        star_image_yscale = lerp(2, 0, _ease);
        star_image_alpha = 1 - _ease;

        if (_t >= 1) {
            star_image_xscale = 0;
            star_image_yscale = 0;
            star_image_alpha = 0;

            star_active = false;
			
				switch (oGameController.save_file.stars) {
					case 1:
						oGameController.save_file.abilities.double_jump = true;
			
						oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 220, 0, "Me", ["_Yes_! My *first* star.", "I wish for... _double jump_!"], function() {
							star_growth = true;
							oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 220, 0, "Me", ["I should try to see if it worked.", "Now _where's_ the *next* star ?"], function() {
								oDialogueManager.start_dialogue(normal_to_gui_x(oNPCTempleGuard.x), normal_to_gui_y(oNPCTempleGuard.y), 220, 0, "Guard", ["The _next_ star is somewhere to the _left_ of the outskirts.", "*Somewhere* lively, filled with _magic_."], function() {
									oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 220, 0, "Me", ["_...where did he come from?_", "*Thank* _you_!"], function() {});
								});
							});
						});
					break;
		
					case 2:
						oGameController.save_file.abilities.sprint = true;
			
						oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 220, 0, "Me", ["_Phew_... my *second* star.", "I wish for... _Sprint_! "], function() {
							star_growth = true;
							oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 220, 0, "Me", ["Hey _guard_, do you know where the *next* _star_ is?"], function() {
								oDialogueManager.start_dialogue(normal_to_gui_x(oNPCTempleGuard.x), normal_to_gui_y(oNPCTempleGuard.y), 220, 0, "Guard", ["Go _further_ into the _jungle_", "A *barren cut* dessert would _appear_."], function() {
									oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 220, 0, "Me", ["Huh. _Thanks_!"], function() {
										oDialogueManager.start_dialogue(normal_to_gui_x(oNPCTempleGuard.x), normal_to_gui_y(oNPCTempleGuard.y), 220, 0, "Guard", ["Also remember, _SHIFT_, or _Z_ to _sprint_. "], function() {
											oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 220, 0, "Me", ["*Weird Guy*"], function() {});
										});
									});
								});
							});
						});
					break;
		
					case 3:
						oGameController.save_file.abilities.glide = true;
			
						oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 220, 0, "Me", ["That was a _long_ *ride*...", "I wish for... _Glide_! "], function() {
							star_growth = true;
							oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 220, 0, "Me", ["_Guard_, where's the *next* _star_?"], function() {
								oDialogueManager.start_dialogue(normal_to_gui_x(oNPCTempleGuard.x), normal_to_gui_y(oNPCTempleGuard.y), 220, 0, "Guard", ["Go to the right of the outskirts...", "There you'll find an abandoned city.", "Meet the citizen there."], function() {
									oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 220, 0, "Me", ["_Citizen_? *Not* _citizens_?"], function() {});
								});
							});
						});
					break;
		
					case 4:
						oGameController.save_file.abilities.dash = true;
			
						oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 220, 0, "Me", ["Just one more to go.", "I wish for... _Dash_! "], function() {
							star_growth = true;
							oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 220, 0, "Me", ["Where's the *next* star, _guard_?"], function() {
								oDialogueManager.start_dialogue(normal_to_gui_x(oNPCTempleGuard.x), normal_to_gui_y(oNPCTempleGuard.y), 220, 0, "Guard", ["Climb *aurora mountains*, located further into the _valleys_."], function() {
									oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 220, 0, "Me", ["Thank _you_!"], function() {});
								});
							});
						});
					break;
				}
        }
    }
}
