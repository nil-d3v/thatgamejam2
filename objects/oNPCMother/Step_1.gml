if (global.game_paused) {exit;};

if !dialogue_ongoing && talk_again_timer <= 0 {
	player_on_range = point_distance(oPlayer.x, oPlayer.y, x, y) <= range;
	if player_on_range {
		oPlayer.player_dialogue_key_interacting = true;
	}
	player_available = oPlayer.onGround && oPlayer.movement_player_state == MovementPlayerState.CLASSIC;
	if player_on_range && player_available && oPlayer.talked_to_child {
		if oPlayer.dialogueKeyPressed && oPlayer.talked_to_mayor {
			oDialogueManager.start_dialogue(normal_to_gui_x(x), normal_to_gui_y(y), 360, 0, "Mother", ["_Yes_?", "What did my _father_ *want*?"], function() {
				oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 360, 0, "Me", ["*Your* father said he *hasn't* _heard_ of you in *years*.", "*He's* wondering _how_ *you're* doing"], function() {
					oDialogueManager.start_dialogue(normal_to_gui_x(x), normal_to_gui_y(y), 360, 0, "Mother", ["Oh... it has _been_ a *while* hasn't it?", "I have *children* now...", "Here. Why don't you take this _note_ back to *him*"], function() {
						oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 360, 0, "Me", ["_Alright_!", "*Apparently* it was _easy_ enough"], function() {
							dialogue_ongoing = false;
							oPlayer.talked_to_mother = true;
							talk_again_timer = talk_again_delay;
						});
					});
				});
			});
			dialogue_ongoing = true;
		}
	}
}

talk_again_timer--;