extends KinematicBody2D

const DeathEffect = preload("res://Effects/SlimeDeath.tscn")

var knockback = Vector2.ZERO

onready var stats = $Stats
onready var playerDetection = $PlayerDetection
onready var sprite = $AnimatedSprite
onready var hurtbox = $Hurtbox

enum {
	IDLE,
	WANDER,
	CHASE
}

var velocity = Vector2.ZERO
var state = CHASE

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, stats.Friction*delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, stats.Friction*delta)
			seek_player()
			sprite.play("Idle")
		WANDER:
			pass
		CHASE:
			sprite.play("Run")
			var player = playerDetection.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * stats.Speed, stats.Acceleration * delta)
			else:
				state = IDLE
			
			sprite.flip_h = velocity.x<0
	velocity = move_and_slide(velocity)
		
func seek_player():
	if playerDetection.can_see_player():
		state = CHASE
	
func _on_Hurtbox_area_entered(area):
	sprite.play("Damage")
	stats.health -= area.damage
	knockback = area.knockback_vector * 125
	hurtbox.create_hit_effect()
	
func _on_HitBox_area_entered(area):
	sprite.play("Attack")

	
func _on_Stats_no_health():
	queue_free()
	var slimeDeath = DeathEffect.instance()
	get_parent().add_child(slimeDeath)
	slimeDeath.global_position = global_position



