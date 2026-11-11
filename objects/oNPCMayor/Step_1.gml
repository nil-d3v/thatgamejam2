if (global.game_paused) {exit;};

if !dialogue_ongoing && talk_again_timer <= 0 {
	player_on_range = point_distance(oPlayer.x, oPlayer.y, x, y) <= range;
	if player_on_range {
		oPlayer.player_dialogue_key_interacting = true;
	}
	player_available = oPlayer.onGround && oPlayer.movement_player_state == MovementPlayerState.CLASSIC;
	if player_on_range && player_available {
		if oPlayer.dialogueKeyPressed {
			oDialogueManager.start_dialogue(normal_to_gui_x(x), normal_to_gui_y(y), 220, 0, "Mayor", ["What would *you* like to _ask_?"], function() {
				oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 240, 0, "Me", ["I want to help find the stars!"], function() {
					oDialogueManager.start_dialogue(normal_to_gui_x(x), normal_to_gui_y(y), 220, 0, "Mayor", ["_Really_? _You_? I never even *heard* about *you*."], function() {
						oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 240, 0, "Me", ["*Rude...*", "_Yeah_, I just need help in finding the *first* star please!"], function() {
							oDialogueManager.start_dialogue(normal_to_gui_x(x), normal_to_gui_y(y), 220, 0, "Mayor", ["_Really_? _YOU_ think you can find *all* 5 stars?", "I mean I guess I'll agree to *willing volunteers*.", "The first star is with the old *keeper* in the observatory.", "Be _careful_... He is really *persistent* on getting some _message_ or something."], function() {
								oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 240, 0, "Me", ["And... _where's_ that?"], function() {
									oDialogueManager.start_dialogue(normal_to_gui_x(x), normal_to_gui_y(y), 220, 0, "Mayor", ["_REALLY_?", "It's a _big_ structure on *top* of the city.", "Just _climb_ up the stairs or something."], function() {
										dialogue_ongoing = false;
										oPlayer.talked_to_mayor = true;
										talk_again_timer = talk_again_delay;
									});
								});
							});
						});
					});
				});
			});
			dialogue_ongoing = true;
		}
	}
}

talk_again_timer--;