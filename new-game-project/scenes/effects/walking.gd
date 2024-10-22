extends Node2D

@onready var particles = $CPUParticles2D  # Referência ao nó de partículas

func _ready():
	particles.emitting = false  # Certifique-se de que as partículas estão desativadas no início

func start_particles():
	particles.emitting = true

func stop_particles():
	particles.emitting = false
