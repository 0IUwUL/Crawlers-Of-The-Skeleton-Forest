extends Node

export var max_enemies = 12 setget set_max_enemies
var enemies = max_enemies setget set_enemies


signal no_enemies
signal enemies_changed(value)
signal max_enemies_changed(value)

func _ready():
	self.enemies = max_enemies

func set_max_enemies(value):
	max_enemies = value
	self.enemies = min(enemies, max_enemies)
	emit_signal("max_enemies_changed", max_enemies)

func set_enemies(h):
	enemies = h
	print(enemies)
	print("hi")
	emit_signal("enemies_changed", enemies)
	if enemies <= 0:
		print("done")
		emit_signal("no_enemies")
	


