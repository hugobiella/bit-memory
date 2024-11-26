extends Node2D

func _on_button_pressed():
	var line_edit = $LineEdit
	var input_text = line_edit.text.strip_edges()
	
	# Verifica se a entrada é vazia ou contém caracteres não numéricos
	if input_text == "" or not _is_valid_integer(input_text):
		line_edit.text = ""
		line_edit.placeholder_text = "Entrada inválida"
		return
	
	# Converte a entrada para inteiro e verifica o limite
	var input_value = int(input_text)
	if input_value > 12: # Máximo permitido
		line_edit.text = ""
		line_edit.placeholder_text = "Valor Inválido"
	else:
		Globals.amount_to_generate = input_value
		get_tree().current_scene._on_input_received(Globals.amount_to_generate)

# Função auxiliar para verificar se a string é um número inteiro válido
func _is_valid_integer(value: String) -> bool:
	for char in value:
		# Verifica se cada caractere está entre '0' e '9'
		if char < '0' or char > '9':
			return false
	return true
