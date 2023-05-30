extends Node

const MINCEDMEATMOLE_MOREUI_DIR = "MincedMeatMole-MoreUI/"
const MINCEDMEATMOLE_MOREUI_LOG = "MincedMeatMole-MoreUI"

var dir = ""
var ext_dir = ""
var trans_dir = ""

func _init(modLoader = ModLoader):
	ModLoaderUtils.log_info("Init", MINCEDMEATMOLE_MOREUI_LOG)
	dir = modLoader.UNPACKED_DIR + MINCEDMEATMOLE_MOREUI_DIR
	
	modLoader.install_script_extension(dir + "extensions/ui/hud/more_ui.gd")


func _ready():
	ModLoaderUtils.log_info("Done", MINCEDMEATMOLE_MOREUI_LOG)
