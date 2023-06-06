extends "res://ui/hud/ui_wave_timer.gd"

onready var moreui_hud: MarginContainer = get_tree().get_current_scene().get_node("UI/HUD")
const MORE_UI_SAVE_FILE = "user://save_file.save"
var more_ui_save_data  = {}

var more_ui_container
var _more_ui_timer = null
var _whats_new_mode_enabled = false
var _wave_increase_enabled = false
var _right_side_enabled = false
var _value_prefix = ""
var _value_suffix = ""

var max_hp_field: RichTextLabel
var hp_regen_field: RichTextLabel
var lifesteal_field: RichTextLabel
var damage_field: RichTextLabel
var melee_damage_field: RichTextLabel
var ranged_damage_field: RichTextLabel
var elemental_damage_field: RichTextLabel
var attack_speed_field: RichTextLabel
var crit_chance_field: RichTextLabel
var engineering_field: RichTextLabel
var range_field: RichTextLabel
var armor_field: RichTextLabel
var dodge_field: RichTextLabel
var speed_field: RichTextLabel
var luck_field: RichTextLabel
var harvesting_field: RichTextLabel

var max_hp_field_control: Control
var hp_regen_field_control: Control
var lifesteal_field_control: Control
var damage_field_control: Control
var melee_damage_field_control: Control
var ranged_damage_field_control: Control
var elemental_damage_field_control: Control
var attack_speed_field_control: Control
var crit_chance_field_control: Control
var engineering_field_control: Control
var range_field_control: Control
var armor_field_control: Control
var dodge_field_control: Control
var speed_field_control: Control
var luck_field_control: Control
var harvesting_field_control: Control

var inital_max_hp: int
var inital_hp_regen: int
var inital_lifesteal: int
var inital_damage: int
var inital_melee_damage: int
var inital_ranged_damage: int
var inital_elemental_damage: int
var inital_attack_speed: int
var inital_crit_chance: int
var inital_engineering: int
var inital_range: int
var inital_armor: int
var inital_dodge: int
var inital_speed: int
var inital_luck: int
var inital_harvesting: int
		
