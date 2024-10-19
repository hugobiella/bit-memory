extends Node2D

@export var package_scene: PackedScene
var packages_generated: Array = []

var grid_offset = 250
var grid_columns = 2

func _ready():
	set_physics_process(true)

func _physics_process(_delta):
	if packages_generated.size() < Globals.amount_to_generate:
		generate_package_grid()

func generate_package_grid():
	var count = packages_generated.size()
	var rows = ceil(float(Globals.amount_to_generate) / float(grid_columns))

	for row in range(rows):
		for column in range(grid_columns):
			if count >= Globals.amount_to_generate:
				return
			var position_in_grid = Vector2(column * grid_offset, row * grid_offset)
			generate_package_at_position(position_in_grid)
			count += 1

func generate_package_at_position(position_in_grid: Vector2):
	var package_instance = package_scene.instantiate() as RigidBody2D
	add_child(package_instance)
	package_instance.position = global_position + position_in_grid
	packages_generated.append(package_instance)
