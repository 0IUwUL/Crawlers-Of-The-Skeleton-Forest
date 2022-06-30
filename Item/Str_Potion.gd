extends Area2D

var stats = PlayerStats
var plus
onready var player = $AnimationPlayer

func _ready():
	player.play("Out")

func _on_Potion_body_entered(_body):
	stats.damage += 1
	queue_free()