func _ready()->void:
	_more_ui_load_data()
	var MoreUIConfigInterface = get_node("/root/ModLoader/MincedMeatMole-MoreUI/MoreUIConfigInterface")
	MoreUIConfigInterface.connect("more_ui_setting_changed", self, "_on_more_ui_setting_changed")
	if not "whats_new_mode_enabled" in more_ui_save_data:
		more_ui_save_data.whats_new_mode_enabled = true
	if not "wave_increase_enabled" in more_ui_save_data:
		more_ui_save_data.wave_increase_enabled = false
	if not "right_side_enabled" in more_ui_save_data:
		more_ui_save_data.right_side_enabled = false
	_whats_new_mode_enabled = more_ui_save_data.whats_new_mode_enabled
	_wave_increase_enabled = more_ui_save_data.wave_increase_enabled
	_right_side_enabled = more_ui_save_data.right_side_enabled

	more_ui_container = preload("res://mods-unpacked/MincedMeatMole-MoreUI/ui/hud/more_ui.tscn").instance()
	moreui_hud.margin_bottom = 0
	moreui_hud.anchor_bottom = 1
	moreui_hud.call_deferred("add_child", more_ui_container)
	moreui_hud.mouse_filter = MOUSE_FILTER_IGNORE
	
	max_hp_field = more_ui_container.get_node("%More_UI_MaxHP")
	hp_regen_field = more_ui_container.get_node("%More_UI_HP_Regen")
	lifesteal_field = more_ui_container.get_node("%More_UI_LifeSteal")
	damage_field = more_ui_container.get_node("%More_UI_Damage")
	melee_damage_field = more_ui_container.get_node("%More_UI_MeleeDamage")
	ranged_damage_field = more_ui_container.get_node("%More_UI_RangedDamage")
	elemental_damage_field = more_ui_container.get_node("%More_UI_ElementalDamage")
	attack_speed_field = more_ui_container.get_node("%More_UI_AttackSpeed")
	crit_chance_field = more_ui_container.get_node("%More_UI_CritChance")
	engineering_field = more_ui_container.get_node("%More_UI_Engineering")
	range_field = more_ui_container.get_node("%More_UI_Range")
	armor_field = more_ui_container.get_node("%More_UI_Armor")
	dodge_field = more_ui_container.get_node("%More_UI_Dodge")
	speed_field = more_ui_container.get_node("%More_UI_Speed")
	luck_field = more_ui_container.get_node("%More_UI_Luck")
	harvesting_field = more_ui_container.get_node("%More_UI_Harvesting")

	max_hp_field_control = more_ui_container.get_node("%MoreUI_MaxHPControl")
	hp_regen_field_control = more_ui_container.get_node("%MoreUI_HPRegenControl")
	lifesteal_field_control = more_ui_container.get_node("%MoreUI_LifeStealControl")
	damage_field_control = more_ui_container.get_node("%MoreUI_DamageControl")
	melee_damage_field_control = more_ui_container.get_node("%MoreUI_MeleeDamageControl")
	ranged_damage_field_control = more_ui_container.get_node("%MoreUI_RangedDamageControl")
	elemental_damage_field_control = more_ui_container.get_node("%MoreUI_ElementalDamageControl")
	attack_speed_field_control = more_ui_container.get_node("%MoreUI_AttackSpeedControl")
	crit_chance_field_control = more_ui_container.get_node("%MoreUI_CritChanceControl")
	engineering_field_control = more_ui_container.get_node("%MoreUI_EngineeringControl")
	range_field_control = more_ui_container.get_node("%MoreUI_RangeControl")
	armor_field_control = more_ui_container.get_node("%MoreUI_ArmorControl")
	dodge_field_control = more_ui_container.get_node("%MoreUI_DodgeControl")
	speed_field_control = more_ui_container.get_node("%MoreUI_SpeedControl")
	luck_field_control = more_ui_container.get_node("%MoreUI_LuckControl")
	harvesting_field_control = more_ui_container.get_node("%MoreUI_HarvestingControl")
	
	if (_right_side_enabled):
		_align_ui_to_right()
		
	_more_ui_timer = Timer.new()
	add_child(_more_ui_timer)
	_more_ui_timer.connect("timeout", self, "_update_stats_ui")
	_more_ui_timer.set_one_shot(false) # Make sure it loops
	_more_ui_timer.set_wait_time(0.5)
	_more_ui_timer.start()
	
	if (_whats_new_mode_enabled):
		_toggle_control_visbility(false)	
	if (_whats_new_mode_enabled || _wave_increase_enabled):
		var t = Timer.new()
		t.set_wait_time(.2)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		inital_max_hp = floor(Utils.get_stat('stat_max_hp'))
		inital_hp_regen = floor(Utils.get_stat('stat_hp_regeneration'))
		inital_lifesteal = floor(Utils.get_stat('stat_lifesteal'))
		inital_damage = floor(Utils.get_stat('stat_percent_damage'))
		inital_melee_damage = floor(Utils.get_stat('stat_melee_damage'))
		inital_ranged_damage = floor(Utils.get_stat('stat_ranged_damage'))
		inital_elemental_damage = floor(Utils.get_stat('stat_elemental_damage'))
		inital_attack_speed = floor(Utils.get_stat('stat_attack_speed'))
		inital_crit_chance = floor(Utils.get_stat('stat_crit_chance'))
		inital_engineering = floor(Utils.get_stat('stat_engineering'))
		inital_range = floor(Utils.get_stat('stat_range'))
		inital_armor = floor(Utils.get_stat('stat_armor'))
		inital_dodge = floor(Utils.get_stat('stat_dodge'))
		inital_speed = floor(Utils.get_stat('stat_speed'))
		inital_luck = floor(Utils.get_stat('stat_luck'))
		inital_harvesting = floor(Utils.get_stat('stat_harvesting'))
	
	_update_stats_ui()
	
	
