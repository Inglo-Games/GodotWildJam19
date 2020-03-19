extends Node2D

onready var gui = $gui_layer/gui

func _ready():
	
	$islands/start.connect("left_start", $bgm, "play")
	$player.connect("health_changed", gui, "_on_health_changed")
	for ship in $enemies.get_children():
		ship.connect("battle_started", self, "_on_battle_started")
		ship.connect("battle_ended", self, "_on_battle_ended")

# Fade out regular BGM and fade in battle music
func _on_battle_started():
	var tween = Tween.new()
	tween.interpolate_property($bgm, "volume", 0.0, -64.0, 1.0)
	tween.start()
	yield(tween, "tween_all_completed")
	$battle.play()
	$bgm.volume_db = 0.0
	$bgm.stop()

# Change from battle music to BGM
func _on_battle_ended():
	var tween = Tween.new()
	tween.interpolate_property($battle, "volume", 0.0, -64.0, 1.0)
	tween.start()
	yield(tween, "tween_all_completed")
	$bgm.play()
	$battle.volume_db = 0.0
	$battle.stop()
