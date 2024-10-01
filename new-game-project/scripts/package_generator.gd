extends Node2D

@export var package_scene: PackedScene
@export var generation_interval: float = 2.5
@export var max_packages: int = 3
@export var spawn_area_radius: float = 500.0
var packages_generated: Array = []
var time_since_last_generation: float = 0.0

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	time_since_last_generation += delta

	# spawns package every 5 seconds if not limit exceeded
	if time_since_last_generation >= generation_interval and packages_generated.size() < max_packages:
		generate_package()
		time_since_last_generation = 0.0 # reset timer

	# remove deleted packages from list
	for package in packages_generated:
		if not is_instance_valid(package):
			packages_generated.erase(package)

func generate_package():
	var random_angle = randf_range(0, 2 * PI)
	var random_radius = randf_range(0, spawn_area_radius)
	var random_position = Vector2(cos(random_angle), sin(random_angle)) * random_radius

	var package_instance = package_scene.instantiate() as RigidBody2D
	add_child(package_instance)
	package_instance.position = global_position + random_position
	
	# add package to list
	packages_generated.append(package_instance)
