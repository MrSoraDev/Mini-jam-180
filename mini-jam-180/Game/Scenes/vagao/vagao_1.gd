extends Node2D

@onready var blink: AnimationPlayer = $Blink
#@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var enemy: Sprite2D = $Enemy
@onready var train: AudioStreamPlayer = $Train
@onready var effects: AudioStreamPlayer = $Effects
@onready var innocent: AnimationPlayer = $Innocent

@onready var game_over_animation: AnimatedSprite2D = $BlinkCanvas/GameOverAnimation
@onready var game_over_label: Label = $BlinkCanvas/GameOverAnimation/GameOverLabel
@onready var game_over_fade: AnimationPlayer = $BlinkCanvas/GameOverAnimation/GameOverFade




@export var monster: bool = true

var labels
var can_shoot: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.play_clip(train,GameManager.SOUND_TRAIN)
	SignalManager.on_game_over.connect(game_over)
	SignalManager.monster.emit(monster) #se é monstro ou nao
	game_over_animation.hide()
	game_over_label.hide()
	#blink.play("RESET")
	#innocent.hide()
	labels = $BlinkCanvas/Node2D.get_children()
	for label in labels:
		label.hide()
	#texture_rect.play()
func _process(delta: float) -> void:
	#pass
	if Input.is_action_pressed("lantern"):
		var mouse_position = get_global_mouse_position()
		SignalManager.change_lantern_position.emit(mouse_position)
		#SceneManager.change_scene("teste")
	
	if Input.is_action_just_pressed("shoot"):
		if monster and can_shoot:
			can_shoot = false
			stop_timers() #para os timers mas o sinal se é monstro ja foi enviado
		elif monster == false and can_shoot:
			can_shoot = false
			human_shot()
			


func human_shot():
	stop_timers()
	await get_tree().create_timer(0.3).timeout
	blink.play("shot_human")
	for label in labels:
		label.show()
	innocent.play("innocent")
	await get_tree().create_timer(2).timeout
	blink.play("blinkout")
	SceneManager.change_scene("vagao3")

func _on_first_phase_timeout() -> void: #libera atirar e usar a lanterna
	blinking()
	#enemy.scale = Vector2(4.5,4.5)
	
	SignalManager.can_shoot.emit()
	SignalManager.can_lantern.emit()
	can_shoot = true
	$SecondPhase.start()

func _on_second_phase_timeout() -> void:
	blinking()
	#enemy.scale = Vector2(5,5)
	$ThirdPhase.start()

func _on_third_phase_timeout() -> void:
	blinking()
	#enemy.scale = Vector2(5.5,5.5)
	
	$FourthPhase.start()

func _on_fourth_phase_timeout() -> void:
	
	game_over()
	SignalManager.on_death.emit()
	

func blinking()-> void:

	blink.play("blinkfast")
	#await blink.animation_finished
	SignalManager.reset.emit()
	#enemy.frame += 1

func change_frame() -> void:
	enemy.frame += 1
	enemy.scale += Vector2(0.5,0.5)

func stop_timers() -> void:
	$FirstPhase.stop()
	$SecondPhase.stop()
	$ThirdPhase.stop()
	$FourthPhase.stop()

func play_steps() -> void:
	GameManager.play_clip(effects,GameManager.SOUND_STEPS)
	await get_tree().create_timer(3).timeout
	GameManager.play_clip(effects,GameManager.SOUND_NEW_MONSTER)
	
func game_over():
	#blink.play("blinkin") #aqui tem que ser o blink lento, tocar a risada e se pa mordida
	#await blink.animation_finished
	GameManager.play_clip(effects,GameManager.SOUND_BITE)
	game_over_animation.show()
	game_over_animation.play("game_over")
	await get_tree().create_timer(2).timeout
	GameManager.play_clip(effects,GameManager.SOUND_LAUGH)
	await get_tree().create_timer(1).timeout
	game_over_label.show()
	game_over_fade.play("game_over_fade")
	
	
