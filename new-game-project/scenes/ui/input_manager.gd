extends Node2D

func _on_button_pressed():
	var input_text = $LineEdit.text.strip_edges()
	var input_value = input_text.to_int()
	Globals.amount_to_generate = int(input_text)
	print("Amount to generate: %d" % Globals.amount_to_generate)
	get_tree().current_scene._on_input_received(Globals.amount_to_generate)
