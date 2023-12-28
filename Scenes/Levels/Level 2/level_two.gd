extends Node2D
var showMenu = 0

var isButton1Interactable = false
var isButton2Interactable = false

var coin1 = false
var coin2 = false
var coin3 = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Darkness.show()
	$Elevator/ElevatorPlatform/AnimationPlayer.play("MoveDown")
	$Cameras/TopRight.make_current()
	$Player/Camera2D.make_current()
	$Menu.hide()
	$Level/Platforms.hide()
	$Player.set_collision_mask_value(4, true)
	$Player.set_collision_mask_value(11, false)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("openQuickMenu"):
		if showMenu == 0:
			showMenu += 1
			get_tree().paused = true
			$Menu.show()
	if isButton1Interactable == true && Input.is_action_just_pressed("interact") == true:
		$Level/Platforms.show()
		$Player.set_collision_mask_value(11, true)
		await get_tree().create_timer(10).timeout
		$Level/Platforms.hide()
		$Player.set_collision_mask_value(11, false)
	if isButton2Interactable == true && Input.is_action_just_pressed("interact") == true:
		$Coin2.position.x = 1152
		$Coin2.position.y = 128
		$Coin2.linear_velocity = Vector2.ZERO

func _on_back_2_pressed():
	showMenu -= 1
	get_tree().paused = false
	$Menu.hide()

func _on_level_exit_body_entered(_body):
	get_tree().change_scene_to_file("res://Scenes/Levels/Level 3/level_three_new.tscn")

func _on_coin_slot_body_entered(body):
	if  body.name == "Coin" or body.name == "Coin2" or body.name == "Coin3" :
		$CoinSound.play()
		body.queue_free()
		$CoinSlot.queue_free()
		coin1 = true
		get_node("Player").canPick = true
	if coin1 and coin2 and coin3:
		$DoorOpen.play()
		$Level/Door.hide()
		$Player.set_collision_mask_value(4, false)
func _on_coin_slot_2_body_entered(body):
	if  body.name == "Coin" or body.name == "Coin2" or body.name == "Coin3" :
		$CoinSound.play()
		body.queue_free()
		$CoinSlot2.queue_free()
		coin2 = true
		get_node("Player").canPick = true
	if coin1 and coin2 and coin3:
		$DoorOpen.play()
		$Level/Door.hide()
		$Player.set_collision_mask_value(4, false)
func _on_coin_slot_3_body_entered(body):
	if  body.name == "Coin" or body.name == "Coin2" or body.name == "Coin3" :
		$CoinSound.play()
		body.queue_free()
		$CoinSlot3.queue_free()
		coin3 = true
		get_node("Player").canPick = true
	if coin1 and coin2 and coin3:
		$DoorOpen.play()
		$Level/Door.hide()
		$Player.set_collision_mask_value(4, false)

func _on_top_left_play_area_body_entered(_body):
	$Cameras/TopLeft.make_current()
func _on_top_right_play_area_body_entered(_body):
	$Cameras/TopRight.make_current()
func _on_bottom_right_play_area_body_entered(_body):
	$Cameras/BottomRight.make_current()
func _on_bottom_left_play_area_body_entered(_body):
	$Cameras/BottomLeft.make_current()

func _on_elevator_area_body_entered(_body):
	$Elevator/ElevatorPlatform/ElevatorCam.make_current()
	$Level/Door.show()
	$DoorClose.play()
	$Player.set_collision_mask_value(4, true)
	$ElevatorSound.play()
	await  get_tree().create_timer(1).timeout
	$Elevator/ElevatorPlatform/AnimationPlayer.play("MoveUp")

func _on_button_body_entered(_body):
	isButton1Interactable = true
func _on_button_body_exited(_body):
	isButton1Interactable = false

func _on_button_2_body_entered(_body):
	isButton2Interactable = true
func _on_button_2_body_exited(_body):
	isButton2Interactable = false

func _on_spikes_body_entered(_body):
	$Player.position.x = 968
	$Player.position.y = 128
	$Coin2.position.x = 1152
	$Coin2.position.y = 128
	get_node("Coin2").picked = false
	get_node("Player").canPick = true

func _on_pressure_plate_body_entered(_body):
	$DoorOpen.play()
	$ForegroundTiles/CoinPrison.hide()
	$PressurePlate/ButtonTile.hide()
	$Player.set_collision_layer_value(17, false)
	$Player.set_collision_mask_value(17, false)
	
func _on_pressure_plate_body_exited(_body):
	$DoorClose.play()
	$ForegroundTiles/CoinPrison.show()
	$PressurePlate/ButtonTile.show()
	$Player.set_collision_mask_value(17, true)
	$Player.set_collision_mask_value(17, true)
