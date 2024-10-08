extends Area2D

@onready var explosion = $Explosion

func _on_body_entered(body):
	if body is RigidBody2D:
		explosion.explode()
		Globals.package_exploded = true
		Globals.add_points(10)
		print("deleting package...")
		Globals.being_carried = false # reset value for label to show
		body.queue_free()
