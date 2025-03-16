extends CanvasLayer

@onready var progress_bar: ProgressBar = $MarginContainer/ProgressBar
@onready var gun: AnimatedSprite2D = $Gun
@onready var lantern: AnimatedSprite2D = $Lantern
@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var audio_lantern: AudioStreamPlayer = $AudioLantern
@onready var lantern_timer: Timer = $LanternTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var heart: AudioStreamPlayer = $Heart
@onready var music_1: AudioStreamPlayer = $Music1
@onready var music_2: AudioStreamPlayer = $Music2
@onready var music_3: AudioStreamPlayer = $Music3
@onready var music_4: AudioStreamPlayer = $Music4


var can_shoot: bool = false
var can_lantern: bool = false
var madness_drain_speed = [0.01,0.02,0.05] #[0.01,0.02,0.05]
var initial_madness : float #é o nivel de madness qnd começou a fase, pq se o player nao atirar no player, volta pra esse nivel
var step = madness_drain_speed[0]
var light_position:Vector2 = Vector2.ZERO
var is_monster: bool = true
var tween:Tween
var tween2:Tween
var is_game_over: bool = false

func _ready() -> void:
	SignalManager.save_madness.connect(save_madness)
	
	SignalManager.close_up.connect(change_step)
	SignalManager.can_shoot.connect(enable_shoot)
	SignalManager.can_lantern.connect(enable_lantern)
	SignalManager.change_lantern_position.connect(change_light_position)
	SignalManager.reset.connect(blinked)
	SignalManager.on_death.connect(death)
	SignalManager.monster.connect(monster)
	SignalManager.regen_madness.connect(regen_madness)
	point_light_2d.global_position = Vector2(-59,52)
	initial_madness = GameManager.get_actual_madness()
	progress_bar.value = initial_madness
	progress_bar.step = step
	
	print_debug("Ficar de olho nos valores da madness para que as musicas toquem")
	
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
		

		if is_monster == true:
			SignalManager.on_monster_death.emit()
	if Input.is_action_pressed("lantern") and can_lantern == true:
		turn_lantern()
	#region Music Management	

	print_debug(progress_bar.value)
	
	if progress_bar.value == 0.5:
		music_1.play()
		
		
	if progress_bar.value == 25: #25
		tween = get_tree().create_tween()
		tween2 = get_tree().create_tween()
		tween.tween_property(music_1,"volume_db",-30,2).from(0)
		if music_1.volume_db == -30:
			tween.kill()
		music_1.stop()
		
		music_2.play()
		tween2.tween_property(music_2,"volume_db",0,2).from(-30)
		if music_2.volume_db == 0:
			tween.kill()
		
	
	if progress_bar.value == 50: #50
		tween = get_tree().create_tween()
		tween2 = get_tree().create_tween()
		tween.tween_property(music_2,"volume_db",-30,2).from(0)
		if music_2.volume_db == -30:
			tween.kill()
		music_2.stop()
		
		music_3.play()
		tween2.tween_property(music_3,"volume_db",0,2).from(-30)
		if music_3.volume_db == 0:
			tween.kill()
	#
	if progress_bar.value == 75: #75
		tween = get_tree().create_tween()
		tween2 = get_tree().create_tween()
		tween.tween_property(music_3,"volume_db",-30,1).from(0)
		if music_3.volume_db == -30:
			tween.kill()
		music_3.stop()
		
		music_4.play()
		tween2.tween_property(music_4,"volume_db",0,1).from(-30)
		if music_4.volume_db == 0:
			tween.kill()
	
	if progress_bar.value == 100:
		if is_game_over == false:
			game_over()
			SignalManager.on_game_over.emit()
			
			is_game_over = true
			print_debug("teste")
		
	#endregion
		
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
	enable_lantern()
	enable_shoot()
	#can_lantern = true
	#can_shoot = true
	

func _on_lantern_timer_timeout() -> void:
	can_lantern = false
	lantern.play("off")
	point_light_2d.enabled = false

func death() -> void:
	can_lantern = false
	can_shoot = false

func monster(bool_monster) -> void:
	is_monster = bool_monster

func game_over():
	can_shoot = false
	can_lantern = false
	if is_game_over == true and Input.is_action_just_pressed("shoot"):
		SceneManager.change_scene("main")

func regen_madness():
	progress_bar.value -= 10
