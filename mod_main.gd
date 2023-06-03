extends Node

const MINCEDMEATMOLE_MOREUI_DIR = "MincedMeatMole-MoreUI/"
const MINCEDMEATMOLE_MOREUI_LOG = "MincedMeatMole-MoreUI"

var dir = ""

func _init(modLoader = ModLoader):
	ModLoaderUtils.log_info("Init", MINCEDMEATMOLE_MOREUI_LOG)
	dir = modLoader.UNPACKED_DIR + MINCEDMEATMOLE_MOREUI_DIR

	# Add interface
	_add_child_class()
	
	# Add Extensions
	modLoader.install_script_extension(dir + "extensions/ui/menus/pages/menu_choose_options.gd")
	modLoader.install_script_extension(dir + "extensions/ui/menus/menus.gd")
	
	modLoader.install_script_extension(dir + "extensions/ui/hud/more_ui.gd")

	# Add localizations
	modLoader.add_translation_from_resource(dir + "translations/moreui_translations.en.translation")
	modLoader.add_translation_from_resource(dir + "translations/moreui_translations.fr.translation")
	modLoader.add_translation_from_resource(dir + "translations/moreui_translations.de.translation")

func _add_child_class():
	var MoreUIConfigInterface = load(dir + "more_ui_config_interface.gd").new()
	MoreUIConfigInterface.name = "MoreUIConfigInterface"
	add_child(MoreUIConfigInterface)
