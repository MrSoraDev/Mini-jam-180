extends Node

const SOUND_SHOT = "shot"
const SOUND_SWITCH = "switch"

var SOUNDS: Dictionary = {
	SOUND_SHOT: preload("res://Assets/Sounds/shot.wav"),
	SOUND_SWITCH: preload("res://Assets/Sounds/Switch.wav")
}


var actual_madness: float = 0



func _ready() -> void:
	pass # Replace with function body.



func _process(delta: float) -> void:
	pass

func get_actual_madness() -> float:
	return actual_madness

func set_actual_madness(level_madness) -> void:
	actual_madness = level_madness
	
func play_clip(player: AudioStreamPlayer, clip_key: String) -> void:
	
	if SOUNDS.has(clip_key) == false:
		return
	player.stream = SOUNDS[clip_key]
	player.play()
