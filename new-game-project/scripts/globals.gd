extends Node2D

const MAX_SPEED = 1000 # player speed
var being_carried = false
var package_exploded = false
var lock_player = true
var score = 0

var amount_to_generate = 0
var physical_address_array = []
var physical_address_array_copy = []
var virtual_address_array = []

func add_points(points):
	score += points
