extends Node2D

var being_carried = false
var score = 0

func add_points(points):
	score += points
	print("Pontuação atual: ", score)

func get_score():
	return score
