extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/Level 1/level_one.tscn")


func _on_level_two_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/Level 2/level_two.tscn")


func _on_level_three_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/Level 3/level_three_new.tscn")


func _on_level_four_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/Level 4/level_four.tscn")
