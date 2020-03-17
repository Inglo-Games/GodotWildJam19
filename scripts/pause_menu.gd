extends Control

func _process(_delta):
	pass
	#if(Input.is_action_just_pressed("ui_cancel")):
		#_on_resume_btn_button_up()

func _on_resume_btn_button_up():
	get_tree().paused = false
	queue_free()

func _on_quit_btn_button_up():
	get_tree().change_scene("res://scenes/main_menu.tscn")
