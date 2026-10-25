function db(_message) {
	show_debug_message(_message);
}

function approach(_value, _target, _amount) {
	if (_value < _target) return min(_value + _amount, _target);
	if (_value > _target) return max(_value - _amount, _target);
	return _target;
}