extends Node2D

var input_scene: PackedScene
var input_scene_instance: Node

#func _physics_process(delta):
	#print(Globals.physical_address_array)

func _ready():
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
