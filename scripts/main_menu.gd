extends Control

func _on_start_btn_pressed():
	get_tree().change_scene("res://scenes/world.tscn")

func _on_options_btn_button_up():
	pass 

func _on_quit_btn_button_up():
	get_tree().quit()
