extends CharacterBody3D

@onready var front = $Front
@onready var camera = $"../Camera"
@onready var exit_point = $ExitPoint

var speed = 10

var turn_degrees = 0
var current_speed = 0

var interactable = false
var driving = false
var exiting = false

var driver = null

func _physics_process(delta):
	if interactable and !exiting:
		if Input.is_action_just_released("interact"):
			driving = true
	
	if driving:
		drive(delta)
		
		driver.global_position = global_position
		driver.collider.disabled = true
		driver.hide()
		
		camera.change_fov(100,0.01)
		
		if Input.is_action_just_pressed("interact"):
			driving = false
			camera.driving = false
			driver.collider.disabled = false
			driver.global_position = exit_point.global_position
			driver.show()
			exiting = true
			camera.change_fov(65,0.01)

func drive(delta):
	camera.driving = true
	
	if Input.is_action_pressed("up"):
		current_speed = lerpf(current_speed, speed, 0.05)
	if Input.is_action_pressed("down"):
		current_speed = lerpf(current_speed, -speed/2, 0.05)
	if !Input.is_action_pressed("up") and !Input.is_action_pressed("down"):
		current_speed = lerpf(current_speed, 0, 0.05)
	
	if Input.is_action_pressed("left"):
		turn_degrees = lerpf(turn_degrees, 1, 0.05)
		if current_speed > 5:
			rotation_degrees.x = lerpf(rotation_degrees.x,-10,0.2)
	if Input.is_action_pressed("right"):
		turn_degrees = lerpf(turn_degrees, -1, 0.05)
		if current_speed > 5:
			rotation_degrees.x = lerpf(rotation_degrees.x,10,0.2)
	if !Input.is_action_pressed("right") and !Input.is_action_pressed("left"):
		turn_degrees = lerpf(turn_degrees, 0, 0.05)
		rotation_degrees.x = lerpf(rotation_degrees.x,0,0.2)
	
	var direction = global_position.direction_to(front.global_position)
	
	velocity = direction * current_speed
	rotation_degrees.y += turn_degrees
	
	move_and_slide()

func _on_interaction_area_body_entered(body):
	if body.is_in_group("player"):
		interactable = true
		driver = body

func _on_interaction_area_body_exited(body):
	if body.is_in_group("player"):
		interactable = false
		exiting = false
