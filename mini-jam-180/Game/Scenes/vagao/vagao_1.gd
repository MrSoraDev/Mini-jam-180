extends Node2D

@onready var blink: AnimationPlayer = $Blink
#@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var enemy: Sprite2D = $Enemy

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	if Input.is_action_pressed("lantern"):
		
		var mouse_position = get_global_mouse_position()
		SignalManager.change_lantern_position.emit(mouse_position)
		#SceneManager.change_scene("teste")


func _on_first_phase_timeout() -> void:
	blinking()
	SignalManager.can_shoot.emit()
	SignalManager.can_lantern.emit()
	$SecondPhase.start()

func _on_second_phase_timeout() -> void:
	blinking()
	$ThirdPhase.start()

func _on_third_phase_timeout() -> void:
	blinking()
	$FourthPhase.start()

func _on_fourth_phase_timeout() -> void:
	blinking()

func blinking()-> void:

	blink.play("blinkfast")
	await blink.animation_finished
	SignalManager.reset.emit()
	enemy.frame += 1
