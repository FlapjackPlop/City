extends CharacterBody3D

@onready var animation_player = $Mesh/AnimationPlayer
@onready var mesh = $Mesh
@onready var mesh_rotation = $MeshRotation
@onready var collider = $Collider

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
	
	if velocity.x != 0 or velocity.z != 0:
		animation_player.play("Running")
	else:
		animation_player.play("Idle")
	
	mesh_rotation.look_at(transform.origin + velocity, Vector3.UP)
	
	var rotation_quat = Quaternion(mesh_rotation.transform.basis)
	var mesh_quat = Quaternion(mesh.transform.basis)
	var slerp_rotation = mesh_quat.slerp(rotation_quat,0.2)
	mesh.transform.basis = Basis(slerp_rotation)
	
	velocity = velocity.normalized() * speed
	move_and_slide()
