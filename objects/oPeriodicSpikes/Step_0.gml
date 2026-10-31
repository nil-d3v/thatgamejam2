if timer <= 0 {
	enabled = !enabled;
	timer = enabled ? enabled_time : disabled_time;
}