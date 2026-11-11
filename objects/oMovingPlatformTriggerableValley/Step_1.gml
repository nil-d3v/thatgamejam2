if (global.game_paused) {exit;};

if !triggered && oPlayer.groundPlatform == id {
    triggered = true;

    movement_timer = 0;
    wait_timer = 0;
    comeback_timer = 0;

    movement_state = 0;
}

if triggered {
    move();
}