#extends "res://ui/menus/shop/stat_container.gd"
extends "res://ui/hud/ui_wave_timer.gd"

var more_ui_container
var prev_time

func _ready()->void:
	more_ui_container = preload("res://mods-unpacked/MincedMeatMole-MoreUI/ui/hud/more_ui.tscn").instance()
	
	ModLoaderUtils.log_info(str(RunData.effects["dodge_cap"] as int), 'MMM');
	ModLoaderUtils.log_info(str(RunData.effects["hp_cap"] as int), 'MMM');
	ModLoaderUtils.log_info(String(Utils.get_stat('stat_armor')), 'MMM');
	ModLoaderUtils.log_info(String(Utils.get_stat('stat_attack_speed')), 'MMM');
	ModLoaderUtils.log_info(String(Utils.get_stat('stat_crit_chance')), 'MMM');
	ModLoaderUtils.log_info(String(Utils.get_stat('stat_dodge')), 'MMM');
	ModLoaderUtils.log_info(String(Utils.get_stat('stat_elemental_damage')), 'MMM');
	ModLoaderUtils.log_info(String(Utils.get_stat('stat_engineering')), 'MMM');
	ModLoaderUtils.log_info(String(Utils.get_stat('stat_harvesting')), 'MMM');
	ModLoaderUtils.log_info(String(Utils.get_stat('stat_hp_regeneration')), 'MMM');
	ModLoaderUtils.log_info(String(Utils.get_stat('stat_lifesteal')), 'MMM');
	ModLoaderUtils.log_info(String(Utils.get_stat('stat_luck')), 'MMM');
	ModLoaderUtils.log_info(String(Utils.get_stat('stat_max_hp')), 'MMM');
	ModLoaderUtils.log_info(String(Utils.get_stat('stat_melee_damage')), 'MMM');
	ModLoaderUtils.log_info(String(Utils.get_stat('stat_percent_damage')), 'MMM');
	ModLoaderUtils.log_info(String(Utils.get_stat('stat_range')), 'MMM');
	ModLoaderUtils.log_info(String(Utils.get_stat('stat_ranged_damage')), 'MMM');
	ModLoaderUtils.log_info(String(Utils.get_stat('stat_speed')), 'MMM');
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if wave_timer != null and is_instance_valid(wave_timer) and not is_run_lost:
		var time = ceil(wave_timer.time_left)
		if (time != prev_time):
			prev_time = time;
#			ModLoaderUtils.log_info(String(Utils.get_stat('stat_armor')), 'MMM');
#			ModLoaderUtils.log_info(String(Utils.get_stat('stat_attack_speed')), 'MMM');
#			ModLoaderUtils.log_info(String(Utils.get_stat('stat_crit_chance')), 'MMM');
#			ModLoaderUtils.log_info(String(Utils.get_stat('stat_dodge')), 'MMM');
#			ModLoaderUtils.log_info(String(Utils.get_stat('stat_elemental_damage')), 'MMM');
#			ModLoaderUtils.log_info(String(Utils.get_stat('stat_engineering')), 'MMM');
#			ModLoaderUtils.log_info(String(Utils.get_stat('stat_')), 'MMM');
#			ModLoaderUtils.log_info(String(Utils.get_stat('stat_max_hp')), 'MMM');
		
