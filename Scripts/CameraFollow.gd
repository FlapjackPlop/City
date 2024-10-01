extends Node3D

@onready var player = $"../Player"
@onready var camera_ray = $CameraRay/CameraRay
@onready var camera_ray_body = $CameraRay
@onready var camera = $Camera
@onready var real_camera = $Camera/Camera

var rotation_speed = 3

var driving = false

var target_fov = 65
var fov_ease = 0.1

func _process(delta):
	camera_to_player(delta)
	update_camera(delta)
	
	real_camera.fov = lerpf(real_camera.fov,target_fov,fov_ease)
	
	if Input.is_action_pressed("camera_left"):
		rotation.y -= rotation_speed * delta
	
	if Input.is_action_pressed("camera_right"):
		rotation.y += rotation_speed * delta

func update_camera(delta):
	camera_ray_body.look_at(player.global_position)
	
	var body = camera_ray.get_collider()
	
	if body != null and !driving:
		if body.is_in_group("building"):
			rotate_camera(-35)
		else:
			rotate_camera(0)
	
	if driving:
		rotate_camera(-35)

func camera_to_player(delta):
	global_position = lerp(global_position, player.global_position, 2 * delta)

func rotate_camera(degrees):
	camera.rotation_degrees.x = lerpf(camera.rotation_degrees.x,degrees,0.1)

func change_fov(fov, ease):
	target_fov = fov
	fov_ease = ease
