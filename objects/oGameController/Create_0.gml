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
		double_jump : true,
		sprint : true,
		dash : true,
		glide : true
    },
	checkpoint : {
		x_pos : 2720,
		y_pos : 596,
		checkpoint_room : RoomAurelia
    },
	stats : {
		deaths : 0,
		timer : 0
    },
	stars : 0
};

save_slot_index = 1;

save_file = {};

function SaveFile() : SSave("save") constructor {
    add_value("data", SSAVE_TYPE.STRUCT, oGameController.base_save_file);
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
    _save.reset("data");
}

function SetSlotIndex(_slotIndex) {
    Save();
    save_slot_index = _slotIndex;
    Load();
}

Wipe();
Load();