extends CanvasLayer

onready var tran_black = $AnimationPlayer

func _ready():
	tran_black.play("Load")
	
func _on_AnimationPlayer_animation_finished(_anim_name):
	pass
