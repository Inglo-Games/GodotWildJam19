extends StaticBody2D
class_name Island

signal line_triggered

export var subtitle_line : String = "island_01"

func _ready():
	var area = get_node("Area2D")
	if(area):
		area.connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body):
	# Can't use `if body is Player` because of some cyclic dependency
	if(body.name == "player"):
		emit_signal("line_triggered", subtitle_line)
