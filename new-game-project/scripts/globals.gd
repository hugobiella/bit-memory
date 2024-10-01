extends Node2D

var being_carried = false
var package_exploded = false
const MAX_SPEED = 1000 # player speed
var score = 0

func add_points(points):
	score += points
	print("points: ", score)

func get_score():
	return score
