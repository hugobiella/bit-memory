extends Node2D

func explode():
	$CPUParticles2D.position = position
	$CPUParticles2D.emitting = true
