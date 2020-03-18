extends Control

onready var OptionsMenu = preload("res://scenes/options.tscn")

func _on_resume_btn_button_up():
	get_tree().paused = false
	queue_free()

func _on_opts_btn_button_up():
	var opts = OptionsMenu.instance()
	add_child(opts)
	opts.popup_centered()

func _on_quit_btn_button_up():
	get_tree().paused = false
	queue_free()
	get_tree().change_scene("res://scenes/main_menu.tscn")
