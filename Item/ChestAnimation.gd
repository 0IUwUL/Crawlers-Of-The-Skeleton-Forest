extends Area2D

onready var cond = FloorCond
onready var coll = $CollisionShape2D
onready var chestAnimation = $Sprite/ChestAnimation
onready var display = $Display_Instruction
onready var pop = $Sprite/PopSmoke
const Potion = preload("res://Item/Potion.tscn")
const Str = preload("res://Item/Str_Potion.tscn")

var interact

func _ready():
	cond.enemies = 10
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
	interact = false
	coll.set_deferred("disabled", true)
	var value = randf()
	var s = randf()
	var r = randf()
	var b = randf()
	
	if  value <= .8:
		print("potion1: ", value)
		var GenPotion = Potion.instance()
		GenPotion.position = Vector2(self.position.x, self.position.y)
		get_parent().call_deferred("add_child", GenPotion)
		if s <= .25:
			print("str1: ", s)
			var StrPotion = Str.instance()
			StrPotion.position = Vector2(self.position.x - 10, self.position.y)
			get_parent().call_deferred("add_child", StrPotion)
			if r <= .1:
				print("str2: ", r)
				var StrPotion1 = Str.instance()
				StrPotion1.position = Vector2(self.position.x + 10, self.position.y)
				get_parent().call_deferred("add_child", StrPotion1)
			else:
				print("potion2: ", r)
				if randf() <= .5:
					var GenPotion1 = Potion.instance()
					GenPotion1.position = Vector2(self.position.x + 10, self.position.y)
					get_parent().call_deferred("add_child", GenPotion1)

		elif s <= .55:
			print("potion3: ", s)
			var GenPotion2 = Potion.instance()
			GenPotion2.position = Vector2(self.position.x - 10, self.position.y)
			get_parent().call_deferred("add_child", GenPotion2)
			if b <= .05:
				print("potion3: ", b)
				var StrPotion2 = Str.instance()
				StrPotion2.position = Vector2(self.position.x + 10, self.position.y)
				get_parent().call_deferred("add_child", StrPotion2)
		else:
			print("s1p3: ",s)
			pass
	else:
		print("p1: ", value)
		pass
