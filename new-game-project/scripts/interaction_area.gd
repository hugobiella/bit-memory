extends Area2D
class_name InteractionArea

@export var action_name: String = "interect"

var interact: Callable = func():
	pass

func _on_body_entered(body):
	#print("player in")
	InteractionManager.register_area(self)

func _on_body_exited(body):
	#print("player out")
	InteractionManager.unregister_area(self)
