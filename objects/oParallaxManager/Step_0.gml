var cam_x = camera_get_view_x(view_camera[0]);
var cam_y = camera_get_view_y(view_camera[0]);

var dx = cam_x - cam_start_x;
var dy = cam_y - cam_start_y;

layer_x(layer_1, layer_get_x(layer_1) + dx * parallax_1);
layer_y(layer_1, layer_get_y(layer_1) + dy * parallax_1);

layer_x(layer_2, layer_get_x(layer_2) + dx * parallax_2);
layer_y(layer_2, layer_get_y(layer_2) + dy * parallax_2);

cam_start_x = cam_x;
cam_start_y = cam_y;