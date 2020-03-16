extends Ship

const CHASE_THRESHOLD := 600.0

onready var player = get_node("/root/world/player")
onready var port_stern_ray = $port_stern_ray
onready var port_bow_ray = $port_bow_ray
onready var port_side_ray = $port_ray
onready var star_stern_ray = $star_stern_ray
onready var star_bow_ray = $star_bow_ray
onready var star_side_ray = $star_ray

var turning_port := false
var turning_starboard := false

func _physics_process(delta:float):
	
	# Only do anything if player is in range
	var dist_to_player = global_position.distance_to(player.global_position)
	if dist_to_player <= CHASE_THRESHOLD:
		
		# Movement logic
		var angle_to_player := position.angle_to(player.position)
		if (angle_to_player > -45.0 and angle_to_player <= 0.0) \
					or (angle_to_player > 135.0 and angle_to_player <= 180.0):
			rotation -= delta * ROT_PER_SEC
		elif (angle_to_player < -135.0 and angle_to_player > -180.0) \
					or (angle_to_player > 0.0 and angle_to_player < 45.0):
			rotation += delta * ROT_PER_SEC
		
		if(dist_to_player > 300.0 and angle_to_player > -45.0 and angle_to_player < 45.0):
			is_sail_up = true
		else:
			is_sail_up = false
		if(is_sail_up):
			move_and_collide(Vector2.UP.rotated(rotation) * WIND_SPEED * velocity, false)
		
		# Firing logic
		for ray in [port_bow_ray, port_side_ray, port_stern_ray]:
			if(ray.is_colliding() and is_cannon_ready_port):
				fire_cannon(false, true)
		for ray in [star_bow_ray, star_side_ray, star_stern_ray]:
			if(ray.is_colliding() and is_cannon_ready_star):
				fire_cannon(false, false)

