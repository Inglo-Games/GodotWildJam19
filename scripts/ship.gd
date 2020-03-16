extends KinematicBody2D
class_name Ship

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

func fire_cannon(is_player:bool, is_port_side:bool):
	
	if(is_port_side):
		is_cannon_ready_port = false
	else:
		is_cannon_ready_star = false
	
	var new_ball = Cannonball.instance()
	var fire_direction = Vector2.LEFT if is_port_side else Vector2.RIGHT
	new_ball.direction = (fire_direction.rotated(rotation) + Vector2.UP.rotated(rotation) * velocity).normalized()
	new_ball.position = position
	projectiles_group.call_deferred("add_child", new_ball)
	
	new_ball.set_collision_layer_bit(1, is_player)
	new_ball.set_collision_layer_bit(3, not is_player)
	new_ball.set_collision_mask_bit(0, not is_player)
	new_ball.set_collision_mask_bit(1, not is_player)
	new_ball.set_collision_mask_bit(2, is_player)
	new_ball.set_collision_mask_bit(3, is_player)
	
	# Short timer before ready to fire again
	yield(get_tree().create_timer(RELOAD_TIME), "timeout")
	if(is_port_side):
		is_cannon_ready_port = true
	else:
		is_cannon_ready_star = true
