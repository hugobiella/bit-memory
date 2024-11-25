extends Control
@onready var grid_container: GridContainer = $RightPanel/GridContainer
@onready var le_pa: LineEdit = $LeftPanel/LE_pa

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

	grid_container.columns = 3  # Alteração para 3 colunas

	# Adicionando os cabeçalhos com uma coluna vazia no meio
	grid_container.add_child(create_label("Número de Página"))
	grid_container.add_child(create_label(" "))  # Coluna do meio vazia
	grid_container.add_child(create_label("Número de Quadro"))

	for virtual_address in Globals.virtual_address_array:
		var formatted_virtual_address = "%05X" % (virtual_address >> 12)
		for physical_address in Globals.physical_address_array:
			if extract_offset(virtual_address) == extract_offset(physical_address):
				var formatted_physical_address = "%05X" % (physical_address >> 12)

				# Preenchendo as colunas com dados e uma vazia no meio
				grid_container.add_child(create_disabled_button(formatted_virtual_address))  # Botão desabilitado
				grid_container.add_child(create_label(" > "))  # Coluna do meio vazia
				grid_container.add_child(create_button(formatted_physical_address, le_pa))  # Botão interativo

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

func create_disabled_button(text) -> Button:
	var button = Button.new()
	button.text = text
	button.add_theme_font_size_override("font_size", 21)
	button.disabled = true  
	return button

func _on_button_pressed(value: String, target_line_edit: LineEdit):
	target_line_edit.text = value

func extract_offset(address):
	var offset = address & 0xFFF
	return offset
