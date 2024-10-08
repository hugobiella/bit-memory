extends Node2D

const MAX_SPEED = 1000 # player speed
var being_carried = false
var package_exploded = false
var score = 0

var amount_to_generate = 0

func add_points(points):
	score += points
	print("points: ", score)

func _ready():
	_generate_virtual_address()

# mecânica de traducao de endereços
var page_table = {}
func _generate_virtual_address():
	var virtual_address = randi() % 0xFFFFFFFF
	var page_number = virtual_address >> 12
	if page_number not in page_table:
		page_table[page_number] = randi() % 0xFFFFF
	var offset = virtual_address & 0xFFF
	var physical_address = (page_table[page_number] << 12) | offset
	# print("Endereço Virtual: 0x%X" % virtual_address)
	# print("Endereço Físico: 0x%X" % physical_address)
