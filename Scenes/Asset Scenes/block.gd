extends RigidBody2D


var picked = false


func _physics_process(_delta):
	if picked == true:
		self.position = get_node("../Player/Marker2D").global_position


func _input(_event):
	if Input.is_action_just_pressed("interact"):
		var bodies = $Area2D.get_overlapping_bodies()
		for body in bodies:
			if body.name == "Player" and get_node("../Player").canPick == true:
				picked = true
				self.set_collision_layer_value(1, false)
				get_node("../Player").canPick = false
	if Input.is_action_just_pressed("drop") and picked == true:
		picked = false
		get_node("../Player").canPick = true
		if get_node("../Player/PlayerTexture").flip_h == false:
			apply_impulse(Vector2(-5, -5), Vector2())
		else:
			apply_impulse(Vector2(5, -5), Vector2())
		await get_tree().create_timer(.05).timeout
		self.set_collision_layer_value(1, true)
	if Input.is_action_just_pressed("throw") and picked == true:
		picked = false
		get_node("../Player").canPick = true
		if get_node("../Player/PlayerTexture").flip_h == false:
			apply_impulse(Vector2(-20, -20), Vector2())
		else:
			apply_impulse(Vector2(20, -20), Vector2())
		await get_tree().create_timer(.05).timeout
		self.set_collision_layer_value(1, true)

