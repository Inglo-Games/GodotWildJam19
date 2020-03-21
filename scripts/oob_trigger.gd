extends Area2D

signal line_triggered

func _ready():
	connect("body_entered", self, "_on_oob_triggered")

func _on_oob_triggered(body):
	if body is Player:
		emit_signal("line_triggered", "out_of_bounds")
