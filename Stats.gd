extends Node

export var max_health = 13 setget set_max_health
export var damage = 1
export var Speed = 1
export var Velocity = 1
export var Friction = 1
export var Acceleration = 1
var health = max_health setget set_health
var Cdamage = damage setget set_damage

signal no_health
signal health_changed(value)
signal damage_changed(value)
signal max_health_changed(value)

func _ready():
	self.health = max_health

func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_changed", max_health)

func set_health(h):
	health = h
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")

func set_damage(d):
	Cdamage = d
	emit_signal("damage_changed", Cdamage)


