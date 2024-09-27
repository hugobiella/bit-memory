extends Area2D

func _on_body_entered(body):
	print("body detected: ", body.name)
	if body is RigidBody2D and body.name == "package":
		var player = get_tree().get_first_node_in_group("player") as CharacterBody2D
		Globals.package_exploded = true
		Globals.add_points(10)
		print("deleting package...")
		body.queue_free()
