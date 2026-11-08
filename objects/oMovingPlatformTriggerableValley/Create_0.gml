x_start = x;
y_start = y;
x_end = x;
y_end = 180;
movement_duration = 300;
comeback_duration = 120;
wait_duration = 300;
movement_timer = 0;
comeback_timer = 0;
wait_timer = 0;
movement_direction = 1;

xspd = 0;
yspd = 0;
platform_prev_x = x;
platform_prev_y = y;

triggered = false;

function move() {
	movement_timer--;
	if movement_timer <= 0 {
		wait_timer = wait_duration;
	}
	wait_timer--;
	if movement_timer <= 0 || wait_timer <= 0 {
		comeback_timer = comeback_duration;
		movement_direction *= -1;
	}
	comeback_timer--;
	if movement_timer <= 0 || wait_timer <= 0 || comeback_timer <= 0 {
		triggered = false;
		movement_direction *= -1;
	}
	platform_prev_x = x;
	platform_prev_y = y;
	if movement_timer > 0 {
		x = movement_direction > 0 ? x_start + (x_end - x_start) * ease_in_out_cubic(movement_timer / movement_duration) : x_end + (x_start - x_end) * ease_in_out_cubic(movement_timer / movement_duration);
		y = movement_direction > 0 ? y_start + (y_end - y_start) * ease_in_out_cubic(movement_timer / movement_duration) : y_end + (y_start - y_end) * ease_in_out_cubic(movement_timer / movement_duration);
	} else if comeback_timer > 0{
		x = movement_direction > 0 ? x_start + (x_end - x_start) * ease_in_out_cubic(comeback_timer / movement_duration) : x_end + (x_start - x_end) * ease_in_out_cubic(comeback_timer / movement_duration);
		y = movement_direction > 0 ? y_start + (y_end - y_start) * ease_in_out_cubic(comeback_timer / movement_duration) : y_end + (y_start - y_end) * ease_in_out_cubic(comeback_timer / movement_duration);
	}
	xspd = x - platform_prev_x;
	yspd = y - platform_prev_y;
}