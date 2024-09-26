extends RigidBody2D

@onready var interaction_area: InteractionArea = $InteractionArea

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact():
	var player = get_tree().get_first_node_in_group("player") as CharacterBody2D
	if player.carrying_object == null:
		player.pickup_object(self)
		Globals.being_carried = true
	else:
		player.drop_object()
		Globals.being_carried = false
