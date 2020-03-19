extends Node2D

onready var gui = $gui_layer/gui

func _ready():
	
	$islands/start.connect("left_start", $bgm, "play")
	$player.connect("health_changed", gui, "_on_health_changed")
