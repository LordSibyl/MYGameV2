extends Node2D
var showMenu = 0
var Player = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player/Camera2D.make_current()
	$Menu.hide()
	$ChestCoin.hide()
	$ChestCoin.freeze = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("openQuickMenu"):
		if showMenu == 0:
			showMenu += 1
			get_tree().paused = true
			$Menu.show()
	if Input.is_action_just_pressed("switch cam"):
		if Player:
			Player = false
			$AntiPlayer/Camera2D.make_current()
		else:
			Player = true
			$Player/Camera2D.make_current()


func _on_chest_body_entered(body):
	body.queue_free()
	get_node("Player").canPick = true
	get_node("AntiPlayer").canPick = true
	$Chest/AnimatedSprite2D.play("Open")
	await get_tree().create_timer(.4).timeout
	$Chest.queue_free()


func _on_back_pressed():
	showMenu -= 1
	get_tree().paused = false
	$Menu.hide()


func _on_chest_new_show_item():
	$ChestCoin.show()
	await get_tree().create_timer(.1).timeout
	$ChestCoin.freeze = false
