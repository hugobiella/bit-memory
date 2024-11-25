extends Node2D

func _on_button_pressed():
	var line_edit = $LineEdit
	var input_text = line_edit.text.strip_edges()
	if int(input_text) > 12: #max memories in game
		line_edit.text = ""
		line_edit.placeholder_text = "Valor Inválido"
	else:
		Globals.amount_to_generate = int(input_text)
		get_tree().current_scene._on_input_received(Globals.amount_to_generate)
