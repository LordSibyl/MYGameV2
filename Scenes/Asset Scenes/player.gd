extends CharacterBody2D


var canPick = true
var canPickTorch = true

@export var speed : float = 300.0
@export var jump_velocity : float = -440.0

var direction : Vector2 = Vector2.ZERO

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right", "up", "down")
	if direction:
		velocity.x = direction.x * speed
		if direction.x < 0:
			$PlayerTexture.flip_h = false
			$Marker2D.position.x = -55
			$TorchHand.position.x = 40
		elif  direction.x > 0:
			$PlayerTexture.flip_h = true
			$Marker2D.position.x = 55
			$TorchHand.position.x = -40
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()
	
	
	
	
	
	

	
