extends Node3D

@onready var player = $Player
@onready var dialogue = $CanvasLayer/Dialogue

@onready var sofia = $Sofia
@onready var sofia_animation_player = $Sofia/Mesh/AnimationPlayer
var sofia_dialogue = ["Hey/Sofia","Hi/Me","Tough day/Sofia","We got the closing shift.../Sofia","Again.../Sofia"
, "I wonder why we are always the ones to close up/Me","Because Bruno is too fucking lazy to do it himself/Sofia","Yea i guess/Me"
,"Have a good night/Sofia","Yea you too/Me"]
var sofia_talking = false

func _process(delta):
	sofia_animation_player.play("Texting")
	if sofia_talking:
		if dialogue.read_dialogue(sofia_dialogue):
			sofia_talking = false
	
	if player.global_position.distance_to(sofia.global_position) < 1:
		if Input.is_action_just_pressed("interact") and !sofia_talking:
			sofia_talking = true
