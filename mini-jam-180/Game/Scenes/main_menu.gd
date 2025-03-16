extends Control

@onready var color_rect: ColorRect = $Tutorial/ColorRect

@onready var tutorial: Control = $Tutorial

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#color_rect.hide()
	tutorial.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(preload("res://Game/Scenes/vagao/vagao_1.tscn"))



func _on_button_2_pressed() -> void:
	#color_rect.show()
	tutorial.show()


func _on_start_from_tutorial_pressed() -> void:
	get_tree().change_scene_to_packed(preload("res://Game/Scenes/vagao/vagao_1.tscn"))
