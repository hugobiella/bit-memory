extends Node2D

func _on_button_pressed():
	var line_edit = $LineEdit
	var input_text = line_edit.text.strip_edges()

	if input_text == "" or not _is_valid_integer(input_text):
		line_edit.text = ""
		line_edit.placeholder_text = "Entrada inválida"
		return

	var input_value = int(input_text)
	if input_value > 12: #max memories in game
		line_edit.text = ""
		line_edit.placeholder_text = "Valor Inválido"
	else:
		Globals.amount_to_generate = input_value
		get_tree().current_scene._on_input_received(Globals.amount_to_generate)

func _is_valid_integer(value: String) -> bool:
	for character in value:
		if character < '0' or character > '9':
			return false
	return true
