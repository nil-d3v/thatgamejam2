transition_started = false;

transition_room = noone;
transition_x = 0;
transition_y = 0;

function check() {
    if (transition_started) return;
    if (oPlayer.main_player_state != MainPlayerState.NORMAL) return;

    if (place_meeting(x, y, oPlayer)) {
        transition_started = true;

        oPlayer.start_subarea_transition();

        if (transition_room != EndScreen) {
            oGameController.save_file.checkpoint.x_pos = transition_x;
            oGameController.save_file.checkpoint.y_pos = transition_y;
            oGameController.save_file.checkpoint.checkpoint_room = transition_room;
            oGameController.Save();
        }

        room_transition(transition_room, tr_spotlight, 60);
    }
}