extends Control

@onready var speaker_text = $Speaker
@onready var dialogue_text = $Dialogue
@onready var camera = $"../../Camera"

var showing = false
var talking = false
var full_dialogue = ""
var line = 0

func _process(delta):
	dialogue_text.visible_ratio += delta
	
	if showing:
		if Input.is_action_just_pressed("next"):
			reset_dialogue()
			line += 1
	
	if talking:
		read_dialogue(full_dialogue)

func start_dialogue(dialogue):
	talking = true
	full_dialogue = dialogue

func read_dialogue(txt):
	camera.change_fov(30,0.01)
	var dialogue = txt.split(";")
	
	if line < dialogue.size() and current_dialogue() == "":
		var split_dialogue = dialogue[line].split("/")
		
		new_dialogue(split_dialogue[1],split_dialogue[0])
	elif line >= dialogue.size():
		line = 0
		camera.change_fov(65,0.01)
		talking = false
		full_dialogue = ""

func new_dialogue(speaker, text):
	dialogue_text.visible_ratio = 0
	
	speaker_text.text = "[center]" + speaker + "[/center]"
	dialogue_text.text = "[center]" + text + "[/center]"
	
	showing = true

func reset_dialogue():
	speaker_text.text = ""
	dialogue_text.text = ""
	
	showing = false

func current_dialogue():
	return dialogue_text.text
