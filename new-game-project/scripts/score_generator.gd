extends Node2D

@export var package_scene: PackedScene
var score_generated: Array = []

var grid_offset = 250
var grid_columns = 3

func _ready():
	set_physics_process(true)

func _physics_process(_delta):
	if score_generated.size() < Globals.amount_to_generate:
		generate_score_grid()

func generate_score_grid():
	var count = score_generated.size()
	var rows = ceil(float(Globals.amount_to_generate) / float(grid_columns))
	for row in range(rows):
		for column in range(grid_columns):
			if count >= Globals.amount_to_generate:
				return
			var position_in_grid = Vector2(column * grid_offset, row * grid_offset)
			generate_score_at_position(position_in_grid)
			count += 1

func generate_score_at_position(position_in_grid: Vector2):
	var score_instance = package_scene.instantiate() as Area2D
	add_child(score_instance)
	score_instance.position = global_position + position_in_grid
	score_generated.append(score_instance)
