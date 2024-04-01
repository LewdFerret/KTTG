extends Control

@onready var main_pnl = $MainPnl
@onready var prompts_pnl = $PromptsPnl
<<<<<<< HEAD
@onready var options_pnl = $OptionsPnl
@onready var about_panel = $AboutPanel

@onready var MASTER_BUS_ID = AudioServer.get_bus_index("Master")
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")
@onready var MOAN_BUS_ID = AudioServer.get_bus_index("Moans")
@onready var PENETRATION_BUS_ID = AudioServer.get_bus_index("Penetration")

# --- user://settings.dat ---
# 0     |0    |0    |0          |en      |disabled|disabled|disabled|0
# Master|Music|Moans|Penetration|Language|msaa2d  |msaa3d  |spsaa   |taa
# float |float|float|float      |String  |String  |String  |String  |int
=======
>>>>>>> 5f3cdfd (Initial Commit)

func _ready():
	main_pnl.visible = true
	prompts_pnl.visible = false
<<<<<<< HEAD
	options_pnl.visible = false
	about_panel.visible = false
	
	if FileAccess.file_exists("user://settings.dat"):
		load_le_settings()
	else:
		var f = FileAccess.open("user://settings.dat", FileAccess.WRITE)
		if f:
			f.store_string("0|0|0|0|en|disabled|disabled|disabled|0")
			f.close()
		load_le_settings()
=======
>>>>>>> 5f3cdfd (Initial Commit)

func _on_prompts_btn_pressed():
	main_pnl.visible = false
	prompts_pnl.visible = true
<<<<<<< HEAD
	options_pnl.visible = false
	about_panel.visible = false
=======
>>>>>>> 5f3cdfd (Initial Commit)

func _on_prompts_back_btn_pressed():
	main_pnl.visible = true
	prompts_pnl.visible = false
<<<<<<< HEAD
	options_pnl.visible = false
	about_panel.visible = false

func _on_options_pressed():
	main_pnl.visible = false
	prompts_pnl.visible = false
	options_pnl.visible = true
	about_panel.visible = false

func _on_exit_pressed():
	get_tree().quit(0)

func _on_about_pressed():
	main_pnl.visible = false
	prompts_pnl.visible = false
	options_pnl.visible = false
	about_panel.visible = true

func _on_save_btn_pressed():
	var f = FileAccess.open("user://settings.dat", FileAccess.WRITE)
	if f:
		f.store_string(str($OptionsPnl/Groups/AUDIO/MasterVolume/HSlider.value) + "|")
		f.store_string(str($OptionsPnl/Groups/AUDIO/MusicVolume/HSlider.value) + "|")
		f.store_string(str($OptionsPnl/Groups/AUDIO/MoanVolume/HSlider.value) + "|")
		f.store_string(str($OptionsPnl/Groups/AUDIO/PenetrationVolume/HSlider.value) + "|")
		f.store_string(get_lang_from_index($OptionsPnl/Groups/GENERAL/Language/OptionButton.selected) + "|")
		f.store_string(str_from_msaa($OptionsPnl/Groups/VIDEO/MSAA2D/OptionButton.selected) + "|")
		f.store_string(str_from_msaa($OptionsPnl/Groups/VIDEO/MSAA3D/OptionButton.selected) + "|")
		f.store_string(str_from_spsaa($OptionsPnl/Groups/VIDEO/SPSAA/OptionButton.selected) + "|")
		f.store_string(str(int_from_bool($OptionsPnl/Groups/VIDEO/TAA/CheckBox.button_pressed)))
	
	RenderingServer.viewport_set_msaa_2d(get_tree().root.get_viewport_rid(), msaa_from_int($OptionsPnl/Groups/VIDEO/MSAA2D/OptionButton.selected))
	RenderingServer.viewport_set_msaa_3d(get_tree().root.get_viewport_rid(), msaa_from_int($OptionsPnl/Groups/VIDEO/MSAA2D/OptionButton.selected))
	RenderingServer.viewport_set_screen_space_aa(get_tree().root.get_viewport_rid(), spsaa_from_int($OptionsPnl/Groups/VIDEO/MSAA2D/OptionButton.selected))
	RenderingServer.viewport_set_use_taa(get_tree().root.get_viewport_rid(), $OptionsPnl/Groups/VIDEO/TAA/CheckBox.button_pressed)
	
	main_pnl.visible = true
	prompts_pnl.visible = false
	options_pnl.visible = false
	about_panel.visible = false

func _on_about_back_btn_pressed():
	main_pnl.visible = true
	prompts_pnl.visible = false
	options_pnl.visible = false
	about_panel.visible = false

