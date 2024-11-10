extends RigidBody2D
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var label = $Label

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	_generate_virtual_address()
	label.add_theme_color_override("font_color", Color(0, 0, 0))
	label.position.y = 50
	label.position.x = -50
	label.show()

func _on_interact():
	var player = get_tree().get_first_node_in_group("player") as CharacterBody2D
	if player.carrying_object == null:
		player.pickup_object(self)
		Globals.being_carried = true
	else:
		player.drop_object()
		Globals.being_carried = false

var virtual_address = 0
var page_number = 0
var offset = 0
var page_table = {}

func _generate_virtual_address():
	virtual_address = randi() % 0xFFFFFFFF
	page_number = virtual_address >> 12
	if page_number not in page_table:
		page_table[page_number] = randi() % 0xFFFFF
	offset = virtual_address & 0xFFF
	var physical_address = (page_table[page_number] << 12)
	Globals.virtual_address_array.append(virtual_address)
	Globals.physical_address_array_copy.append(physical_address)
	label.text = "0x%05X" % [page_number]

func get_offset():
	return offset
