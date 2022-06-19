extends Node2D

export(int) var wander = 32
onready var start_position = global_position
onready var target_position = global_position
onready var timer = $Timer

func _ready():
	update_position()


func update_position():
	var target_vector = Vector2(rand_range(-wander, wander), rand_range(-wander, wander))
	target_position = start_position + target_vector

func get_time_left():
	return timer.time_left

func reset_timer(time):
	timer.start(time)

func _on_Timer_timeout():
	update_position()
