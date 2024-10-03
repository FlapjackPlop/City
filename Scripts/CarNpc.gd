extends PathFollow3D

@onready var car_ray = $"../CarMesh/CollisionRay"
@onready var car_mesh = $"../CarMesh"
var speed = 7

func _ready():
	car_mesh.global_position = global_position
	progress = 2

func _process(delta):
	if global_position.distance_to(car_mesh.global_position) < 8:
		progress += speed * delta
	
	var direction = car_mesh.global_position.direction_to(global_position)
	
	car_mesh.look_at(global_position)
	if car_mesh.global_position.distance_to(global_position) > 5 and car_ray.get_collider() == null:
		car_mesh.velocity = direction * speed
	else:
		car_mesh.velocity = direction * (speed/2)
	
	car_mesh.move_and_slide()
