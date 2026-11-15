extends Node2D
@onready var rich_text_label: RichTextLabel = $Ui/RichTextLabel
@onready var tutorial: RichTextLabel = $Ui/Tutorial
@onready var dialogue: RichTextLabel = $Ui/Dialogue
@onready var animation_player: AnimationPlayer = $Ui/Dialogue/AnimationPlayer
@onready var timer: Timer = $Timer
@onready var _1a: TileMapLayer = $"1A"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(Global.attempt)
	if Global.attempt == 0:
		$"1A".enabled = true
	else:
		$"1A".enabled = false
		for child in $Bushes.get_children():
			if "visible" in child: 
				child.hide() 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
		
		
	else:
		pass
		#rtl.text = "[center][b]Film: [/b]" + str(Global.player_film) + "[/center] + Checkpoint? " + str(Global.checkpointed) + " Ammo " + str(Global.player_ammo) 
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
	
