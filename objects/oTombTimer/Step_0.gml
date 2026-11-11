if (global.game_paused) {exit;};

if place_meeting(x, y, oPlayer) {
	timer = 30 * 60;
	triggered = true;
}

if triggered {
	timer--;
}

if triggered && timer < (120) {
	oTombClosingThornsLeft.x = oTombClosingThornsLeft.xstart - thorns_offset * clamp(timer / 120, 0, 1)
	oTombClosingThornsRight.x = oTombClosingThornsRight.xstart + thorns_offset * clamp(timer / 120, 0, 1)
} else {
	oTombClosingThornsLeft.x = oTombClosingThornsLeft.xstart - thorns_offset;
	oTombClosingThornsRight.x = oTombClosingThornsRight.xstart + thorns_offset;
}