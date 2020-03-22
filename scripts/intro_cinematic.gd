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
	tween.interpolate_property(cam, "position:y", 2345, 3440, 5.0)
	tween.start()
	yield(tween, "tween_all_completed")
	fade_cam_out()
	
	# Play scene 2
	emit_signal("line_triggered", "cinematic_02")
	fade_cam_in()
	cam.position = Vector2(3989, 4436)
	tween.interpolate_property(cam, "zoom", Vector2(1,1), Vector2(0.4, 0.4), 5.0)
	tween.start()
	yield(tween, "tween_all_completed")
	fade_cam_out()
	
	# Play scene 3
	cam.zoom = Vector2.ONE
	emit_signal("line_triggered", "cinematic_03")
	yield(get_tree().create_timer(5.0), "timeout")
	
	# Play scene 4
	emit_signal("line_triggered", "cinematic_04")
	fade_cam_in()
	cam.position = Vector2(2592, 2048)
	tween.interpolate_property(cam, "position:x", 2592, 3463, 5.0)
	tween.start()
	yield(tween, "tween_all_completed")
	fade_cam_out()
	
	# Play scene 5
	emit_signal("line_triggered", "cinematic_05")
	yield(get_tree().create_timer(5.0), "timeout")
	
	get_tree().change_scene("res://scenes/world.tscn")

func fade_cam_out():
	pass

func fade_cam_in():
	pass
