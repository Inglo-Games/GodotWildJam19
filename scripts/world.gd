extends Node2D

func _ready():
	$islands/start.connect("left_start", $bgm, "play")
