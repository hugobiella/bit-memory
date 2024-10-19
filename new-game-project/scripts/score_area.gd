extends Area2D

@onready var explosion = $Explosion
@onready var label = $Label

func _ready():
	label.add_theme_color_override("font_color", Color(0, 0, 0))
	label.position.y = 70
	label.position.x = -70
	label.show()
	var physical_address = get_random_physical_address()
	label.text = "0x%X" % physical_address

func _on_body_entered(body):
	if body is RigidBody2D:
		explosion.explode()
		Globals.package_exploded = true
		Globals.add_points(10)
		print("deleting package...")
		Globals.being_carried = false
		body.queue_free()

func get_random_physical_address():
	if Globals.physical_address_array.size() == 0:
		print("No more physical addresses available.")
		return 0
		
	var random_index = randi() % Globals.physical_address_array.size()
	var address = Globals.physical_address_array[random_index]
	Globals.physical_address_array.remove_at(random_index)
	return address
