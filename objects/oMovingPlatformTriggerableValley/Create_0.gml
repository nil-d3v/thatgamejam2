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

xspd = 0;
yspd = 0;

platform_prev_x = x;
platform_prev_y = y;

triggered = false;

movement_state = 0; // 0 : move out / 1 : wait / 2 : move back

function move() {
    platform_prev_x = x;
    platform_prev_y = y;

    switch (movement_state) {

        case 0:
            movement_timer++;

            var t = clamp(
                movement_timer / movement_duration,
                0, 1
            );

            var eased = ease_in_out_cubic(t);

            x = lerp(x_start, x_end, eased);
            y = lerp(y_start, y_end, eased);

            if (movement_timer >= movement_duration) {
                x = x_end;
                y = y_end;

                wait_timer = 0;
                movement_state = 1;
            }
        break;

        case 1:

            wait_timer++;

            if (wait_timer >= wait_duration) {
                comeback_timer = 0;
                movement_state = 2;
            }

        break;

        case 2:
            comeback_timer++;

            var t = clamp(
                comeback_timer / comeback_duration,
                0, 1
            );

            var eased = ease_in_out_cubic(t);

            x = lerp(x_end, x_start, eased);
            y = lerp(y_end, y_start, eased);

            if (comeback_timer >= comeback_duration) {
                x = x_start;
                y = y_start;

                triggered = false;
                movement_state = 0;
            }
        break;
    }

    xspd = x - platform_prev_x;
    yspd = y - platform_prev_y;
}