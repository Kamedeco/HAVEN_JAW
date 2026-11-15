extends RigidBody2D
const SPEED = 10

func _physics_process(delta):
	var vec_to_player = (Global.player_pos - position).normalized()
	rotation = vec_to_player.angle()
	var coll = move_and_collide(vec_to_player * SPEED)
	if coll:
		Global.pExists = false
		self.queue_free()
		


func _on_visible_on_screen_notifier_2d_screen_exited():
	Global.pExists = false
	self.queue_free()
	
