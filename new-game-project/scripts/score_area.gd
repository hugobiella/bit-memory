extends Area2D

func _on_body_entered(body):
	var player = get_tree().get_first_node_in_group("player") as CharacterBody2D
	#print("body detected: ", body.name)
	if body is RigidBody2D:
		Globals.package_exploded = true
		Globals.add_points(10)
		print("deleting package...")
		Globals.being_carried = false # reset value for label to show
		body.queue_free()
		
