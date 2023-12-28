extends RigidBody2D


var picked = false


func _physics_process(_delta):
	if picked == true:
		self.position = get_node("../Player/TorchHand").global_position


func _input(_event):
	if Input.is_action_just_pressed("interact"):
		var bodies = $Area2D.get_overlapping_bodies()
		for body in bodies:
			if body.name == "Player" and get_node("../Player").canPickTorch== true:
				picked = true
				get_node("../Player").canPickTorch= false
	if Input.is_action_just_pressed("dropTorch") and picked == true:
		picked = false
		get_node("../Player").canPickTorch= true
		if get_node("../Player/PlayerTexture").flip_h == false:
			apply_impulse(Vector2(-5, -5), Vector2())
		else:
			apply_impulse(Vector2(5, -5), Vector2())

