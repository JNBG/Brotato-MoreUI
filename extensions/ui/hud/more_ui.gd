extends "res://ui/hud/ui_wave_timer.gd"

onready var hud: MarginContainer = get_tree().get_current_scene().get_node("UI/HUD")

var more_ui_container
var prev_time
var _timer = null
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

func _ready()->void:
	more_ui_container = preload("res://mods-unpacked/MincedMeatMole-MoreUI/ui/hud/more_ui.tscn").instance()
	hud.margin_bottom = 0
	hud.anchor_bottom = 1
	hud.call_deferred("add_child", more_ui_container)
	hud.mouse_filter = MOUSE_FILTER_IGNORE
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
	
	_timer = Timer.new()
	add_child(_timer)
	_timer.connect("timeout", self, "_update_stats_ui")
	_timer.set_one_shot(false) # Make sure it loops
	_timer.set_wait_time(0.5)
	_timer.start()
	
	_update_stats_ui()
	
	
func _update_stats_ui():
	ModLoaderUtils.log_info("Timer", 'MMM')
	if wave_timer != null and is_instance_valid(wave_timer) and not is_run_lost:
		var time = ceil(wave_timer.time_left)
		if time > 0:
			more_ui_container.visible = true
		else:
			more_ui_container.visible = false
			return
			
	if max_hp_field != null:
		var maxHPValue = floor(Utils.get_stat('stat_max_hp'))
		max_hp_field.bbcode_text = "[color=" + _get_value_color(maxHPValue) + "]" + str(maxHPValue) + "[/color]"
	if hp_regen_field != null:
		var hpRegenValue = floor(Utils.get_stat('stat_hp_regeneration'))
		hp_regen_field.bbcode_text = "[color=" + _get_value_color(hpRegenValue) + "]" + str(hpRegenValue) + "[/color]"
	if lifesteal_field != null:
		var lifestealValue = floor(Utils.get_stat('stat_lifesteal'))
		lifesteal_field.bbcode_text = "[color=" + _get_value_color(lifestealValue) + "]" + str(lifestealValue) + "[/color]"
	if damage_field != null:
		var damageValue = floor(Utils.get_stat('stat_percent_damage'))
		damage_field.bbcode_text = "[color=" + _get_value_color(damageValue) + "]" + str(damageValue) + "[/color]"
	if melee_damage_field != null:
		var meleeDamageValue = floor(Utils.get_stat('stat_melee_damage'))
		melee_damage_field.bbcode_text = "[color=" + _get_value_color(meleeDamageValue) + "]" + str(meleeDamageValue) + "[/color]"
	if ranged_damage_field != null:
		var rangedDamageValue = floor(Utils.get_stat('stat_ranged_damage'))
		ranged_damage_field.bbcode_text = "[color=" + _get_value_color(rangedDamageValue) + "]" + str(rangedDamageValue) + "[/color]"
	if elemental_damage_field != null:
		var elementalDamageValue = floor(Utils.get_stat('stat_elemental_damage'))
		elemental_damage_field.bbcode_text = "[color=" + _get_value_color(elementalDamageValue) + "]" + str(elementalDamageValue) + "[/color]"
	if attack_speed_field != null:
		var attackSpeedValue = floor(Utils.get_stat('stat_attack_speed'))
		attack_speed_field.bbcode_text = "[color=" + _get_value_color(attackSpeedValue) + "]" + str(attackSpeedValue) + "[/color]"
	if crit_chance_field != null:
		var critChanceValue = floor(Utils.get_stat('stat_crit_chance'))
		crit_chance_field.bbcode_text = "[color=" + _get_value_color(critChanceValue) + "]" + str(critChanceValue) + "[/color]"
	if engineering_field != null:
		var engineeringValue = floor(Utils.get_stat('stat_engineering'))
		engineering_field.bbcode_text = "[color=" + _get_value_color(engineeringValue) + "]" + str(engineeringValue) + "[/color]"
	if range_field != null:
		var rangeValue = floor(Utils.get_stat('stat_range'))
		range_field.bbcode_text = "[color=" + _get_value_color(rangeValue) + "]" + str(rangeValue) + "[/color]"
	if armor_field != null:
		var armorValue = floor(Utils.get_stat('stat_armor'))
		armor_field.bbcode_text = "[color=" + _get_value_color(armorValue) + "]" + str(armorValue) + "[/color]"
	if dodge_field != null:
		var dodgeValue = floor(Utils.get_stat('stat_dodge'))
		dodge_field.bbcode_text = "[color=" + _get_value_color(dodgeValue) + "]" + str(dodgeValue) + "[/color]"
	if speed_field != null:
		var speedValue = floor(Utils.get_stat('stat_speed'))
		speed_field.bbcode_text = "[color=" + _get_value_color(speedValue) + "]" + str(speedValue) + "[/color]"
	if luck_field != null:
		var luckValue = floor(Utils.get_stat('stat_luck'))
		luck_field.bbcode_text = "[color=" + _get_value_color(luckValue) + "]" + str(luckValue) + "[/color]"
	if harvesting_field != null:
		var harvestingValue = floor(Utils.get_stat('stat_harvesting'))
		harvesting_field.bbcode_text = "[color=" + _get_value_color(harvestingValue) + "]" + str(harvestingValue) + "[/color]"

func _get_value_color(value):
	if (value > 0):
		return "#00ff00"
	elif (value < 0):
		return "#ff0000"
	else:
		return "#fff"
