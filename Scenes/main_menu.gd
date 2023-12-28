extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/Level 1/level_one.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_level_select_pressed():
	get_tree().change_scene_to_file("res://Scenes/levels.tscn")


func _on_dev_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/testing.tscn")