func load_le_settings() -> void:
	var f = FileAccess.open("user://settings.dat", FileAccess.READ)
	if f:
		var raw_data = f.get_as_text()
		var seperated_data = raw_data.split("|")
		var loc = seperated_data[4]
		var msaa2d: int = int_from_msaa(seperated_data[5])
		var msaa3d: int = int_from_msaa(seperated_data[6])
		var spsaa: int = int_from_spsaa(seperated_data[7])
		var taa: bool = bool_from_int(int(seperated_data[8]))
		
		$OptionsPnl/Groups/GENERAL/Language/OptionButton.selected = get_index_from_lang(loc)
		TranslationServer.set_locale(loc)
		
		$OptionsPnl/Groups/AUDIO/MasterVolume/HSlider.value = float(seperated_data[0])
		$OptionsPnl/Groups/AUDIO/MusicVolume/HSlider.value = float(seperated_data[1])
		$OptionsPnl/Groups/AUDIO/MoanVolume/HSlider.value = float(seperated_data[2])
		$OptionsPnl/Groups/AUDIO/PenetrationVolume/HSlider.value = float(seperated_data[3])
		
		AudioServer.set_bus_volume_db(MASTER_BUS_ID, linear_to_db(float(seperated_data[0])))
		AudioServer.set_bus_mute(MASTER_BUS_ID, float(seperated_data[0]) < $OptionsPnl/Groups/AUDIO/MasterVolume/HSlider.step)
		
		AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(float(seperated_data[1])))
		AudioServer.set_bus_mute(MUSIC_BUS_ID, float(seperated_data[1]) < $OptionsPnl/Groups/AUDIO/MusicVolume/HSlider.step)
		
		AudioServer.set_bus_volume_db(MOAN_BUS_ID, linear_to_db(float(seperated_data[2])))
		AudioServer.set_bus_mute(MOAN_BUS_ID, float(seperated_data[2]) < $OptionsPnl/Groups/AUDIO/MoanVolume/HSlider.step)
		
		AudioServer.set_bus_volume_db(PENETRATION_BUS_ID, linear_to_db(float(seperated_data[3])))
		AudioServer.set_bus_mute(PENETRATION_BUS_ID, float(seperated_data[3]) < $OptionsPnl/Groups/AUDIO/PenetrationVolume/HSlider.step)
		
		$OptionsPnl/Groups/VIDEO/MSAA2D/OptionButton.selected = msaa2d
		$OptionsPnl/Groups/VIDEO/MSAA3D/OptionButton.selected = msaa3d
		$OptionsPnl/Groups/VIDEO/SPSAA/OptionButton.selected = spsaa
		$OptionsPnl/Groups/VIDEO/TAA/CheckBox.button_pressed = taa
		
		RenderingServer.viewport_set_msaa_2d(get_tree().root.get_viewport_rid(), msaa_from_int(msaa2d))
		RenderingServer.viewport_set_msaa_3d(get_tree().root.get_viewport_rid(), msaa_from_int(msaa3d))
		RenderingServer.viewport_set_screen_space_aa(get_tree().root.get_viewport_rid(), spsaa_from_int(spsaa))
		RenderingServer.viewport_set_use_taa(get_tree().root.get_viewport_rid(), taa)
		
		f.close()

func _on_option_button_item_selected(index):
	match index:
		0: #? de
			TranslationServer.set_locale("de")
		1: #? en
			TranslationServer.set_locale("en")
		2: #? fr
			TranslationServer.set_locale("fr")
		_: #? default (= en)
			TranslationServer.set_locale("en")

func get_index_from_lang(s: String) -> int:
	match s:
		"de": return 0
		"en": return 1
		"fr": return 2
		_: return 1 #? en

func get_lang_from_index(i: int) -> String:
	match i:
		0: return "de"
		1: return "en"
		2: return "fr"
		_: return "en"

## Returns a string from the given MSAA2D/MSAA3D setting
func str_from_msaa(index: int) -> String:
	match index:
		0: return "disabled"
		1: return "2x"
		2: return "4x"
		3: return "8x"
		_: return "disabled"

func str_from_spsaa(index: int) -> String:
	match index:
		0: return "disabled"
		1: return "fxaa"
		_: return "disabled"

func bool_from_int(i: int) -> bool:
	if i == 1:
		return true
	else:
		return false

func int_from_bool(b: bool) -> int:
	if b:
		return 1
	else:
		return 0

func int_from_msaa(msaa: String) -> int:
	match msaa:
		"disabled": return 0
		"2x": return 1
		"4x": return 2
		"8x": return 3
		_: return 0

func int_from_spsaa(spsaa: String) -> int:
	match spsaa:
		"disabled": return 0
		"fxaa": return 1
		_: return 0

func msaa_from_int(i: int):
	match i:
		0: #? disabled
			return RenderingServer.VIEWPORT_MSAA_DISABLED
		1: #? 2x
			return RenderingServer.VIEWPORT_MSAA_2X
		2: #? 4x
			return RenderingServer.VIEWPORT_MSAA_4X
		3:
			return RenderingServer.VIEWPORT_MSAA_8X
		_:
			return RenderingServer.VIEWPORT_MSAA_DISABLED

func spsaa_from_int(i: int):
	match i:
		0:
			return RenderingServer.VIEWPORT_SCREEN_SPACE_AA_DISABLED
		1:
			return RenderingServer.VIEWPORT_SCREEN_SPACE_AA_FXAA
		_:
			return RenderingServer.VIEWPORT_SCREEN_SPACE_AA_DISABLED

#region Volume Sliders Text

func _on_h_slider_value_changed(value):
	$OptionsPnl/Groups/AUDIO/MasterVolume/Val.text = str(value)
	AudioServer.set_bus_volume_db(MASTER_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(MASTER_BUS_ID, value < $OptionsPnl/Groups/AUDIO/MasterVolume/HSlider.step)

func _on_h_slider_value2_changed(value):
	$OptionsPnl/Groups/AUDIO/MusicVolume/Val.text = str(value)
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(MUSIC_BUS_ID, value < $OptionsPnl/Groups/AUDIO/MusicVolume/HSlider.step)

func _on_h_slider_value3_changed(value):
	$OptionsPnl/Groups/AUDIO/MoanVolume/Val.text = str(value)
	AudioServer.set_bus_volume_db(MOAN_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(MOAN_BUS_ID, value < $OptionsPnl/Groups/AUDIO/MoanVolume/HSlider.step)

func _on_h_slider_value4_changed(value):
	$OptionsPnl/Groups/AUDIO/PenetrationVolume/Val.text = str(value)
	AudioServer.set_bus_volume_db(PENETRATION_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(PENETRATION_BUS_ID, value < $OptionsPnl/Groups/AUDIO/PenetrationVolume/HSlider.step)
#endregion
=======
>>>>>>> 5f3cdfd (Initial Commit)
