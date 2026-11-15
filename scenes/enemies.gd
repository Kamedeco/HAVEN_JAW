extends CharacterBody2D

func _physics_process(delta):
	
	#enemy head movement
	$enemyHeadSpr.look_at(get_global_mouse_position())
	$enemyHeadSpr.set_flip_h(true)
	
