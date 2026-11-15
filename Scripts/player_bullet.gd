extends Area2D

var speed = 1
var vect: Vector2 = Vector2.ZERO
var direction = 1 # 1 for right, -1 for left
func _physics_process(delta):
	position += vect * speed * delta

func _on_Bullet_body_entered(body):
	print("I'm inside")
	if body.is_in_group("enemy"):
		body.queue_free()
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	print("I'm inside")
	print("Body groups: ", body.get_groups())
	if body.is_in_group("enemy"):
		
		body.kill()
		queue_free()
