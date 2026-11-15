extends AnimatedSprite2D
var rng = RandomNumberGenerator.new()
var skin
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	skin = randi_range(1, 5)
	play(str(skin))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	pass
