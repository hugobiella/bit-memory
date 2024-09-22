extends Node2D

@export var package_scene: PackedScene  # imports scene as a var to script
@export var amount_to_generate: int = 5
@export var spacing: float = 150

func _ready():
	generate_packages()
	#if package_scene == null:
		#print("Erro: Cena do pacote não foi definida!")
		#return

func generate_packages():
	for i in range(amount_to_generate):
		var package_instance = package_scene.instantiate() as StaticBody2D  # Cria a instância da caixa
		add_child(package_instance)  # Adiciona o pacote na cena atual

		# Define a posição da caixa relativa ao gerador, com espaçamento vertical
		package_instance.position = Vector2(-500, i * spacing)
		print("Pacote gerado na posição: ", package_instance.position)
