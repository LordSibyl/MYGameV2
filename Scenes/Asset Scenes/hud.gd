extends CanvasLayer
var numKeys := 0
var isInteractable = false
var numCoins := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if isInteractable == true && Input.is_action_just_pressed("interact") == true:
		if numKeys > 0:
			numKeys -= 1
			$keyCount.text = str(numKeys)
			await get_tree().create_timer(.7).timeout
			numCoins +=1
			$coinCount.text = str(numCoins)
			

func _on_key_hitbox_body_entered(_body):
	print("KEY")
	numKeys +=1
	$keyCount.text = str(numKeys)
	
func _on_chest_body_entered(_body):
	isInteractable = true


func _on_chest_body_exited(_body):
	isInteractable = false
