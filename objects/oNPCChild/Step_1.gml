if (global.game_paused) {exit;};

dialogue_timer++
if !dialogue_ongoing && !dialogue_done && dialogue_timer >= 60 && oPlayer.talked_to_keeper && !oPlayer.talked_to_child {
	oDialogueManager.start_dialogue(normal_to_gui_x(x), normal_to_gui_y(y), 360, 0, "Child", ["*Mom*, _someone came_!"], function() {
		oDialogueManager.start_dialogue(normal_to_gui_x(oNPCMother.x), normal_to_gui_y(oNPCMother.y), 360, 0, "Mother", ["_Geez_, who are you?"], function() {
			oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 360, 0, "Me", ["...Your _father_ sent me here"], function() {
				oDialogueManager.start_dialogue(normal_to_gui_x(oNPCMother.x), normal_to_gui_y(oNPCMother.y), 360, 0, "Mother", ["Where are *your* _manners_, don't you know how to *knock* on a _door_?"], function() {
					oDialogueManager.start_dialogue(normal_to_gui_x(oPlayer.x), normal_to_gui_y(oPlayer.y - oPlayer.dialogue_y_offset), 360, 0, "Me", ["*Sorry*..."], function() {
						dialogue_ongoing = false;
						oPlayer.talked_to_child = true;
					});
				});
			});
		});
	});
	dialogue_ongoing = true;
}