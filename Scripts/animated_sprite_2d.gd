extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	play("default")

# Called every frame. 'delta' is the elapsed time since the previous fram


func _on_animation_finished() -> void:
	global_position.x = Global.player_pos.x + randi_range(500, 1000)
	global_position.y = Global.player_pos.x + randi_range(-200, 200)
	play("default")
