extends Node


var game_scenes: Dictionary = {
	"vagao1" = "res://Game/Scenes/vagao/vagao_1.tscn",
	"vagao2" = preload("res://Game/Scenes/vagao/vagao_2.tscn")
}

func change_scene(_name:String) ->void:
	get_tree().change_scene_to_packed(game_scenes["vagao2"])
