extends Area2D

export var damage = 1

const HitEffect = preload("res://Effects/HitEffect.tscn")

func create_hit_effect():
#	if show_hit:
	var effect = HitEffect.instance()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position
