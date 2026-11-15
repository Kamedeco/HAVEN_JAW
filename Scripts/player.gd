extends CharacterBody2D
@onready var arm_2: AnimatedSprite2D = $Arm2
@onready var snapshot: AnimatedSprite2D = $Snapshot
@onready var charecter: AnimatedSprite2D = $charecter
@onready var animated_sprite_2d: AnimatedSprite2D = $Arm2/AnimatedSprite2D
@export var My_bullet : PackedScene
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var my_direction = 1
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var interactable = false
var jump_force = 0.1
var impulsed = false
var vect = 0.0
var active = true
var vect_x = 0
var vect_y = 0
var reload_time = 0.0
##@export var Bullet : PackedScene
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
##@onready var animated_sprite = $AnimatedSprite2D
func _on_ready():
	animated_sprite_2d.play("Flash")
	Global.player_ammo = 5
	Global.player_film = 5
	Global.film_multiple = 1
	Global.checkpoint = Vector2(0, 0)
	Global.checkpointed = false
	#print(position.y)
	pass
func _physics_process(delta):
		
		
	if active == true:
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
			$AnimationPlayer.play("jump")
			velocity.y = JUMP_VELOCITY
		# Get the input direction: -1, 0, 1
		var direction = Input.get_axis("Left", "Right")
		
		# Flip the Sprite
		if direction < 0:
			charecter.flip_h = true
			pass
			
		elif direction > 0:
			charecter.flip_h = false
		if Input.is_action_just_pressed("photo"):
			$AnimationPlayer.play("Shutter")		
		if Input.is_action_just_pressed("Interact") and is_on_floor():
			pass
			if interactable == true:
				pass
				
			pass
		
		# Play animations
		if is_on_floor():
			if direction == 0:
				charecter.play("Idle")
			else:
				charecter.play("Run")
		else:
			charecter.play("Falling")
		##else:
			##animated_sprite.play("jump")
		
		# Apply movement
		if Input.is_action_just_pressed("shoot"):
			if reload_time > 1 and Global.player_ammo >0:
				shoot()
				$AnimationPlayer.play("Shoot")
				Global.player_ammo -= 1
				var vect = get_global_mouse_position() - position
				vect = vect.normalized()*200
				vect_x = vect.x*jump_force *-250
				vect_y = vect.y*jump_force *0.2
				#print(velocity.x)
				impulsed = true
				reload_time = 0.0
				velocity.y = vect.y*jump_force *-15
				animated_sprite_2d.play("Flash")
				var bullet = My_bullet.instantiate()
				bullet.vect = vect
				owner.add_child(bullet)
				bullet.transform = $".".global_transform
	#ANIMATION YIPPPEEE
		var vect_anim = get_global_mouse_position() - position
		var vect_anim_x = vect_anim.x
		if direction == 0:
			if vect_anim_x <0:
				arm_2.play("mid")
			elif vect_anim_x >0:
				arm_2.play("rest")
			#print(vect_y)	
		if direction:
			if impulsed == false and is_on_floor():
				velocity.x = direction * SPEED
			#print(velocity.x)
			elif impulsed == false and not is_on_floor():
				velocity.x = direction * SPEED*0.8
			elif impulsed == true and not is_on_floor():
				velocity.x = SPEED*direction*0.8 + vect_x * jump_force
				$AnimationPlayer.play("Walk")
				#print("AAA")
			elif impulsed == true and is_on_floor():
				velocity.x = SPEED*direction + vect_x * jump_force
				$AnimationPlayer.play("Walk")
				#print("BBB")
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
		$Arm2.look_at(get_global_mouse_position())
		move_and_slide()
		#print(impulsed)

	##func _on_vending_machine_body_entered(body: Node2D) -> void:
		##interactable = true
		##print(body.name)
	Global.player_pos = global_position
func shoot():
	
	pass
	
func respawn():
	active = false
	charecter.flip_h = false
	$Arm2.hide()
	charecter.play("Appear")
	global_position = Global.checkpoint
	$Timer.start()

	
	##var b = Bullet.instantiate()
	##owner.add_child(b)
	##b.transform = $".".global_transform
	##b.global_position.y -= 15
	##b.direction = my_direction
	


func _on_timer_timeout() -> void:
	active = true
	$Arm2.show()
