x_start = x;
y_start = y;
x_end = 0;
y_end = 0;
movement_duration = 0;
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
	xspd = (x_end - x_start) / movement_duration * movement_direction;
	yspd = (y_end - y_start) / movement_duration * movement_direction;
	platform_prev_x = x;
	platform_prev_y = y;
	x += xspd;
	y += yspd;
}