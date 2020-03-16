extends KinematicBody2D
class_name Cannonball

const FLIGHT_TIME := 1.75
const SPEED := 3.5

onready var timer := $timer

var direction := Vector2(1.0, 0.0)

func _ready():
	
	# Setup life timer
	timer.connect("timeout", self, "_on_timeout")
	timer.start(FLIGHT_TIME)
	
	$cannon.play()

func _physics_process(_delta):
	var collision_info := move_and_collide(direction.normalized() * SPEED)
	if(collision_info):
		collision_info.collider.deal_damage(3)
		timer.stop()
		$hit.play()
		$sprite.visible = false
		$shape.disabled = true
		yield($hit, "finished")
		queue_free()

# Function plays when lifetime ends and nothing is hit
func _on_timeout():
	$sprite.visible = false
	$shape.disabled = true
	$splash.play()
	yield($splash, "finished")
	queue_free()

# Function needed for collisions with other cannonballs, not actually used
func deal_damage(_amount:int):
	pass
