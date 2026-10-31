global.sfx_volume = 0.5;

function play_sfx(_snd, _vol = 1, _random_pitch = true, _pitch_min = 0.9, _pitch_max = 1.1, _loop = false) {
    if !audio_exists(_snd) {
		return -1;
	}

    var _global_vol = global.sfx_volume;
    var _final_vol = clamp(_vol * _global_vol, 0, 1);
    var _pitch = 1;

    if (_random_pitch) {
        _pitch = random_range(_pitch_min, _pitch_max);
    }

    var _inst = audio_play_sound(_snd, 1, _loop);
    audio_sound_gain(_inst, _final_vol, 0);
    audio_sound_pitch(_inst, _pitch);

    return _inst;
}