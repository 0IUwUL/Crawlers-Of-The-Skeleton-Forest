extends Node

export var max_health = 1
export var damage = 1
export var Speed = 1
onready var health = max_health setget set_health

signal no_health

func set_health(h):
	health = h
	if health <= 0:
		emit_signal("no_health")


