extends Area2D

signal line_triggered

func _ready():
	connect("body_exited", self, "_on_body_exited")

func _on_body_exited(body):
	if body is Player:
		emit_signal("line_triggered", "intro_02")
		$CollisionShape2D.set_deferred("disabled", true)