func _update_stats_ui():
	
	if wave_timer != null and is_instance_valid(wave_timer) and not is_run_lost:
		var time = ceil(wave_timer.time_left)
		if time > 0:
			more_ui_container.visible = true
		else:
			more_ui_container.visible = false
			return
	
	_update_single_field(hp_regen_field, 'stat_hp_regeneration', inital_hp_regen, hp_regen_field_control)
	_update_single_field(lifesteal_field, 'stat_lifesteal', inital_lifesteal, lifesteal_field_control)
	_update_single_field(damage_field,'stat_percent_damage', inital_damage, damage_field_control)
	_update_single_field(melee_damage_field, 'stat_melee_damage', inital_melee_damage, melee_damage_field_control)
	_update_single_field(ranged_damage_field, 'stat_ranged_damage', inital_ranged_damage, ranged_damage_field_control)
	_update_single_field(elemental_damage_field, 'stat_elemental_damage', inital_elemental_damage, elemental_damage_field_control)
	_update_single_field(attack_speed_field, 'stat_attack_speed', inital_attack_speed, attack_speed_field_control)
	_update_single_field(crit_chance_field, 'stat_crit_chance', inital_crit_chance, crit_chance_field_control)
	_update_single_field(engineering_field, 'stat_engineering', inital_engineering, engineering_field_control)
	_update_single_field(range_field, 'stat_range', inital_range, range_field_control)
	_update_single_field(armor_field, 'stat_armor', inital_armor, armor_field_control)
	_update_single_field(speed_field, 'stat_speed', inital_speed, speed_field_control)
	_update_single_field(luck_field, 'stat_luck', inital_luck, luck_field_control)
	_update_single_field(harvesting_field, 'stat_harvesting', inital_harvesting, harvesting_field_control)
	
	if dodge_field != null:
		var dodgeValue = floor(Utils.get_stat('stat_dodge'))
		var maxDodge = Utils.get_stat('dodge_cap') - 120
		var dodgeString = str(dodgeValue);
		if (dodgeValue >= maxDodge):
			dodgeString += ' | ' + str(maxDodge)
			
		var change = dodgeValue - inital_dodge
		if (_wave_increase_enabled and change != 0):
			dodgeString += " [color=" + _get_value_color(change) + "]("
			if (change > 0):
				dodgeString += "+"
			dodgeString += str(change)
			dodgeString += ")[/color] "
			
		dodge_field.bbcode_text = _value_prefix + "[color=" + _get_value_color(dodgeValue) + "]" + dodgeString + "[/color]" + _value_suffix
		if (_whats_new_mode_enabled && dodgeValue != inital_dodge):
			dodge_field_control.visible = true
	if max_hp_field != null:
		var maxHPValue = floor(Utils.get_stat('stat_max_hp'))
		var maxHPString = str(maxHPValue);
		var maxHPCap = Utils.get_stat('hp_cap');
		if (maxHPValue >= maxHPCap && maxHPCap != 999999):
			maxHPString += ' | ' + str(maxHPCap)
			
		var change = maxHPValue - inital_max_hp;
		if (_wave_increase_enabled and change != 0):
			maxHPString += " [color=" + _get_value_color(change) + "]("
			if (change > 0):
				maxHPString += "+"
			maxHPString += str(change)
			maxHPString += ")[/color] "
			
		max_hp_field.bbcode_text = _value_prefix + "[color=" + _get_value_color(maxHPValue) + "]" + maxHPString + "[/color]" + _value_suffix
		if (_whats_new_mode_enabled && maxHPValue != inital_max_hp):
			max_hp_field_control.visible = true

func _update_single_field(field,stat_name,initial_value,control):
	if field != null:
		var value = floor(Utils.get_stat(stat_name))
		var output = str(value)
		var change = value - initial_value;
		if (_wave_increase_enabled and change != 0):
			output += " [color=" + _get_value_color(change) + "]("
			if (change > 0):
				output += "+"
			output += str(change)
			output += ")[/color] "
		field.bbcode_text = _value_prefix + "[color=" + _get_value_color(value) + "]" + output  + "[/color]" + _value_suffix
		if (_whats_new_mode_enabled && value != initial_value):
			control.visible = true

func _get_value_color(value):
	if (value > 0):
		return "#00ff00"
	elif (value < 0):
		return "#ff0000"
	else:
		return "#fff"
		
func _on_more_ui_setting_changed(setting_name:String, value):
	if setting_name == "whats_new_mode_enabled" and value is bool:
		_set_whats_new_mode(value)
	if setting_name == "wave_increase_enabled" and value is bool:
		_set_wave_increase_enabled(value)
	if setting_name == "right_side_enabled" and value is bool:
		_set_right_side_enabled(value)


func _set_whats_new_mode(mode_enabled:bool):
	_whats_new_mode_enabled = mode_enabled
	if (_whats_new_mode_enabled):
		_toggle_control_visbility(false)
	else:
		_toggle_control_visbility(true)
		
func _set_wave_increase_enabled(value:bool):
	_wave_increase_enabled = value

func _set_right_side_enabled(value:bool):
	_right_side_enabled = value
	if (_right_side_enabled):
		_align_ui_to_right()
	else:
		_align_ui_to_left()
	_update_stats_ui()

func _toggle_control_visbility(onoff:bool):
	if max_hp_field_control != null:
		max_hp_field_control.visible = onoff
	if hp_regen_field_control != null:
		hp_regen_field_control.visible = onoff
	if lifesteal_field_control != null:
		lifesteal_field_control.visible = onoff
	if damage_field_control != null:
		damage_field_control.visible = onoff
	if melee_damage_field_control != null:
		melee_damage_field_control.visible = onoff
	if ranged_damage_field_control != null:
		ranged_damage_field_control.visible = onoff
	if elemental_damage_field_control != null:
		elemental_damage_field_control.visible = onoff
	if attack_speed_field_control != null:
		attack_speed_field_control.visible = onoff
	if crit_chance_field_control != null:
		crit_chance_field_control.visible = onoff
	if engineering_field_control != null:
		engineering_field_control.visible = onoff
	if range_field_control != null:
		range_field_control.visible = onoff
	if armor_field_control != null:
		armor_field_control.visible = onoff
	if dodge_field_control != null:
		dodge_field_control.visible = onoff
	if speed_field_control != null:
		speed_field_control.visible = onoff
	if luck_field_control != null:
		luck_field_control.visible = onoff
	if harvesting_field_control != null:
		harvesting_field_control.visible = onoff

