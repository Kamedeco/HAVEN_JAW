extends Area2D
@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("DIED")
		Engine.time_scale = 1
		if Global.checkpointed:
			body.respawn() 
			Global.checkpointed = false
		else:
			body.get_node("CollisionShape2D").queue_free()
			timer.start()
			Global.attempt +=1
		pass # Replace with function body.


func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	if Global.checkpointed:
		pass
	else:
		get_tree().reload_current_scene()
