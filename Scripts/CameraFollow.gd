extends Node3D

@onready var player = $"../Player"
@onready var camera_ray = $CameraRay/CameraRay
@onready var camera_ray_body = $CameraRay
@onready var camera = $Camera
@onready var real_camera = $Camera/Camera

var rotation_speed = 3

var camera_moving = false
var driving = false

func _process(delta):
	if camera_moving:
		camera_to_player(delta)
	update_camera(delta)
	
	if global_position.distance_to(player.global_position) > 5 and !camera_moving:
		camera_moving = true
	
	if Input.is_action_pressed("camera_left"):
		rotation.y -= rotation_speed * delta
	
	if Input.is_action_pressed("camera_right"):
		rotation.y += rotation_speed * delta

func update_camera(delta):
	camera_ray_body.look_at(player.global_position)
	
	var body = camera_ray.get_collider()
	
	if body != null and !driving:
		change_fov(75)
		
		if body.is_in_group("building"):
			rotate_camera(-35)
		else:
			rotate_camera(0)
	
	if driving:
		rotate_camera(-35)
		change_fov(100)

func camera_to_player(delta):
	global_position = lerp(global_position, player.global_position, 2 * delta)
	
	if global_position.distance_to(player.global_position) < 0.1:
		camera_moving = false

func rotate_camera(degrees):
	camera.rotation_degrees.x = lerpf(camera.rotation_degrees.x,degrees,0.1)

func change_fov(fov):
	real_camera.fov = lerpf(real_camera.fov,fov,0.1)
