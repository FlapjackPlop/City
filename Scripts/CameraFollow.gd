extends Node3D

@onready var player = $"../Player"

var rotation_speed = 3

var camera_moving = false

func _process(delta):
	if camera_moving:
		camera_to_player(delta)
	
	if global_position.distance_to(player.global_position) > 10 and !camera_moving:
		camera_moving = true
	
	if Input.is_action_pressed("camera_left"):
		rotation.y -= rotation_speed * delta
	
	if Input.is_action_pressed("camera_right"):
		rotation.y += rotation_speed * delta

func camera_to_player(delta):
	global_position = lerp(global_position, player.global_position, 2 * delta)
	
	if global_position.distance_to(player.global_position) < 0.5:
		camera_moving = false
