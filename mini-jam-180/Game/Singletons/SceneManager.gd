extends Node


var game_scenes: Dictionary = {
	"main" = preload("res://Game/Scenes/main_menu.tscn"),
	"vagao1" = preload("res://Game/Scenes/vagao/vagao_1.tscn"),
	"vagao3" = preload("res://Game/Scenes/vagao/vagao_3.tscn")
}

func change_scene(name:String) ->void:
	get_tree().change_scene_to_packed(game_scenes[name])
