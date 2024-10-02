extends Node3D

@onready var player = $Player
@onready var dialogue = $CanvasLayer/Dialogue

@onready var sofia = $Sofia
@onready var sofia_animation_player = $Sofia/Mesh/AnimationPlayer
@export var sofia_dialogue : String

func _process(delta):
	sofia_animation_player.play("Texting")
	
	if player.global_position.distance_to(sofia.global_position) < 1:
		if Input.is_action_just_pressed("interact") and !dialogue.talking:
			dialogue.start_dialogue(read_file(sofia_dialogue))

func read_file(file_path):
	var file = FileAccess.open(file_path, FileAccess.READ)
	var content = file.get_as_text()
	return content
