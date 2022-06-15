extends KinematicBody2D

const DeathEffect = preload("res://Effects/SlimeDeath.tscn")

var knockback = Vector2.ZERO

onready var stats = $Stats

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 300*delta)
	knockback = move_and_slide(knockback)


func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * 125
	
func _on_Stats_no_health():
	queue_free()
	var slimeDeath = DeathEffect.instance()
	get_parent().add_child(slimeDeath)
	slimeDeath.global_position = global_position
