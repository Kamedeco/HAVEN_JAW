extends CharacterBody2D
const projectile = preload("res://scenes/projectile.tscn")
var inDetection = false

func _on_ready():
	Global.pExists = false

func _physics_process(delta):
	
	#enemy head movement
	$enemyHeadSpr.look_at(Global.player_pos)
	$enemyHeadSpr.set_flip_h(true)
	$enemyHeadSpr.offset.y = 0
	$enemyHeadSpr.offset.x = 16
