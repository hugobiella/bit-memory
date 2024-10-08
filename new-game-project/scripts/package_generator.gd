extends Node2D

@export var package_scene: PackedScene
@export var spawn_area_radius: float = 200.0
var packages_generated: Array = []

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	if packages_generated.size() < Globals.amount_to_generate:
		generate_package()

func generate_package():
	var random_angle = randf_range(0, 2 * PI)
	var random_radius = randf_range(0, spawn_area_radius)
	var random_position = Vector2(cos(random_angle), sin(random_angle)) * random_radius
	var package_instance = package_scene.instantiate() as RigidBody2D
	add_child(package_instance)
	package_instance.position = global_position + random_position
	packages_generated.append(package_instance)
