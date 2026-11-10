dialogue_timer++;
if dialogue_timer == 120 {
	oDialogueManager.start_dialogue(normal_to_gui_x(player_xpos), normal_to_gui_y(player_ypos), 360, 0, "Me", ["This was _actually_ pretty *fun*.", "I made someone a grandfather...", "I *had fun* with branches...", "*Discovered* a new site...", "Brought back _memories_ to *someone*..." ,"And climbed the *steepest* _mountain_?", "_Damn me._", "*Now*, maybe _not_ *everyone* will think I'm a _freak_.", "_Maybe_ *they'll* _find space_ cool too."], function() {
		oDialogueManager.start_dialogue(normal_to_gui_x(259), normal_to_gui_y(179), 360, 0, "Nil", ["_So_... what do *you* _wish_ for? "], function() {
			oDialogueManager.start_dialogue(normal_to_gui_x(player_xpos), normal_to_gui_y(player_ypos), 360, 0, "Me", ["_Hmm_...", "What about..."], function() {
				credits_started = true;
			});
		});
	});
}

if credits_started {
	if current_text <= array_length(texts) - 1 {
		text_timer++
		if text_timer >= times[current_text] {
			if alpha_decrease_finished {
				text_alpha += 0.1;
				if text_alpha >= 1 {
					alpha_decrease_finished = false;
					text_timer = 0;
				}
			} else if current_text < array_length(texts) - 1 {
				text_alpha -= 0.1;
				if text_alpha <= 0 {
					alpha_decrease_finished = true;
					current_text = min(current_text + 1, array_length(texts) - 1);
				}
			}
		}
	}
}

if credits_started && current_text >= array_length(texts) - 1 && keyboard_check_pressed(vk_anykey) {
	room_transition(MainMenu, tr_spotlight, 60);
}