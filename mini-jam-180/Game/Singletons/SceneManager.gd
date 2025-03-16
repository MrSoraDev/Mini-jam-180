extends Node

var scene_actual = 0

var scene_numbers: Dictionary = {
	0 : "main",
	1 : "vagao1",
	2 : "vagao2",
	3 : "vagao3",
	4 : "vagao4",
	5 : "vagao5",
	6 : "vagao6",
	7 : "vagao7"
}

var game_scenes: Dictionary = {
	"main" : preload("res://Game/Scenes/main_menu.tscn"),
	"vagao1" : preload("res://Game/Scenes/vagao/vagao_1.tscn"),
	"vagao2" : preload("res://Game/Scenes/vagao/vagao_2.tscn"),
	"vagao3" : preload("res://Game/Scenes/vagao/vagao_3.tscn"),
	"vagao4" : preload("res://Game/Scenes/vagao/vagao_4.tscn"),
	"vagao5" : preload("res://Game/Scenes/vagao/vagao_5.tscn"),
	"vagao6" : preload("res://Game/Scenes/vagao/vagao_6.tscn"),
	"vagao7" : preload("res://Game/Scenes/vagao/vagao_7.tscn")
}

func change_scene() ->void: #name:String
	scene_actual += 2
	if scene_actual == 7: #fase final
		pass #vai pra fase final
		#get_tree().change_scene_to_packed(game_scenes[scene_numbers[scene_actual]])
		
	
	get_tree().change_scene_to_packed(game_scenes[scene_numbers[scene_actual]])
