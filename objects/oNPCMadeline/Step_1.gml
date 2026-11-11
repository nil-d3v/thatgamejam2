if (global.game_paused) {exit;};

if !dialogue_ongoing && talk_again_timer <= 0 {
	player_on_range = point_distance(oPlayer.x, oPlayer.y, x, y) <= range;
	if player_on_range {
		oPlayer.player_dialogue_key_interacting = true;
	}
	player_available = oPlayer.onGround && oPlayer.movement_player_state == MovementPlayerState.CLASSIC;
	if player_on_range && player_available {
		if oPlayer.dialogueKeyPressed {
			oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 360, 0, "Me", ["That was _exhausting_"], function() {
				oDialogueManager.start_dialogue(normal_to_gui_x(x), normal_to_gui_y(y), 360, 0, "Madeline", ["*Huh*... _you_ *finally* made it up *here*"], function() {
					oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 360, 0, "Me", ["_How_ do you _know me_?"], function() {
						oDialogueManager.start_dialogue(normal_to_gui_x(x), normal_to_gui_y(y), 360, 0, "Madeline", ["I've been tracking _your_ *movements*. _Don't worry_ *about it*", "_Oh_! And I *almost forgot*. Here is your _deserving star_!"], function() {
							var _inst = instance_create_layer(376, 160, "Instances", oStar);
							_inst.star_id = 5;
							oDialogueManager.start_dialogue(normal_to_gui_x(x), normal_to_gui_y(y), 360, 0, "Madeline", ["_Go_ and _restore_ the _temple_ *now* would *you*"], function() {
								oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 360, 0, "Me", ["*Thank* _you_!", "*How* do I get _down_ here _now_?"], function() {
									oDialogueManager.start_dialogue(normal_to_gui_x(x), normal_to_gui_y(y), 360, 0, "Madeline", ["Just _glide_ *down* from the _cliff_"], function() {
										oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 360, 0, "Me", ["_Alright_!"], function() {
											dialogue_ongoing = false;
											talk_again_timer = talk_again_delay;
										});
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