extends CanvasLayer

signal transition

onready var tran_black = $AnimationPlayer 

func transition():
	tran_black.play("Fade_to_Black")
	
func _load():
	tran_black.play("Fade_to_Normal")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Fade_to_Black":
		emit_signal("transition")
	if anim_name == "Fade_to_Normal":
		pass
