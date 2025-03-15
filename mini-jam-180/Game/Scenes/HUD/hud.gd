extends CanvasLayer

@onready var progress_bar: ProgressBar = $MarginContainer/ProgressBar
@onready var gun: AnimatedSprite2D = $Gun
@onready var lantern: AnimatedSprite2D = $Lantern
@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var audio_lantern: AudioStreamPlayer = $AudioLantern
@onready var lantern_timer: Timer = $LanternTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var can_shoot: bool = false
var can_lantern: bool = false
var madness_drain_speed = [0.1,2,5]
var initial_madness : float #é o nivel de madness qnd começou a fase, pq se o player nao atirar no player, volta pra esse nivel
var step = madness_drain_speed[0]
var light_position:Vector2 = Vector2.ZERO


func _ready() -> void:
	SignalManager.save_madness.connect(save_madness)
	SignalManager.close_up.connect(change_step)
	SignalManager.can_shoot.connect(enable_shoot)
	SignalManager.can_lantern.connect(enable_lantern)
	SignalManager.change_lantern_position.connect(change_light_position)
	SignalManager.reset.connect(blinked)
	
	point_light_2d.global_position = Vector2(-59,52)
	initial_madness = GameManager.get_actual_madness()
	progress_bar.value = initial_madness
	progress_bar.step = step
	
	
func change_step() -> void:
	step+=1
	if step > madness_drain_speed.size():
		step = 0
	progress_bar.step = madness_drain_speed[step]

func _process(delta: float) -> void:
	progress_bar.value += madness_drain_speed[step]
	if Input.is_action_just_pressed("shoot") and can_shoot == true:
		gun.play("shoot")
		can_shoot = false
		GameManager.play_clip(audio_stream_player,GameManager.SOUND_SHOT)
	if Input.is_action_pressed("lantern") and can_lantern == true:
		turn_lantern()

		
func change_light_position(mouse_position):
	light_position = mouse_position
	
func turn_lantern() -> void:
	point_light_2d.global_position = light_position
	if lantern_timer.time_left >0:
		return
	animation_player.play("oscilation")
	point_light_2d.enabled = true
	lantern_timer.start()
	lantern.play("on")
	GameManager.play_clip(audio_lantern,GameManager.SOUND_SWITCH)
	#can_lantern = false
	

func change_atual_madness()-> void:
	GameManager.actual_madness = progress_bar.value

func save_madness() -> void:
	GameManager.set_actual_madness(progress_bar.value)

func enable_shoot() ->void:
	can_shoot = true

func enable_lantern() -> void:
	can_lantern = true

func blinked() -> void: #libera atirar dnv e usar dnv a lanterna
	can_lantern = true
	can_shoot = true
	

func _on_lantern_timer_timeout() -> void:
	can_lantern = false
	point_light_2d.enabled = false
