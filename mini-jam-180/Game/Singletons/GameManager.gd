extends Node

const SOUND_SHOT = "shot"
const SOUND_SWITCH = "switch"
const SOUND_NEW_MONSTER = "new monster"
const SOUND_LAUGH = "laugh"
const SOUND_HEART = "heart"
const SOUND_TRAIN = "train"
const SOUND_BITE = "bite"
const SOUND_STEPS = "step"

var SOUNDS: Dictionary = {
	SOUND_SHOT: preload("res://Assets/Sounds/shot.wav"),
	SOUND_SWITCH: preload("res://Assets/Sounds/Switch.wav"),
	SOUND_NEW_MONSTER: preload("res://Assets/Sounds/new_monster.mp3") ,
	SOUND_LAUGH: preload("res://Assets/Sounds/laugh.mp3"),
	SOUND_HEART: preload("res://Assets/Sounds/coracao batendo.mp3"),
	SOUND_TRAIN: preload("res://Assets/Sounds/trem.mp3"),
	SOUND_BITE: preload("res://Assets/Sounds/bite.wav"),
	SOUND_STEPS: preload("res://Assets/Sounds/steps.wav")
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
