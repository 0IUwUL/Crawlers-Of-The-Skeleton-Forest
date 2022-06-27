extends Area2D

var stats = PlayerStats
var plus

func _on_Potion_body_entered(_body):
	if randf() <= .5:
		plus = 1
	else:
		plus = 2
	print("plus")
	print(plus)
	#poison
	if randf() <= .1:
		stats.health -= plus
		print("poison")
	#success
	else:
		stats.health += plus
		print("health")
	queue_free()
