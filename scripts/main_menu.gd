extends Control

func _ready():
	$panel/container/start_btn.grab_focus()

func _on_start_btn_pressed():
	get_tree().change_scene("res://scenes/world.tscn")

func _on_options_btn_button_up():
	get_tree().change_scene("res://scenes/options.tscn")

func _on_quit_btn_button_up():
	get_tree().quit()
