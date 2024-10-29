extends Node2D

@onready var particles = $CPUParticles2D

func _ready():
	particles.emitting = false

func start_particles():
	particles.emitting = true

func stop_particles():
	particles.emitting = false
