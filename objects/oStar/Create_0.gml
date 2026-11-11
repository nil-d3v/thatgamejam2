star_id = 1;

was_collected = false;
switch (star_id) {
	case 1:
		if oGameController.save_file.stars_collected.star1 {
			was_collected = true;
		}
	break;
	case 2:
		if oGameController.save_file.stars_collected.star2 {
			was_collected = true;
		}
	break;
	case 3:
		if oGameController.save_file.stars_collected.star3 {
			was_collected = true;
		}
	break;
	case 4:
		if oGameController.save_file.stars_collected.star4 {
			was_collected = true;
		}
	break;
	case 5:
		if oGameController.save_file.stars_collected.star5 {
			was_collected = true;
		}
	break;
}