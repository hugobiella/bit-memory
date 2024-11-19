extends Control
@onready var grid_container: GridContainer = $RightPanel/GridContainer
@onready var le_pa: LineEdit = $LeftPanel/LE_pa
@onready var le_offset: LineEdit = $LeftPanel/LE_offset

func _ready():
	print("Virtual Address Array:")
	for address in Globals.virtual_address_array:
		print("%08X" % address)
	print("Physical Address Array:")
	for address in Globals.physical_address_array:
		print("%08X" % address)
	print("\n")
	if grid_container == null:
		print("Erro: GridContainer não encontrado!")
		return

	grid_container.columns = 3
	grid_container.add_child(create_label("Endereço Lógico  "))
	grid_container.add_child(create_label("Endereço Físico  "))
	grid_container.add_child(create_label("Deslocamento"))
	grid_container.add_child(create_label(" "))
	grid_container.add_child(create_label(" "))
	grid_container.add_child(create_label(" "))

	for virtual_address in Globals.virtual_address_array:
		var offset_virtual = extract_offset(virtual_address)
		var formatted_virtual_address = virtual_address >> 12
		formatted_virtual_address = "%05X" % formatted_virtual_address
		var formatted_offset_virtual = "%03X" % offset_virtual
		
		for physical_address in Globals.physical_address_array:
			var offset_physical = extract_offset(physical_address)
			
			if offset_virtual == offset_physical:
				var formatted_physical_address = physical_address >> 12
				formatted_physical_address = "%05X" % formatted_physical_address

				grid_container.add_child(create_label(formatted_virtual_address))
				grid_container.add_child(create_button(formatted_physical_address, le_pa))
				grid_container.add_child(create_button(formatted_offset_virtual, le_offset))
				
				print("Endereço Virtual e Físico correspondem: ", formatted_virtual_address, " --> ", formatted_physical_address)
				break

func create_label(text) -> Label:
	var label = Label.new()
	label.text = text
	label.add_theme_font_size_override("font_size", 21)
	return label

func create_button(text, target_line_edit: LineEdit) -> Button:
	var button = Button.new()
	button.text = text
	button.add_theme_font_size_override("font_size", 21)
	button.pressed.connect(Callable(self, "_on_button_pressed").bind(text, target_line_edit))
	return button

func _on_button_pressed(value: String, target_line_edit: LineEdit):
	target_line_edit.text = value

func extract_offset(address):
	var offset = address & 0xFFF
	return offset
