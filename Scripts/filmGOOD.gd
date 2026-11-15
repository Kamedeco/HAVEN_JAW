extends Area2D


func _on_body_entered(body: Node2D) -> void:
	Global.player_film += Global.film_multiple
	print("GOATED")
	queue_free()
	
