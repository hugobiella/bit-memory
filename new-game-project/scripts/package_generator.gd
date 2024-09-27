extends Node2D

@export var package_scene: PackedScene
@export var generation_interval: float = 2.5
@export var max_packages: int = 3
@export var spawn_area_radius: float = 100.0
var packages_generated: Array = []
var time_since_last_generation: float = 0.0

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	time_since_last_generation += delta

	# Gera um pacote se o intervalo de 5 segundos foi atingido e o limite não foi excedido
	if time_since_last_generation >= generation_interval and packages_generated.size() < max_packages:
		generate_package()
		time_since_last_generation = 0.0 # reset timer

	# remove deleted packages from list
	for package in packages_generated:
		if not is_instance_valid(package):
			packages_generated.erase(package)

func generate_package():
	# Gera coordenadas aleatórias dentro da área de spawn circular
	var random_angle = randf_range(0, 2 * PI)  # Ângulo aleatório em radianos
	var random_radius = randf_range(0, spawn_area_radius)  # Raio aleatório
	var random_position = Vector2(cos(random_angle), sin(random_angle)) * random_radius

	# Instancia e posiciona o pacote
	var package_instance = package_scene.instantiate() as RigidBody2D
	add_child(package_instance)
	package_instance.position = global_position + random_position
	
	# Adiciona o pacote à lista de pacotes gerados
	packages_generated.append(package_instance)
