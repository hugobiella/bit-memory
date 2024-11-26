extends Control

var virtual_addresses = Globals.virtual_address_array
var physical_addresses = Globals.physical_address_array
var shuffled_indices = []
var current_index = 0

@onready var label_va = $Label_va
@onready var label_check = $Label_check
@onready var le_pa = $LE_pa
@onready var le_offset = $LE_offset
@onready var button = $Button
@onready var winsfx = $winsfx
@onready var losesfx = $losesfx

func _ready():
	initialize_random_order()
	update_virtual_address()
	label_check.text = ""
	button.disabled = false

func initialize_random_order():
	shuffled_indices = []
	for i in range(virtual_addresses.size()):
		shuffled_indices.append(i)
	shuffled_indices.shuffle()

func update_virtual_address():
	if current_index < shuffled_indices.size():
		var index = shuffled_indices[current_index]
		var virtual_address = String("%08X" % virtual_addresses[index]).to_upper()
		var expected_offset = String("%03X" % virtual_addresses[index]).to_upper().substr(virtual_address.length() - 3, 3)
		label_va.text = virtual_address

		var expected_pa = ""
		for i in range(physical_addresses.size()):
			var physical_address = String("%08X" % physical_addresses[i]).to_upper()
			var physical_offset = physical_address.substr(physical_address.length() - 3, 3)

			if physical_offset == expected_offset:
				expected_pa = physical_address.substr(0, 5)
				break

		le_pa.placeholder_text = "Endereço Físico"
		le_offset.placeholder_text = "Deslocamento"
	else:
		label_check.text = "Jogo concluído!"
		label_va.text = ""
		button.disabled = true

func _on_button_pressed():
	if current_index >= shuffled_indices.size():
		return

	var index = shuffled_indices[current_index]
	var input_pa = le_pa.text.strip_edges().to_upper()
	var input_offset = le_offset.text.strip_edges().to_upper()

	var virtual_address = String("%08X" % virtual_addresses[index]).to_upper()
	var expected_offset = virtual_address.substr(virtual_address.length() - 3, 3)

	var expected_pa = ""
	for i in range(physical_addresses.size()):
		var physical_address = String("%08X" % physical_addresses[i]).to_upper()
		var physical_offset = physical_address.substr(physical_address.length() - 3, 3)

		if physical_offset == expected_offset:
			expected_pa = physical_address.substr(0, 5)
			break

	print("Comparação:")
	print("Input PA: ", input_pa, " | Expected PA: ", expected_pa)
	print("Input Offset: ", input_offset, " | Expected Offset: ", expected_offset)

	if input_pa == expected_pa and input_offset == expected_offset:
		label_check.text = "Tradução correta!"
		winsfx.play()
		current_index += 1
		update_virtual_address()
		le_pa.text = ""
		le_offset.text = ""
	else:
		label_check.text = "Tradução incorreta!\nTente novamente."
		losesfx.play()
