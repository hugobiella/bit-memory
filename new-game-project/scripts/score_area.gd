extends Area2D

@onready var explosion = $Explosion
@onready var label = $Label
@onready var uncheck_sprite = $uncheck
@onready var check_sprite = $check

func _ready():
	label.add_theme_color_override("font_color", Color(0, 0, 0))
	label.position.y = 70
	label.position.x = -50
	label.show()
	uncheck_sprite.visible = false
	check_sprite.visible = true
	physical_address = get_random_physical_address()
	label.text = " "

var physical_address
var virtual_offset
var physical_offset
var body_script

func _on_body_entered(body):
	if body is RigidBody2D:
		body_script = body.get_script()
		virtual_offset = body.get_offset()
		if virtual_offset == physical_offset && Globals.being_carried == false:
			explosion.explode()
			Globals.package_exploded = true
			Globals.add_points(1)
			Globals.being_carried = false
			body.queue_free()
			update_sprite_visibility()
			label.position.x = -50
			label.text = "0x%05X" % [physical_address]

func update_sprite_visibility():
	uncheck_sprite.visible = true
	check_sprite.visible = false

func get_random_physical_address():
	var random_index = randi() % Globals.physical_address_array.size()
	var address = Globals.physical_address_array[random_index]
	Globals.physical_address_array.remove_at(random_index)
	physical_offset = address & 0xFFF
	address = address >> 12
	return address
