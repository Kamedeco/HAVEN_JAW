extends Area2D


func _on_body_entered(body: Node2D) -> void:
	Global.player_ammo += 8
	print(Global.player_film)
	queue_free()
	
