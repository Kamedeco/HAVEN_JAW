extends Node2D
var build_count = 0
var build_cords = 800.0
@onready var tilemaps_2: Node2D = $TILEMAPS2
@onready var tilemaps_3: Node2D = $TILEMAPS3
@onready var tilemaps_4: Node2D = $TILEMAPS4
@export var Film : PackedScene
@export var Can : PackedScene
@export var Baddie : PackedScene
@onready var texture_progress_bar: TextureProgressBar = $Ui/TextureProgressBar
@onready var anima: AnimationPlayer = $Ui/ColorRect/Anima


@onready var rtl: RichTextLabel = $Ui/RichTextLabel
@onready var tutorial: RichTextLabel = $Ui/Tutorial
@onready var dialogue: RichTextLabel = $Ui/Dialogue
@onready var animation_player: AnimationPlayer = $Ui/Dialogue/AnimationPlayer
@onready var timer: Timer = $Timer
@onready var _1a: TileMapLayer = $"1A"
@onready var snapshot: AnimatedSprite2D = $Snapshot
@onready var tilemaps1: Array[TileMapLayer] = [
	$"TILEMAPS2/2A",
	$"TILEMAPS2/2B",
	$"TILEMAPS2/2C",
]
@onready var tilemaps2: Array[TileMapLayer] = [
	$"TILEMAPS3/3A",
	$"TILEMAPS3/3B",
	$"TILEMAPS3/3C"
	]
@onready var tilemaps3: Array[TileMapLayer] = [
	$"TILEMAPS4/4A",
	$"TILEMAPS4/4B",
	$"TILEMAPS4/4C"
	]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Ui/ColorRect/Anima.play("Flash")
	print(Global.attempt)
	if Global.attempt == 0:
		$"1A".enabled = true
		for i in tilemaps1.size():
			$Cat.show()
			tilemaps1[i].enabled = false
		for i in tilemaps2.size():
			tilemaps2[i].enabled = false
		for i in tilemaps3.size():
			tilemaps3[i].enabled = false
	else:
		$Cat.hide()
		$"1A".enabled = false
		for child in $Bushes.get_children():
			if "visible" in child: 
				child.hide() 
		
		for i in tilemaps1.size():
			tilemaps1[i].enabled = false
		var skin = randi_range(0, 2)
		tilemaps1[skin].enabled = true
		
		for i in tilemaps2.size():
			tilemaps2[i].enabled = false
		var skin2 = randi_range(0, 2)
		tilemaps2[skin2].enabled = true
		
		for i in tilemaps3.size():
			tilemaps3[i].enabled = false
		var skin3 = randi_range(0, 2)
		tilemaps3[skin3].enabled = true
	snapshot.play("No")
	if Global.player_pos.x>10000:
		dialogue.text = "[font_size=25] [center] I reached the house! Now I can deliver my pizza!"
		animation_player.play("fade in")
		Global.diaCount += 1
		timer.start()
		tutorial.text = "[font_size=32] [wave][rainbow] [center] YOU WIN!!!"
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	texture_progress_bar.value = Global.player_pos.x*0.5
	
	print (str(Global.player_pos.x) + "  "+  str(build_cords))
	if Global.player_pos.x > build_cords:
		build()
		print("BUILD")
	if Global.attempt == 0:
		$RichTextLabel.show()
		if Global.player_pos.x <0:
			tutorial.text = "[font_size=32] [wave][rainbow] [center] WASD TO MOVE."
		elif Global.player_pos.x <120:
			tutorial.text = "[font_size=32] [wave][rainbow] [center] SPACE TO JUMP"
		elif Global.player_pos.x <1000 and Global.player_pos.x >600 :
			tutorial.text = "[font_size=32] [wave][rainbow] [center] LEFT CLICK TO BOUNCE BACK FROM THE MOUSE"
		elif Global.player_pos.x <1200 and Global.player_pos.x >1000:
				tutorial.text = "[font_size=32] [wave][rainbow] [center] Collect canisters to collect more ammo for jumps!"
		elif Global.player_pos.x <1500 and Global.player_pos.x >1200:
			tutorial.text = "[font_size=32] [wave][rainbow] [center] RIGHT CLICK TO TAKE A PHOTO (place checkpoint, each checkpoint can only be used once)"
		elif Global.player_pos.x <1800 and Global.player_pos.x >1500:
			tutorial.text = "[font_size=32] [wave][rainbow] [center] GOOD LUCK!"
		if Global.player_pos.x > 300 and Global.diaCount == 0:
			dialogue.text = "[font_size=25] [center] I have to deliver this pizza."
			animation_player.play("fade in")
			Global.diaCount += 1
			timer.start()
			
		if Global.player_pos.x >1200 and Global.diaCount == 1:
			dialogue.text = "[font_size=25] [center] Maybe then my girlfriend will unreject me."
			animation_player.play("fade in")
			Global.diaCount += 1
			timer.start()
	else: $RichTextLabel.hide()
			
	if Input.is_action_just_pressed("photo"):
		if Global.player_film >0: 
			$Ui/ColorRect/Anima.play("Flash")
			snapshot.show()
			snapshot.position = Global.player_pos
			snapshot.play("Rep")
			Global.checkpoint = Global.player_pos
			Global.checkpointed = true
			print(Global.checkpoint)
			Global.player_film -= 1
	if Global.checkpointed == false:
		snapshot.play("no")
		print(Global.checkpointed)
	else:
		pass
	rtl.text = "[center][b]Film: [/b]" + str(Global.player_film) + "[/center] + Checkpoint? " + str(Global.checkpointed) + " Ammo " + str(Global.player_ammo) 
			#tutorial.text = "[font_size=32] [wave][rainbow] [center] Right click to take a photo. 
	#If you die your photo location will be your respawn point.
		##	dialogue.text = "[font_size=32][center]I need to deliver this pizza. "
	

func _on_timer_timeout() -> void:
	print("TIME")
	animation_player.play("fade out")
	pass # Replace with function body.


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade out":
		dialogue.text = ""
	
func build() -> void:
	print("BUILD")
	if build_count <4300:
		if build_count == 0:
			for i in tilemaps1.size():
				tilemaps1[i].enabled = false
			var skin = randi_range(0, 2)
			tilemaps1[skin].enabled = true
			tilemaps_2.position.x += 1800
		elif build_count == 1:
			for i in tilemaps2.size():
				tilemaps2[i].enabled = false
			var skin = randi_range(0, 2)
			tilemaps2[skin].enabled = true
			tilemaps_3.position.x += 1800
		elif build_count == 2:
			for i in tilemaps3.size():
				tilemaps3[i].enabled = false
			var skin = randi_range(0, 2)
			tilemaps3[skin].enabled = true
			tilemaps_4.position.x += 1800
			build_count = -1
		build_count += 1
		build_cords += 600
		print("TIME")
		for i in randi_range(0, 3):
			var Film = Film.instantiate()
			add_child(Film)
			Film.global_position.x = build_cords+randi_range(500, 1000)
			Film.global_position.y = randi_range(-200, 200)
		for i in randi_range(1, 2):
			var Can = Can.instantiate()
			add_child(Can)
			Can.global_position.x = build_cords+randi_range(500, 1000)
			Can.global_position.y = randi_range(-200, 200)
		for i in randi_range(1, 2):
			var Bad = Baddie.instantiate()
			add_child(Bad)
			Bad.global_position.x = build_cords+randi_range(500, 1000)
			Bad.global_position.y = randi_range(-200, 200)
		pass # Replace with function body.
