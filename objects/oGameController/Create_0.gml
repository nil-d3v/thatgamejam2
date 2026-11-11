// Duplicate Check
if instance_number(oGameController) > 1 {
	instance_destroy();
}

// Resize Application Surface
surface_resize(application_surface, 960, 540);

// Pause
global.game_paused = false;

// Save Files
base_save_file = {
	abilities : {
		double_jump : false,
		sprint : false,
		dash : false,
		glide : false
    },
	checkpoint : {
		x_pos : 225,
		y_pos : 235,
		checkpoint_room : SubareaPlayerRoom
    },
	stats : {
		deaths : 0,
		timer : 0
    },
	stars_collected : {
		star1 : false,
		star2 : false,
		star3 : false,
		star4 : false,
		star5 : false
    },
	stars : 0,
	star_carried : false,
	intro_dialogue_done : false
};

save_slot_index = 1;

save_file = {};

function SaveFile() : SSave("save") constructor {
	add_value("data", SSAVE_TYPE.STRUCT, variable_clone(oGameController.base_save_file));
}

function Save() {
    var _save = ssave_get(SaveFile, save_slot_index);
    _save.set("data", save_file);
    _save.save();
}

function Load() {
    var _save = ssave_get(SaveFile, save_slot_index);
    save_file = _save.get("data");
}

function Wipe() {
    var _save = ssave_get(SaveFile, save_slot_index);
    save_file = variable_clone(base_save_file);
    _save.set("data", save_file);
    _save.save();
    Load();
}

function SetSlotIndex(_slotIndex) {
    save_slot_index = _slotIndex;
    Load();
}

// Debug
//SetSlotIndex(1);
//Wipe();
//SetSlotIndex(2);
//Wipe();
//SetSlotIndex(3);
//Wipe();

Load();