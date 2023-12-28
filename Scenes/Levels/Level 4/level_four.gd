extends Node2D
var showMenu = 0

var isInteractable = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$Menu.hide()
	$PlateButton/ButtonPressed.hide()
	$"Moving platform2".hide()
	$"Moving platform2/Platform".set_collision_layer_value(1, false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("openQuickMenu"):
		if showMenu == 0:
			showMenu += 1
			get_tree().paused = true
			$Menu.show()
	if isInteractable == true && Input.is_action_just_pressed("interact") == true:
		$Block.position.x = 152
		$Block.position.y = 464
		$Block.linear_velocity = Vector2.ZERO
		await get_tree().create_timer(1).timeout


func _on_back_pressed():
	showMenu -= 1
	get_tree().paused = false
	$Menu.hide()


func _on_button_hitbox_body_entered(_body):
	isInteractable = true


func _on_button_hitbox_body_exited(_body):
	isInteractable = false


func _on_level_exit_body_entered(_body):
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_plate_button_body_entered(_body):
	$"Moving platform2".show()
	$PlateButton/ButtonPressed.show()
	$PlateButton/ButtonTile.hide()
	$"Moving platform2/Platform".set_collision_layer_value(1, true)
	$Player.set_collision_mask_value(4, false)
	$LevelBack/Door.hide()


func _on_plate_button_body_exited(_body):
	$"Moving platform2".hide()
	$PlateButton/ButtonPressed.hide()
	$PlateButton/ButtonTile.show()
	$"Moving platform2/Platform".set_collision_layer_value(1, false)
	$Player.set_collision_mask_value(4, true)
	$LevelBack/Door.show()


func _on_area_2d_body_entered(body):
	get_tree().change_scene_to_file("res://Scenes/Levels/Level 4/level_four.tscn")
