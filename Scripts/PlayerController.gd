extends CharacterBody3D

var speed = 4

func _physics_process(delta):
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
