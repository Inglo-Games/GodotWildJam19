extends Area2D

signal line_triggered

onready var boss = $enemy_ship

func _ready():
	boss.health = 8
	boss.set_process(false)
	boss.set_physics_process(false)
	boss.connect("battle_ended", self, "_on_battle_ended")
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body):
	if body is Player:
		emit_signal("line_triggered", "final_battle")
		boss.set_process(true)
		boss.set_physics_process(true)
		$CollisionShape2D.set_deferred("disabled", true)

func _on_battle_ended():
	emit_signal("line_triggered", "final_victory")
	queue_free()
