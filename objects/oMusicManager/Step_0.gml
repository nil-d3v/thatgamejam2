// music playing logic


if !loop_started && music != -1 {
	if audio_is_playing(music) {
		if audio_sound_get_track_position(music) >= audio_sound_length(current_music) - (crossfade_time / 1000) {
			loop_music = audio_play_sound(current_loop_music, 0, true);
			audio_sound_gain(loop_music, 0, 0);
			audio_sound_gain(loop_music, global.music_volume * current_music_volume, crossfade_time);
			loop_started = true;
		}
	}
}

for (var i = array_length(old_music) - 1; i >= 0; i--) {
	old_music_timer[i]--;
	if old_music_timer[i] <= 0 {
		audio_stop_sound(old_music[i]);
		array_delete(old_music, i, 1);
		array_delete(old_music_timer, i, 1);
	}
}
