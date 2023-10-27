extends Node2D

onready var plant = $Sprite
var stage = 0
var time = 0

func _process(delta):
	time += delta/10
	if abs(time - round(time)) < 0.001:
		if stage != 6:
			stage += 1
	plant.frame = stage
