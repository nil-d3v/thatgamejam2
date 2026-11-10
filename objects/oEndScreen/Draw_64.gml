// Credits
draw_set_color(c_white)
draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_set_alpha(text_alpha);
draw_set_font(fEndScreenCredits)

draw_text(normal_to_gui_x(480 / 2), normal_to_gui_y(102), texts[current_text])

draw_set_font(-1)
draw_set_alpha(1);
draw_set_color(c_white)
draw_set_halign(fa_left)
draw_set_valign(fa_top)

// Prompt
if credits_started && current_text >= array_length(texts) - 1 {
	draw_set_color(c_white)
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	draw_set_alpha(text_alpha);
	draw_set_font(fEndScreenPrompt)

	draw_text(normal_to_gui_x(480 / 2), normal_to_gui_y(246), "Press any key to return to the main menu.")

	draw_set_font(-1)
	draw_set_alpha(1);
	draw_set_color(c_white)
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
}