extends CharacterBody3D

var speed = 5

func _physics_process(delta):
	print(Engine.get_frames_per_second())
	
	if Input.is_action_pressed("up"):
		velocity.z = -speed
	elif Input.is_action_pressed("down"):
		velocity.z = speed
	else:
		velocity.z = 0
	
	if Input.is_action_pressed("right"):
		velocity.x = speed
	elif Input.is_action_pressed("left"):
		velocity.x = -speed
	else:
		velocity.x = 0
	
	velocity = velocity.normalized() * speed
	move_and_slide()
