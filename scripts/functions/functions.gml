function db(_message) {
	show_debug_message(_message);
}

function approach(_value, _target, _amount) {
	if (_value < _target) return min(_value + _amount, _target);
	if (_value > _target) return max(_value - _amount, _target);
	return _target;
}

function normal_to_gui_x(_x) {
	var _xpercent = (_x - camera_get_view_x(view_camera[0])) / camera_get_view_width(view_camera[0]);
	return _xpercent * display_get_gui_width();
}

function normal_to_gui_y(_y) {
	var _ypercent = (_y - camera_get_view_y(view_camera[0])) / camera_get_view_height(view_camera[0]);
	return _ypercent * display_get_gui_height();
}

function ease_in_out_cubic(_n) {
	return _n < 0.5 ? 4 * _n * _n * _n : 1 - power(-2 * _n + 2, 3) / 2;
}