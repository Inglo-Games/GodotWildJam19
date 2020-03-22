extends Node2D

signal line_triggered

onready var cam = $cine_cam
onready var tween = $Tween

func _ready():
	connect("line_triggered", $cl/gui, "_on_play_line")
	$cl/gui/health_back.visible = false
	cam.current = true
	
	# Play scene 1
	emit_signal("line_triggered", "cinematic_01")
	cam.position = Vector2(9348,2345)
	tween.interpolate_property(cam, "position:y", 2345, 3440, 6.5)
	tween.start()
	yield(tween, "tween_all_completed")
	
	# Play scene 2
	emit_signal("line_triggered", "cinematic_02")
	cam.position = Vector2(3989, 4436)
	tween.interpolate_property(cam, "zoom", Vector2(1.5, 1.5), Vector2(1.225, 1.225), 5.5)
	tween.start()
	yield(tween, "tween_all_completed")
	
	# Play scene 3
	emit_signal("line_triggered", "cinematic_03")
	tween.interpolate_property(cam, "zoom", Vector2(1.225 , 1.225), Vector2(0.775, 0.775), 9.0)
	tween.start()
	yield(tween, "tween_all_completed")
	
	# Play scene 4
	emit_signal("line_triggered", "cinematic_04")
	cam.zoom = Vector2.ONE
	cam.position = Vector2(2592, 2048)
	tween.interpolate_property(cam, "position:x", 2592, 3463, 7.5)
	tween.start()
	yield(tween, "tween_all_completed")
	
	# Play scene 5
	emit_signal("line_triggered", "cinematic_05")
	cam.position = Vector2(4084, 927)
	tween.interpolate_property(cam, "position:x", 4084, 3009, 12)
	tween.start()
	yield(tween, "tween_all_completed")
	
	get_tree().change_scene("res://scenes/world.tscn")

func _process(_delta):
	if(Input.is_action_just_pressed("ui_cancel") 
			or Input.is_action_just_pressed("ui_accept") 
			or Input.is_action_just_pressed("ui_select")):
		get_tree().change_scene("res://scenes/world.tscn")
