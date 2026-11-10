if (global.game_paused) {exit;};

if oPlayer.collected_valley_note {
	if !dialogue_ongoing && point_distance(oPlayer.x, oPlayer.y, x, y) <= range {
		oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 360, 0, "Me", ["_Hey_, I *found* it!"], function() {
			oDialogueManager.start_dialogue(normal_to_gui_x(x), normal_to_gui_y(y), 360, 0, "Mae", ["_Bao_ seems to *like* it. You can _have_ the _star_"], function() {
				instance_create_layer(288, 152, "Instances", oStar)
				oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 360, 0, "Me", ["Thank you _keeper_!"], function() {
					oDialogueManager.start_dialogue(normal_to_gui_x(x), normal_to_gui_y(y), 360, 0, "Mae", ["Be *careful with* it!"], function() {
						oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 360, 0, "Me", ["_Sure will_", "*thank you*... and _Bao_!"], function() {
							dialogue_ongoing = false;
						});
					});
				});
			});
		});
		dialogue_ongoing = true;
	}
} else {
	dialogue_timer++
	if !dialogue_ongoing && point_distance(oPlayer.x, oPlayer.y, x, y) <= range {
		oDialogueManager.start_dialogue(normal_to_gui_x(x), normal_to_gui_y(y), 360, 0, "Me", ["_Hellooo_?"], function() {
			oDialogueManager.start_dialogue(normal_to_gui_x(oNPCMae.x), normal_to_gui_y(oNPCMae.y), 360, 0, "Mae", ["*Oh*.. a _visitor_. Look _Bao_!"], function() {
				oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 360, 0, "Me", ["Hello!", "Do *you* have a _star_ by *chance*?"], function() {
					oDialogueManager.start_dialogue(normal_to_gui_x(oNPCMae.x), normal_to_gui_y(oNPCMae.y), 360, 0, "Mae", ["_Yes_! But _Bao_ told *me* to _keep_ it."], function() {
						oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 360, 0, "Me", ["*Huh*... who's _Bao_?"], function() {
							oDialogueManager.start_dialogue(normal_to_gui_x(oNPCMae.x), normal_to_gui_y(oNPCMae.y), 360, 0, "Mae", ["*Let* me _guess_, you can't see _him_.", "..._Whatever_"], function() {
								oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 360, 0, "Me", ["*Weird*", "_How_ do I *get* that *star* then?"], function() {
									oDialogueManager.start_dialogue(normal_to_gui_x(oNPCMae.x), normal_to_gui_y(oNPCMae.y), 360, 0, "Mae", ["_Easy_. Look through the *houses*. There is a _note_ in one.", "I _NEED_ that *note*"], function() {
										oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 360, 0, "Me", ["*Ok*..."], function() {
											dialogue_ongoing = false;
										});
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


