extends ProgressBar

func _process(_delta):
	max_value = Globals.amount_to_generate
	value = Globals.score

	if value >= max_value && Globals.lock_player == false:
		get_tree().change_scene_to_file("res://scenes/phase2.tscn")
