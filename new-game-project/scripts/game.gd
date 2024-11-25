extends Node2D

var input_scene: PackedScene
var input_scene_instance: Node

var arrow = load("res://assets/kenney_cursor-pixel-pack/Tiles/tile_0203.png")
var beam = load("res://assets/kenney_cursor-pixel-pack/Tiles/tile_0120.png")

func _ready():
	Input.set_custom_mouse_cursor(arrow)
	Input.set_custom_mouse_cursor(beam, Input.CURSOR_IBEAM)
	
	input_scene = preload("res://scenes/ui/input_manager.tscn")
	input_scene_instance = input_scene.instantiate()
	add_child(input_scene_instance)
	for child in get_children():
		if child != input_scene_instance:
			child.hide()

func _on_input_received(_amount: int):
	input_scene_instance.queue_free()
	Globals.lock_player = false # unlocks the player for movement
	for child in get_children():
		child.show()
