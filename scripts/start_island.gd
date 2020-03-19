extends Island

signal left_start

var first_leave := true 

func _ready():
	subtitle_line = "intro_01"
	$Area2D.connect("body_exited", self, "_on_body_exit")

func _on_body_exit(body):
	if(body is Player and first_leave):
		emit_signal("left_start")
		first_leave = false
