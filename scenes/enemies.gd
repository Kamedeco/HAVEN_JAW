extends CharacterBody2D
const projectile = preload("res://scenes/projectile.tscn")
var inDetection = false

func _on_ready():
	Global.pExists = false

func _physics_process(delta):
	
	#enemy head movement
	$enemyHeadSpr.look_at(get_global_mouse_position())
	$enemyHeadSpr.set_flip_h(true)
	$enemyHeadSpr.offset.y = 0
	$enemyHeadSpr.offset.x = 16
	
	if inDetection == true:
		if Global.pExists == false:
			var p = projectile.instantiate()
			add_child(p)
			p.position = $enemyHeadSpr.position
			p.rotation = $enemyHeadSpr.rotation
			Global.pExists = true


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		inDetection = true
		#projectiles!
		print("hello")

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		inDetection = false
