// Duplicate Check
if instance_number(oGameController) > 1 {
	instance_destroy();
}

// Resize Application Surface
surface_resize(application_surface, 960, 540);

// Save Files
base_save_file = {
	abilities : {
		double_jump : true,
		sprint : true,
		dash : true,
		glide : true
    },
	checkpoint : {
		x_pos : 320,
		y_pos : 596,
		checkpoint_room : MainRoom
    }
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

Load();

show_debug_message("Controller initialized!");
show_debug_message(variable_instance_exists(id, "save_file"));
show_debug_message(is_struct(save_file));