extends Node2D
@onready var rtl: RichTextLabel = $CanvasLayer/RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rtl.text = "[center][b]Film: [/b]" + str(Global.player_film) + "[/center] + Checkpoint? " + str(Global.checkpointed) + " Ammo " + str(Global.player_ammo) 
