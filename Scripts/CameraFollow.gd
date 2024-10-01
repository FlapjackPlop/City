extends Node3D

@onready var player = $"../Player"
@onready var camera_ray = $CameraRay/CameraRay
@onready var camera_ray_body = $CameraRay
@onready var camera = $Camera

var rotation_speed = 3

var camera_moving = false

func _process(delta):
	if camera_moving:
		camera_to_player(delta)
	rotate_camera(delta)
	
	if global_position.distance_to(player.global_position) > 5 and !camera_moving:
		camera_moving = true
	
	if Input.is_action_pressed("camera_left"):
		rotation.y -= rotation_speed * delta
	
	if Input.is_action_pressed("camera_right"):
		rotation.y += rotation_speed * delta

func rotate_camera(delta):
	camera_ray_body.look_at(player.global_position)
	
	var body = camera_ray.get_collider()
	
	if body != null:
		if body.is_in_group("building"):
			camera.rotation_degrees.x = lerpf(camera.rotation_degrees.x,-35,0.1)
		else:
			camera.rotation_degrees.x = lerpf(camera.rotation_degrees.x,0,0.1)

func camera_to_player(delta):
	global_position = lerp(global_position, player.global_position, 2 * delta)
	
	if global_position.distance_to(player.global_position) < 0.5:
		camera_moving = false
