extends Ship

const CHASE_THRESHOLD := 600.0		# Distance in pixels the ship will chase player
const CHASE_TIMER := 15.0			# Time in seconds before sending battle_over signal

onready var player = get_node("/root/world/player")
onready var port_stern_ray = $port_stern_ray
onready var port_bow_ray = $port_bow_ray
onready var port_side_ray = $port_ray
onready var star_stern_ray = $star_stern_ray
onready var star_bow_ray = $star_bow_ray
onready var star_side_ray = $star_ray
onready var timer = $Timer

var in_battle := false

func _physics_process(delta:float):
	
	# Only do anything if player is in range
	var dist_to_player := global_position.distance_to(player.global_position)
	if dist_to_player <= CHASE_THRESHOLD:
		
		if(not in_battle and timer.is_stopped()):
			in_battle = true
			emit_signal("battle_started")
		elif(not timer.is_stopped()):
			timer.stop()
		
		# Movement logic
		var direction := Vector2.UP.rotated(rotation)
		var angle_to_player := direction.angle_to(player.position - position)
		
		if (angle_to_player > -1.309 and angle_to_player <= -0.1) \
					or (angle_to_player > 1.833 and angle_to_player <= 3.142):
			rotation += delta * ROT_PER_SEC
		elif (angle_to_player < -1.833 and angle_to_player > -3.142) \
					or (angle_to_player > 0.1 and angle_to_player < 1.309):
			rotation -= delta * ROT_PER_SEC
		
		var player_dot := direction.dot((player.position - position).normalized())
		if(dist_to_player >= 120.0 and player_dot >= 0.5):
			raise_sails()
		else:
			lower_sails()
		if(is_sail_up):
			var collision_info := move_and_collide(direction * WIND_SPEED * velocity, false)
			if(collision_info and collision_info.collider is Ship):
				# Deal ramming damage
				if(player_dot >= 0.9):
					collision_info.collider.deal_damage(5)
		
		# Firing logic
		for ray in [port_bow_ray, port_side_ray, port_stern_ray]:
			if(ray.is_colliding() and is_cannon_ready_port):
				fire_cannon(false, true)
		for ray in [star_bow_ray, star_side_ray, star_stern_ray]:
			if(ray.is_colliding() and is_cannon_ready_star):
				fire_cannon(false, false)
	
	# If player isn't in chase distance...
	else:
		if(in_battle and timer.is_stopped()):
			timer.start(CHASE_TIMER)

func _on_chase_timer_ended():
	in_battle = false
	emit_signal("battle_ended")
