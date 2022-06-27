extends Area2D

onready var cond = FloorCond
onready var coll = $CollisionShape2D
onready var chestAnimation = $Sprite/ChestAnimation
onready var display = $Display_Instruction
onready var pop = $Sprite/PopSmoke
const Potion = preload("res://Item/Potion.tscn")

var interact

func _ready():
	cond.enemies = 12
	cond.connect("no_enemies", self, "_on_Status_No_Enemies")
	coll.set_deferred("disabled", true)
	chestAnimation.visible = false
	display.visible = false
	interact = false
	pop.visible = false

func _input(_event):
	if interact:
		if Input.is_action_just_pressed("Open"):
			chestAnimation.play("Chest")
			potion_pop()
			
func _on_Status_No_Enemies():
	coll.set_deferred("disabled", false)
	pop.visible = true
	pop.play("Smoke")

func _on_ChestAnimation_body_entered(_body):
	display.visible = true
	interact = true

func _on_ChestAnimation_body_exited(_body):
	display.visible = false
	interact = false


func _on_ChestAnimation_animation_finished():
	chestAnimation.set_frame(3)
	chestAnimation.stop()


func _on_PopSmoke_animation_finished():
	pop.stop()
	pop.visible = false
	chestAnimation.visible = true
	interact = true

func potion_pop():
	chestAnimation.visible = false
	coll.set_deferred("disabled", true)
	if randf() <= .7:
		print("Success")
		var GenPotion = Potion.instance()
		GenPotion.position = Vector2(self.position.x, self.position.y + 6)
		get_parent().call_deferred("add_child", GenPotion)
		if randf() <= .1:
			print("BIG")
			var GenPotion1 = Potion.instance()
			GenPotion1.position = Vector2(self.position.x + 10, self.position.y + 6)
			get_parent().call_deferred("add_child", GenPotion1)
