extends Node2D

var PauseMenu = preload("res://scenes/pause_menu.tscn")

onready var gui = $gui_layer/gui
onready var tween := $Tween

func _ready():
	
	$islands/start.connect("left_start", $bgm, "play")
	$player.connect("health_changed", gui, "_on_health_changed")
	$player.connect("game_over", gui, "_on_game_over")
	for ship in $enemies.get_children():
		ship.connect("battle_started", self, "_on_battle_started")
		ship.connect("battle_ended", self, "_on_battle_ended")
	for island in $islands.get_children():
		island.connect("line_triggered", gui, "_on_play_line")
	$islands/island8/Area2D2.connect("line_triggered", gui, "_on_play_line")

func _process(_delta):
	if(Input.is_action_just_pressed("ui_cancel")):
		create_pause_popup()

func create_pause_popup():
	var pause_menu = PauseMenu.instance()
	gui.add_child(pause_menu)
	pause_menu.popup_centered()
	get_tree().paused = true

# Fade out regular BGM and fade in battle music
func _on_battle_started():
	tween.interpolate_property($bgm, "volume_db", 0.0, -64.0, 1.0)
	tween.start()
	yield(tween, "tween_all_completed")
	$battle.play()
	$bgm.volume_db = 0.0
	$bgm.stop()

# Change from battle music to BGM
func _on_battle_ended():
	tween.interpolate_property($battle, "volume_db", 0.0, -64.0, 1.0)
	tween.start()
	yield(tween, "tween_all_completed")
	$bgm.play()
	$battle.volume_db = 0.0
	$battle.stop()
