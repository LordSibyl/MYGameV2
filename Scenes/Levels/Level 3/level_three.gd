extends Node2D
var showMenu = 0




# Called when the node enters the scene tree for the first time.
func _ready():
	$Menu.hide()
	$Button/ButtonPressed.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("openQuickMenu"):
		if showMenu == 0:
			showMenu += 1
			get_tree().paused = true
			$Menu.show()


func _on_back_2_pressed():
	showMenu -= 1
	get_tree().paused = false
	$Menu.hide()


func _on_button_body_entered(_body):
	$"Level Back/Door".hide()
	$Button/ButtonTile.hide()
	$Button/ButtonPressed.show()
	$Player.set_collision_mask_value(4, false)


func _on_button_body_exited(_body):
	$"Level Back"/Door.show()
	$Button/ButtonTile.show()
	$Button/ButtonPressed.hide()
	$Player.set_collision_mask_value(4, true)


func _on_level_exit_body_entered(_body):
	get_tree().change_scene_to_file("res://Scenes/Levels/Level 4/level_four.tscn")
