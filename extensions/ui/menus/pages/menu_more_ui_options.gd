extends VBoxContainer

const MORE_UI_SAVE_FILE = "user://save_file.save"
var more_ui_save_data  = {}

signal back_button_pressed
signal more_ui_setting_changed(setting_name, value)

onready var back_button = $BackButton
onready var check_whats_new = $WhatsNewModeEnabled

# Called when the node enters the scene tree for the first time.
func _ready():
	var MoreUIConfigInterface = get_node("/root/ModLoader/MincedMeatMole-MoreUI/MoreUIConfigInterface")	
	
	connect("more_ui_setting_changed", MoreUIConfigInterface, "on_more_ui_setting_changed")

func init():
	$BackButton.grab_focus()
	
	_more_ui_load_data()
	check_whats_new.pressed = more_ui_save_data.whats_new_mode_enabled
	check_whats_new.connect("toggled", self, "moreui_signal_setting_changed", ["whats_new_mode_enabled"])

func _more_ui_save_data():
	var file = File.new()
	file.open(MORE_UI_SAVE_FILE, File.WRITE)
	file.store_var(more_ui_save_data)
	file.close()


func _more_ui_load_data():
	var file = File.new()
	if not file.file_exists(MORE_UI_SAVE_FILE):
		more_ui_save_data = {
			"whats_new_mode_enabled": true
		}
		_more_ui_save_data()
	file.open(MORE_UI_SAVE_FILE, File.READ)
	more_ui_save_data = file.get_var()
	file.close()

func moreui_signal_setting_changed(value, setting_name:String):
	more_ui_save_data[setting_name] = value
	_more_ui_save_data()
	emit_signal("more_ui_setting_changed", setting_name, value)


func _on_BackButton_pressed():
	emit_signal("back_button_pressed")
