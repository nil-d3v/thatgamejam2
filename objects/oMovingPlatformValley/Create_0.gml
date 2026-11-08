x_start = x;
y_start = y;
x_end = x;
y_end = 180;
movement_duration = 180;
movement_timer = movement_duration;
movement_direction = 1;

xspd = 0;
yspd = 0;
platform_prev_x = x;
platform_prev_y = y;

function move() {
	if movement_timer <= 0 {
		movement_timer = movement_duration;
		movement_direction *= -1;
	}
	movement_timer--;
	platform_prev_x = x;
	platform_prev_y = y;
	x = movement_direction > 0 ? x_start + (x_end - x_start) * ease_in_out_cubic(movement_timer / movement_duration) : x_end + (x_start - x_end) * ease_in_out_cubic(movement_timer / movement_duration);
	y = movement_direction > 0 ? y_start + (y_end - y_start) * ease_in_out_cubic(movement_timer / movement_duration) : y_end + (y_start - y_end) * ease_in_out_cubic(movement_timer / movement_duration);
	xspd = x - platform_prev_x;
	yspd = y - platform_prev_y;
}