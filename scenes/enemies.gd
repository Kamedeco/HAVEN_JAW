extends CharacterBody2D
#const projectile = preload("res://scenes/projectile.tscn")
var inDetection = false
var alive = true
func _on_ready():
	Global.pExists = false

func _physics_process(delta):
	
	#enemy head movement
	$enemyHeadSpr.look_at(Global.player_pos)
	$enemyHeadSpr.set_flip_h(true)
	$enemyHeadSpr.offset.y = 0
	$enemyHeadSpr.offset.x = 16
	if Global.attempt >0 and alive == true:
		$killzone/bodycol.disabled = false
		print("GOOOOOO")
		var vect = Global.player_pos - position + Vector2(-190, -100)
		vect = vect.normalized()
		position += vect*delta*100
		pass
	elif alive == false:
		$killzone/bodycol.disabled = true
		position.y += 6
		$".".rotation += 0.02
func kill():
	alive = false
		
	
