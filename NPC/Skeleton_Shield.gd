extends KinematicBody2D

var knockback = Vector2.ZERO

const DeathEffect = preload("res://Effects/SkeletonWShield.tscn")

onready var stats = $Stats
onready var playerDetection = $PlayerDetection
onready var sprite = $AnimatedSprite

enum {
	IDLE,
	WANDER,
	CHASE
}

var velocity = Vector2.ZERO
var state = CHASE

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, stats.Acceleration*delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, stats.Velocity*delta)
			seek_player()
		WANDER:
			pass
		CHASE:
			var player = playerDetection.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * stats.Velocity, stats.Speed * delta)
			else:
				state = IDLE
			
			sprite.flip_h = velocity.x<0
	velocity = move_and_slide(velocity)
		
func seek_player():
	if playerDetection.can_see_player():
		state = CHASE
	
func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * stats.Friction

func _on_Stats_no_health():
	queue_free()
	var skeletonWShieldDeath = DeathEffect.instance()
	get_parent().add_child(skeletonWShieldDeath)
	skeletonWShieldDeath.global_position = global_position
