extends StaticBody2D

const Audio = preload("res://Scenes/World/Audio.tscn")
const HealthPotion = preload("res://Scenes/Objects/Obj_HP_Potion.tscn")
const StaminaPotion = preload("res://Scenes/Objects/Obj_STM_Potion.tscn")
const Torch = preload("res://Scenes/Objects/Obj_Torch.tscn")

onready var animatedSprite = $AnimatedSprite
onready var collisionShape = $CollisionPolygon2D
onready var hurtBox = $Hurtbox/CollisionShape2D
onready var projectileHurtbox = $ProjectileCollision/CollisionShape2D

func _animation_finished():
	animatedSprite.z_index = -1
	animatedSprite.frame = 5
#	queue_free()

func _on_Hurtbox_area_entered(_area):
	collisionShape.call_deferred("free")
	hurtBox.call_deferred("free")
	projectileHurtbox.call_deferred("free")
	var stream = load("res://SFX/SFX_Crate_Destruction.wav")
	var audio = Audio.instance()
	audio.set_stream(stream)
	get_tree().current_scene.add_child(audio)
	
	#Potion Spawning
	var chance = randf()
	if chance <= .25:
		var torch = Torch.instance()
		torch.position = Vector2(global_position.x, global_position.y + 3)
		get_parent().call_deferred("add_child", torch)
		if randf() <= .05:
			if randf() <= .65:
				var healthPotion = HealthPotion.instance() #HealthPotion.instance()
				healthPotion.position = Vector2(global_position.x + 2, global_position.y + 3)
				get_parent().call_deferred("add_child", healthPotion)
			else:
				var staminaPotion = StaminaPotion.instance() #StaminaPotion.instance()
				staminaPotion.position = Vector2(global_position.x + 2, global_position.y + 3)
				get_parent().call_deferred("add_child", staminaPotion)
	elif chance <= .7:
		if randf() <= .65:
			var healthPotion = HealthPotion.instance() #HealthPotion.instance()
			healthPotion.position = Vector2(global_position.x, global_position.y + 3)
			get_parent().call_deferred("add_child", healthPotion)
			if randf() <= 0.05:
				var torch = Torch.instance()
				torch.position = Vector2(global_position.x, global_position.y + 3)
				get_parent().call_deferred("add_child", torch)
		else:
			var staminaPotion = StaminaPotion.instance() #StaminaPotion.instance()
			staminaPotion.position = Vector2(global_position.x, global_position.y + 3)
			get_parent().call_deferred("add_child", staminaPotion)
			if randf() <= 0.05:
				var torch = Torch.instance()
				torch.position = Vector2(global_position.x, global_position.y + 3)
				get_parent().call_deferred("add_child", torch)
	
	animatedSprite.frame = 1
	animatedSprite.play("Animate")
