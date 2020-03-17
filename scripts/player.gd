extends Ship

onready var cam = $cam

func _physics_process(delta):
	
	# Fix HUD in place
	# TODO: Find a less janky solution
	cam.rotation = -1 * rotation
	
	if(Input.is_action_just_pressed("raise_sails") and not is_sail_up):
		raise_sails()
	if(Input.is_action_just_pressed("lower_sails") and is_sail_up):
		lower_sails()
	
	if(Input.is_action_pressed("move_left")):
		rotation -= delta * ROT_PER_SEC + delta * velocity * ROT_PER_SEC
	if(Input.is_action_pressed("move_right")):
		rotation += delta * ROT_PER_SEC + delta * velocity * ROT_PER_SEC
	
	if(is_sail_up):
		move_and_collide(Vector2.UP.rotated(rotation) * WIND_SPEED * velocity, false)
	
	if(Input.is_action_just_pressed("cannon_port") and is_cannon_ready_port):
		fire_cannon(true, true)
	if(Input.is_action_just_pressed("cannon_starboard") and is_cannon_ready_star):
		fire_cannon(true, false)