func _more_ui_save_data():
	var file = File.new()
	file.open(MORE_UI_SAVE_FILE, File.WRITE)
	file.store_var(more_ui_save_data)
	file.close()


func _more_ui_load_data():
	var file = File.new()
	if not file.file_exists(MORE_UI_SAVE_FILE):
		more_ui_save_data = {
			"whats_new_mode_enabled": true,
			"wave_increase_enabled": false,
			"right_side_enabled": false
		}
		_more_ui_save_data()
	file.open(MORE_UI_SAVE_FILE, File.READ)
	more_ui_save_data = file.get_var()
	file.close()

func _align_element_to_right(element):
	element.margin_left = -180
	element.margin_right = -50
	
func _align_element_to_left(element):
	element.margin_left = 50
	element.margin_right = 180
	
func _align_ui_to_right():
	for mod in ModLoader.mod_load_order:
		var mod_name:String = mod.dir_name
		if (mod_name == "otDan-WaveTimer"):
			more_ui_container.get_node("%MoreUI_otdanwavetimerspacer").visible = true
			
		
	more_ui_container.alignment = 2
	_value_prefix = "[right]"
	_value_suffix = "[/right]"
	_align_element_to_right(max_hp_field_control.get_node("VBoxContainer"))
	_align_element_to_right(hp_regen_field_control.get_node("VBoxContainer"))
	_align_element_to_right(lifesteal_field_control.get_node("VBoxContainer"))
	_align_element_to_right(damage_field_control.get_node("VBoxContainer"))
	_align_element_to_right(melee_damage_field_control.get_node("VBoxContainer"))
	_align_element_to_right(ranged_damage_field_control.get_node("VBoxContainer"))
	_align_element_to_right(elemental_damage_field_control.get_node("VBoxContainer"))
	_align_element_to_right(attack_speed_field_control.get_node("VBoxContainer"))
	_align_element_to_right(crit_chance_field_control.get_node("VBoxContainer"))
	_align_element_to_right(engineering_field_control.get_node("VBoxContainer"))
	_align_element_to_right(range_field_control.get_node("VBoxContainer"))
	_align_element_to_right(armor_field_control.get_node("VBoxContainer"))
	_align_element_to_right(dodge_field_control.get_node("VBoxContainer"))
	_align_element_to_right(speed_field_control.get_node("VBoxContainer"))
	_align_element_to_right(luck_field_control.get_node("VBoxContainer"))
	_align_element_to_right(harvesting_field_control.get_node("VBoxContainer"))
	
func _align_ui_to_left():
	more_ui_container.get_node("%MoreUI_otdanwavetimerspacer").visible = false
	more_ui_container.alignment = 0
	_value_prefix = ""
	_value_suffix = ""
	_align_element_to_left(max_hp_field_control.get_node("VBoxContainer"))
	_align_element_to_left(hp_regen_field_control.get_node("VBoxContainer"))
	_align_element_to_left(lifesteal_field_control.get_node("VBoxContainer"))
	_align_element_to_left(damage_field_control.get_node("VBoxContainer"))
	_align_element_to_left(melee_damage_field_control.get_node("VBoxContainer"))
	_align_element_to_left(ranged_damage_field_control.get_node("VBoxContainer"))
	_align_element_to_left(elemental_damage_field_control.get_node("VBoxContainer"))
	_align_element_to_left(attack_speed_field_control.get_node("VBoxContainer"))
	_align_element_to_left(crit_chance_field_control.get_node("VBoxContainer"))
	_align_element_to_left(engineering_field_control.get_node("VBoxContainer"))
	_align_element_to_left(range_field_control.get_node("VBoxContainer"))
	_align_element_to_left(armor_field_control.get_node("VBoxContainer"))
	_align_element_to_left(dodge_field_control.get_node("VBoxContainer"))
	_align_element_to_left(speed_field_control.get_node("VBoxContainer"))
	_align_element_to_left(luck_field_control.get_node("VBoxContainer"))
	_align_element_to_left(harvesting_field_control.get_node("VBoxContainer"))
	
