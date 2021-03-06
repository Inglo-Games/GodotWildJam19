extends PopupPanel

func _ready():
	$vbox/sliders_container/bgm_slider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("BGM"))
	$vbox/sliders_container/sfx_slider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX"))

func _on_bgm_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("BGM"), value)

func _on_sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)

func _on_subs_btn_toggled(button_pressed):
	ProjectSettings.set_setting("Accessibility/subtitles", button_pressed)

func _on_voice_btn_toggled(button_pressed):
	ProjectSettings.set_setting("Accessibility/voices", button_pressed)

func _on_back_btn_button_up():
	queue_free()
