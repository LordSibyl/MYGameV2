extends Node2D
var showMenu = 0
var isSwitchInteractable = false
var isButtonInteractable = false
var doorOpen = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Darkness.show()
	$Elevator/ElevatorPlatform/AnimationPlayer.play("MoveDown")
	$Level1.make_current()
	$Player.set_collision_mask_value(4, true)
	$Menu.hide()
	$Tutorial.hide()
	$switch/on.hide()
	$Coin.hide()
	$ButtonPlate/ButtonPressed.hide()
	$Tutorial4.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("openQuickMenu"):
		if showMenu == 0:
			showMenu += 1
			get_tree().paused = true
			$Menu.show()
			
	#activate switch when the player is inside it and the correct key is pressed
	if isSwitchInteractable == true && Input.is_action_just_pressed("interact") == true:
		if doorOpen == false:
			doorOpen = true
			$Sounds/DoorOpen.play()
			$switch/on.show()
			$switch/off.hide()
			$Level/Door1.hide()
			$Player.set_collision_mask_value(4, false)
		else:
			doorOpen = false
			$Sounds/DoorClose.play()
			$switch/on.hide()
			$switch/off.show()
			$Level/Door1.show()
			$Player.set_collision_mask_value(4, true)
			
	#Activates button when player is inside it and the correct key is pressed
	if isButtonInteractable == true && Input.is_action_just_pressed("interact") == true:
		$Level/Door4.hide()
		$Sounds/DoorOpen.play()
		$Player.set_collision_mask_value(4, false)
		await get_tree().create_timer(1.2).timeout
		$Level/Door4.show()
		$Sounds/DoorClose.play()
		$Player.set_collision_mask_value(4, true)

#Sends player to the next level
func _on_level_exit_body_entered(_body):
	get_tree().change_scene_to_file("res://Scenes/Levels/Level 2/level_two.tscn")

#Removes menu by pressing button (Need to fix this)
func _on_back_2_pressed():
	showMenu -= 1
	get_tree().paused = false
	$Menu.hide()

#______________________First Quarter of Level___________________
#Determines if player can interact with switch
func _on_area_2d_body_entered(_body):
	isSwitchInteractable = true
	$Tutorial.show()
func _on_area_2d_body_exited(_body):
	isSwitchInteractable = false
	$Tutorial.hide()
#Switches camera to the next part of the level
func _on_level_1_play_area_body_exited(_body):
	$Level/Door1.show()
	$Sounds/DoorClose.play()
	$Player.set_collision_mask_value(4, true)
	$Level2.make_current()

#_____________________Second Quarter of Level__________________________________
#Trigers chest to open when key colides with it
func _on_chest_body_entered(_body):
	get_node("Player").canPick = true
	$Key.queue_free()
	$Chest/AnimatedSprite2D.play("Open")
	$Sounds/ChestOpen.play()
	await get_tree().create_timer(.4).timeout
	$Coin.show()
	await get_tree().create_timer(.1).timeout
	$Coin.freeze = false
	$Chest.queue_free()
#opens door to next part when coin collides with it
func _on_coin_slot_body_entered(_body):
	get_node("Player").canPick = true
	$Coin.queue_free()
	$Sounds/CoinSound.play()
	await get_tree().create_timer(1).timeout
	$"Coin Slot".queue_free()
	$Level/Door2.hide()
	$Sounds/DoorOpen.play()
	$Player.set_collision_mask_value(4, false)
#Switches camera to the next part of the level
func _on_level_2_play_area_body_exited(_body):
	$Level/Door2.show()
	$Player.set_collision_mask_value(4, true)
	$Level3.make_current()
	$Block.set_collision_layer_value(1, true)
	$Block.set_collision_mask_value(1, true)

#__________________________Third Quarter of Level_______________
#Triggers ButtonPlate acction
func _on_button_plate_body_entered(_body):
	$Level/Door3.hide()
	$Sounds/DoorOpen.play()
	$ButtonPlate/ButtonTile.hide()
	$ButtonPlate/ButtonPressed.show()
	$Player.set_collision_mask_value(4, false)
func _on_button_plate_body_exited(_body):
	$Level/Door3.show()
	$Sounds/DoorClose.play()
	$ButtonPlate/ButtonTile.show()
	$ButtonPlate/ButtonPressed.hide()
	$Player.set_collision_mask_value(4, true)
#Switches camera to the next part of the level
func _on_level_3_play_area_body_exited(_body):
	$Level/Door3.show()
	$Sounds/DoorClose.play()
	$Player.set_collision_mask_value(4, true)
	$Level4.make_current()

#______________________Fourth Quarter of Level_______________________
#determines if player can interact with button
func _on_button_hitbox_body_entered(_body):
	isButtonInteractable = true
	$Tutorial4.show()
func _on_button_hitbox_body_exited(_body):
	isButtonInteractable = false
	$Tutorial4.hide()
func _on_level_4_play_area_body_exited(_body):
	$Level/Door4.show()
	$Sounds/DoorClose.play()
	$Elevator/ElevatorPlatform/ElevatorCam.make_current()
	$Sounds/ElevatorSound.play()
	await  get_tree().create_timer(1).timeout
	$Elevator/ElevatorPlatform/AnimationPlayer.play("MoveUp")
	
