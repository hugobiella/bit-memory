extends Node2D

const MAX_SPEED = 1500 # player speed
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

func _ready():
	get_viewport().size = DisplayServer.screen_get_size()

func reset():
	lock_player = true
	score = 0
	amount_to_generate = 0
	physical_address_array = []
	physical_address_array_copy = []
	virtual_address_array = []
