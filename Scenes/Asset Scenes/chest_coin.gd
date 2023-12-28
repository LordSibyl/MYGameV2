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
				get_node("../Player").canPick = false
	if Input.is_action_just_pressed("drop") and picked == true:
		picked = false
		get_node("../Player").canPick = true
		if get_node("../Player/PlayerTexture").flip_h == false:
			apply_impulse(Vector2(-10, -5), Vector2())
		else:
			apply_impulse(Vector2(10, -5), Vector2())
