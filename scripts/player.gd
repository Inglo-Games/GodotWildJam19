extends KinematicBody2D

const ROT_PER_SEC := 0.96  # Max rotation speed in radians/second
const WIND_SPEED := 3.0    # Max movement speed in units/second

var velocity := 0.0
var is_sail_up := false

onready var tween : Tween = $tween

func _physics_process(delta):
	
	if(Input.is_action_just_pressed("raise_sails") and not is_sail_up):
		is_sail_up = true
		var curr_vel = velocity
		tween.interpolate_property(self, "velocity", curr_vel, 1.0, 0.6)
		tween.start()
	if(Input.is_action_just_pressed("lower_sails") and is_sail_up):
		is_sail_up = false
		var curr_vel = velocity
		tween.interpolate_property(self, "velocity", curr_vel, 0.0, 0.6)
		tween.start()
	
	if(is_sail_up):
		if(Input.is_action_pressed("move_left")):
			rotation -= delta * ROT_PER_SEC * velocity
		if(Input.is_action_pressed("move_right")):
			rotation += delta * ROT_PER_SEC * velocity
		move_and_collide(Vector2.UP.rotated(rotation) * WIND_SPEED * velocity, false)
