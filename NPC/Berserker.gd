extends KinematicBody2D

var knockback = Vector2.ZERO

const DeathEffect = preload("res://Effects/BerserkerDead.tscn")

onready var stats = $Stats

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 300*delta)
	knockback = move_and_slide(knockback)

func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * 80

func _on_Stats_no_health():
	queue_free()
	var BerserkerDeath = DeathEffect.instance()
	get_parent().add_child(BerserkerDeath)
	BerserkerDeath.global_position = global_position
