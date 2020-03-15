extends KinematicBody2D

const ROT_PER_SEC := 0.96  # Max rotation speed in radians/second
const WIND_SPEED := 3.0    # Max movement speed in units/second
const RELOAD_TIME := 2.5   # Time to reload cannons in seconds

onready var Cannonball := preload("res://scenes/cannonball.tscn")

var velocity := 0.0
var is_sail_up := false
var is_cannon_ready_port := true
var is_cannon_ready_star := true

onready var tween = $tween
onready var projectiles_group = get_node("/root/world/projectiles")


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
	
	if(Input.is_action_just_pressed("cannon_port") and is_cannon_ready_port):
		fire_cannon_port()
	if(Input.is_action_just_pressed("cannon_starboard") and is_cannon_ready_star):
		fire_cannon_starboard()

func fire_cannon_port():
	is_cannon_ready_port = false
	
	# Create a new cannonball object
	var new_ball = Cannonball.instance()
	var port_vector = Vector2.LEFT.rotated(rotation)
	new_ball.direction = port_vector
	new_ball.position = position + port_vector * 20.0
	projectiles_group.call_deferred("add_child", new_ball)
	
	# Short timer before ready to fire again
	yield(get_tree().create_timer(RELOAD_TIME), "timeout")
	is_cannon_ready_port = true

func fire_cannon_starboard():
	is_cannon_ready_star = false
	
	# Create a new cannonball object
	var new_ball = Cannonball.instance()
	var star_vector = Vector2.RIGHT.rotated(rotation)
	new_ball.direction = star_vector
	new_ball.position = position + star_vector * 20.0
	projectiles_group.call_deferred("add_child", new_ball)
	
	# Short timer before ready to fire again
	yield(get_tree().create_timer(RELOAD_TIME), "timeout")
	is_cannon_ready_star = true
