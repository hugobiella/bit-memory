extends Node2D

@export var package_scene: PackedScene  # imports scene as a var to script
@export var amount_to_generate: int = 1
@export var spacing: float = 0

func _ready():
	generate_packages()
	#if package_scene == null:
		#print("Erro: Cena do pacote não foi definida!")
		#return

func generate_packages():
	for i in range(amount_to_generate):
		var package_instance = package_scene.instantiate() as RigidBody2D
		add_child(package_instance)
		package_instance.position = Vector2(0, i * spacing)
		#print("Pacote gerado na posição: ", package_instance.position)
