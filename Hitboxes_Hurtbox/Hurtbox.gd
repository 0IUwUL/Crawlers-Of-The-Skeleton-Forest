extends Area2D

#export(bool) var show_hit = true
const HitEffect = preload("res://Effects/HitEffect.tscn")

var invin = false setget set_invin

onready var timer = $Timer

signal invin_started
signal invin_ended

func set_invin(value):
	invin = value
	if invin == true:
		emit_signal("invin_started")
	else:
		emit_signal("invin_ended")
		
func start_invinc(duration):
	self.invin = true
	timer.start(duration)

#func _on_Hurtbox_area_entered(area):
func create_hit_effect():
#	if show_hit:
	var effect = HitEffect.instance()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position


func _on_Timer_timeout():
	self.invin = false


func _on_Hurtbox_invin_started():
	set_deferred("monitorable", false)


func _on_Hurtbox_invin_ended():
	set_deferred("monitorable", true)
