extends CharacterBody2D
var my_direction = 1
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var interactable = false
var jump_force = 0.1
var impulsed = false
var vect = 0.0
var vect_x = 0
var vect_y = 0
var reload_time = 0.0
##@export var Bullet : PackedScene
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
##@onready var animated_sprite = $AnimatedSprite2D
func _on_ready():
	#print(position.y)
	pass
func _physics_process(delta):
	
	

	#if not is_on_floor():
		#velocity.y += gravity * delta
		#if impulsed == true:
			#velocity.y + vect_y
	#else:
		#impulsed = false
	if not is_on_floor():
			velocity.y += gravity * delta
			
	else:
		impulsed = false

	# Handle jump.add
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY 
	# Get the input direction: -1, 0, 1
	var direction = Input.get_axis("Left", "Right")
	
	# Flip the Sprite
	if direction < 0:
		##animated_sprite.flip_h = false
		pass
		
	elif direction > 0:
		pass
	##	animated_sprite.flip_h = true
	if Input.is_action_just_pressed("Interact") and is_on_floor():
		pass
		if interactable == true:
			pass
			
		pass
	
	# Play animations
	##if is_on_floor():
		##if direction == 0:
			##animated_sprite.play("idle")
		##else:
		##	animated_sprite.play("run")
	##else:
		##animated_sprite.play("jump")
	
	# Apply movement
	if Input.is_action_just_pressed("shoot"):
		if reload_time > 1:
			shoot()
			var vect = get_global_mouse_position() - position
			vect_x = vect.x*jump_force *-300
			vect_y = vect.y*jump_force *1
			#print(velocity.x)
			impulsed = true
			reload_time = 0.0
			velocity.y = vect.y*jump_force *-30
	#print(vect_y)	
	if direction:
		if impulsed == false and is_on_floor():
			velocity.x = direction * SPEED
		#print(velocity.x)
		elif impulsed == false and not is_on_floor():
			velocity.x = direction * SPEED*0.2
		elif impulsed == true and not is_on_floor():
			velocity.x = SPEED*direction*0.5 + vect_x * jump_force
			print("AAA")
		elif impulsed == true and is_on_floor():
			velocity.x = SPEED*direction + vect_x * jump_force
			print("BBB")
		if vect_x >0:
			if velocity.x < vect_x:
				vect_x = velocity.x
			if velocity.x <1 :
				vect_x = 0
		elif vect_x <0:
			if velocity.x > vect_x:
				vect_x = velocity.x
			if velocity.x >-1 :
				vect_x = 0
					
			if velocity.x < vect_x or velocity.x > vect_x:
				vect_x = velocity.x
				
		#print(velocity.x)
	elif impulsed == true:
		velocity.x = vect_x * jump_force
		#print("AAAAA")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if Input.is_action_just_pressed("Left"):
		my_direction = -1
	if Input.is_action_just_pressed("Right"):
		my_direction = 1
	reload_time = reload_time + delta
	#print(reload_time)
	# Add the gravity.
		##velocity.y 
	move_and_slide()
	#print(impulsed)

	


##func _on_vending_machine_body_entered(body: Node2D) -> void:
	##interactable = true
	##print(body.name)
	
func shoot():
	
	pass
	

	
	##var b = Bullet.instantiate()
	##owner.add_child(b)
	##b.transform = $".".global_transform
	##b.global_position.y -= 15
	##b.direction = my_direction
	
