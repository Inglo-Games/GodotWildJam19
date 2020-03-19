extends Control

onready var subs = $subtitles

func _on_health_changed(amount:int):
	$health_back/health_label.text = "HEALTH: %d" % amount

func display_subtitles(line:String):
	subs.text = line
	subs.visible = true
