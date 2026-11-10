if (global.game_paused) {exit;};

if !dialogue_ongoing {
	player_on_range = point_distance(oPlayer.x, oPlayer.y, x, y) <= range;
	if player_on_range {
		oPlayer.player_dialogue_key_interacting = true;
	}
	player_available = oPlayer.onGround && oPlayer.movement_player_state == MovementPlayerState.CLASSIC;
	if player_on_range && player_available {
		if oPlayer.dialogueKeyPressed {
			if oPlayer.talked_to_mother {
				oDialogueManager.start_dialogue(normal_to_gui_x(x), normal_to_gui_y(y), 320, 0, "Keeper", ["*Oh!* Tell _me_ child, what did *she* say?"], function() {
					oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 280, 0, "Me", ["She told me to give you *this* _note_."], function() {
						oDialogueManager.start_dialogue(normal_to_gui_x(x), normal_to_gui_y(y), 320, 0, "Keeper", ["_Hm_?...", "..._she_..._she has children now_?", "You *hear* that _child_? I'm a _grandfather_...", "_Oh_ my, and his *name* is _Leo_?", "Just *go* with this _star_ child. You *deserve* it."], function() {
							instance_create_layer(336, 144, "Instances", oStar)
							oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 280, 0, "Me", ["Thank you _keeper_!"], function() {
								oDialogueManager.start_dialogue(normal_to_gui_x(x), normal_to_gui_y(y), 320, 0, "Keeper", ["*Bring* it to the _temple_ on the city *outskirts*.", "There, you can _grant_ your *wish*.", "Now _get out_ before this *observatory* is *filled* with my _tears_!"], function() {
									oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 280, 0, "To myself", ["I should _NOT_ have said *that*"], function() {
										oDialogueManager.start_dialogue(normal_to_gui_x(x), normal_to_gui_y(y), 320, 0, "Keeper", ["My *daughter* lives on the *right* side of the _town_.", "Why don't you talk with her and tell me how she's *doing*?", "It's been a *few* _years_ since I talked with her.", "I've been getting too *old* to get up."], function() {
											oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 280, 0, "Me", ["Yeah, _sure_!", "*Sounds easy* _enough_..."], function() {
												dialogue_ongoing = false;
											});
										});
									});
								});
							});
						});
					});
				});
				dialogue_ongoing = true;
			} else if oPlayer.talked_to_mayor {
				oDialogueManager.start_dialogue(normal_to_gui_x(x), normal_to_gui_y(y), 320, 0, "Keeper", ["Don't tell me you're *one* of _them_"], function() {
					oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 280, 0, "Me", ["*Who?*"], function() {
						oDialogueManager.start_dialogue(normal_to_gui_x(x), normal_to_gui_y(y), 320, 0, "Keeper", ["The ones who want my *precious star*"], function() {
							oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 280, 0, "Me", ["I mean I'd like to _help_ you in any way... *For that star*"], function() {
								oDialogueManager.start_dialogue(normal_to_gui_x(x), normal_to_gui_y(y), 320, 0, "Keeper", ["_Any way_ *huh*?"], function() {
									oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 280, 0, "To myself", ["I should _NOT_ have said *that*"], function() {
										oDialogueManager.start_dialogue(normal_to_gui_x(x), normal_to_gui_y(y), 320, 0, "Keeper", ["My *daughter* lives on the *right* side of the _town_.", "Why don't you talk with her and tell me how she's *doing*?", "It's been a *few* _years_ since I talked with her.", "I've been getting too *old* to get up."], function() {
											oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 280, 0, "Me", ["Yeah, _sure_!", "*Sounds easy* _enough_..."], function() {
												dialogue_ongoing = false;
												oPlayer.talked_to_keeper = true;
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
}