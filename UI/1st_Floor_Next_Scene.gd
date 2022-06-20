extends Area2D
#
export(String, FILE, "*.tscn") var path_to_scene

func change_scene():
	if ResourceLoader.exists(path_to_scene):
		var _error = get_tree().change_scene(path_to_scene)
#
#export(PackedScene) var target_scene
#
#func next_level():
#	var ERR = get_tree().change_scene_to(target_scene)
#
#	if ERR != OK:
#		print("Failed loading of scene")


func _on_MapAdvance_body_entered(_body):
	change_scene()
