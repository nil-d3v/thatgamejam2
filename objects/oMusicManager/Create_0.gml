if instance_number(oMusicManager) > 1 {
	instance_destroy();
}

global.music_volume = 0.5;

music = -1;
current_music = -1;

loop_music = -1;
current_loop_music = -1;
loop_started = false;

old_music = [];
old_music_timer = [];

fade_time = 500;
crossfade_time = 1000;

function play_music(_intro_music, _loop_music, _restart = false, _volume = 1) {
	if current_music != _intro_music || current_loop_music != _loop_music || _restart || !audio_is_playing(music) {
		current_music = _intro_music;
		current_loop_music = _loop_music;
		current_music_volume = _volume;
		loop_started = false;

		if audio_is_playing(music) {
			audio_sound_gain(music, 0, fade_time);
			array_push(old_music, music);
			array_push(old_music_timer, ceil(fade_time / (1000 / 60)));
		}

		if audio_is_playing(loop_music) {
			audio_sound_gain(loop_music, 0, fade_time);
			array_push(old_music, loop_music);
			array_push(old_music_timer, ceil(fade_time / (1000 / 60)));
		}

		music = audio_play_sound(_intro_music, 0, false);
		audio_sound_gain(music, global.music_volume * current_music_volume, fade_time);

		loop_music = -1;
	}
}