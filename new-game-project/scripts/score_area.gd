extends Area2D



func _on_body_entered(body):
	print("Corpo detectado: ", body.name)
	if body is RigidBody2D and body.name == "package":
		Globals.add_points(10)
		print("Excluindo package")
		body.queue_free()
