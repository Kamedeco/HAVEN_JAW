extends Area2D

var speed = 1
var vect: Vector2 = Vector2.ZERO
var direction = 1 # 1 for right, -1 for left
func _physics_process(delta):
	position += vect * speed * delta

func _on_Bullet_body_entered(body):
	if body.is_in_group("mobs"):
		body.queue_free()
	queue_free()
