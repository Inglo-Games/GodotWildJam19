extends Control

var subtitles := true
var voices := true

func _ready():
	$panel/vbox/sliders_container/bgm_slider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("BGM"))
	$panel/vbox/sliders_container/sfx_slider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX"))

func _on_bgm_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("BGM"), value)

func _on_sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)

func _on_subs_btn_toggled(button_pressed):
	subtitles = button_pressed

func _on_voice_btn_toggled(button_pressed):
	voices = button_pressed

func _on_back_btn_button_up():
	get_tree().change_scene("res://scenes/main_menu.tscn")
