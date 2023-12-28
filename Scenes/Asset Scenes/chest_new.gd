extends Area2D

var opened = false

signal show_item


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass




func _on_body_entered(body):
	if !opened:
		get_node("../Player").canPick = true
		body.queue_free()
		$AnimatedSprite2D.play("Open")
		$Sounds/ChestOpen.play()
		await get_tree().create_timer(.4).timeout
		emit_signal("show_item")
