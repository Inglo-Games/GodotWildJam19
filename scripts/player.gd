extends Ship
class_name Player

var PauseMenu = preload("res://scenes/pause_menu.tscn")

onready var cam = $cam
onready var health_label = $cam/hud_back/label

var is_immune := false

func _physics_process(delta):
	
	# Fix HUD in place
	# TODO: Find a less janky solution
	cam.rotation = -1 * rotation
	
	if(Input.is_action_just_pressed("ui_cancel")):
		create_pause_popup()
	
	if(Input.is_action_just_pressed("raise_sails") and not is_sail_up):
		raise_sails()
	if(Input.is_action_just_pressed("lower_sails") and is_sail_up):
		lower_sails()
	
	if(Input.is_action_pressed("move_left")):
		rotation -= delta * ROT_PER_SEC + delta * velocity * ROT_PER_SEC
	if(Input.is_action_pressed("move_right")):
		rotation += delta * ROT_PER_SEC + delta * velocity * ROT_PER_SEC
	
	if(is_sail_up):
		var collision_info := move_and_collide(Vector2.UP.rotated(rotation) * WIND_SPEED * velocity, false)
		if(collision_info):
			if(collision_info.collider is Ship):
				# Deal ramming damage
				var target_dot = Vector2.UP.rotated(rotation).dot((collision_info.collider.position - position).normalized())
				if(target_dot >= 0.9):
					collision_info.collider.deal_damage(5)
			elif(collision_info.collider is Island and not is_immune):
				deal_damage(1)
	
	if(Input.is_action_just_pressed("cannon_port") and is_cannon_ready_port):
		fire_cannon(true, true)
	if(Input.is_action_just_pressed("cannon_starboard") and is_cannon_ready_star):
		fire_cannon(true, false)

func deal_damage(amount:int):
	if(not is_immune):
		is_immune = true
		health -= amount
		health_label.text = "HEALTH: %d" % health
		if(health <= 0):
			get_tree().change_scene("res://scenes/main_menu.tscn")
		yield(get_tree().create_timer(1.5), "timeout")
		is_immune = false

func create_pause_popup():
	var pause_menu = PauseMenu.instance()
	add_child(pause_menu)
	pause_menu.popup()
	pause_menu.rect_global_position = global_position
	get_tree().paused = true
