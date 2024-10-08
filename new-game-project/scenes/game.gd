extends Node2D

var input_scene: PackedScene
var input_scene_instance: Node

func _ready():
	# Carregar a cena de entrada
	input_scene = preload("res://scenes/ui/input scene.tscn")  # Ajuste o caminho conforme necessário
	input_scene_instance = input_scene.instantiate()
	add_child(input_scene_instance)
	
	# Ocultar outros nós da cena principal
	for child in get_children():
		if child != input_scene_instance:
			child.hide()

func _on_input_received(amount: int):
	# Remover a cena de entrada e mostrar o resto do jogo
	input_scene_instance.queue_free()
	
	# Mostrar outros nós
	for child in get_children():
		child.show()
