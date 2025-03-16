extends Node

@onready var music_1: AudioStreamPlayer = $Music1
@onready var music_2: AudioStreamPlayer = $Music2
@onready var music_3: AudioStreamPlayer = $Music3
@onready var music_4: AudioStreamPlayer = $Music4

var tween:Tween
var tween2:Tween

func _ready() -> void:
	SignalManager.play_music.connect(music_play)
	#tween = get_tree().create_tween()
	#tween2 = get_tree().create_tween()



func music_play(sanity):

	if sanity == 0.5:
		#GameManager.play_music(music_1,"music1")
		if music_1.playing == false:
			music_1.play()
		music_2.stop()
		music_3.stop()
		music_4.stop()
			
		
	if sanity == 25: #25
		#var tween:Tween
		#var tween2:Tween
		music_3.stop()
		music_4.stop()
		tween = get_tree().create_tween()
		
		tween.tween_property(music_1,"volume_db",-30,2).from(0)
		await get_tree().create_timer(2).timeout
		#if music_1.volume_db == -30:
		#tween.kill()
		music_1.stop()
		
		if music_2.playing == false:
			tween2 = get_tree().create_tween()
			music_2.play()
			tween2.tween_property(music_2,"volume_db",0,2).from(-30)
			await get_tree().create_timer(3).timeout
			#if music_2.volume_db == 0:
			#tween.kill()
		
		

	if sanity == 50: #50
		#var tween:Tween
		#var tween2:Tween
		music_1.stop()
		music_4.stop()
		tween = get_tree().create_tween()
		
		tween.tween_property(music_2,"volume_db",-30,2).from(0)
		await get_tree().create_timer(2).timeout
		#if music_2.volume_db == -30:
		tween.kill()
		music_2.stop()
		
		if music_3.playing == false:
			music_3.play()
			tween2 = get_tree().create_tween()
			tween2.tween_property(music_3,"volume_db",0,2).from(-30)
			await get_tree().create_timer(2).timeout
			#if music_3.volume_db == 0:
			tween.kill()
	#
	if sanity == 75: #75
		#var tween:Tween
		#var tween2:Tween
		music_1.stop()
		music_2.stop()
		tween = get_tree().create_tween()
		
		tween.tween_property(music_3,"volume_db",-30,2).from(0)
		await get_tree().create_timer(2).timeout
		#if music_3.volume_db == -30:
		tween.kill()
		music_3.stop()
		
		if music_4.playing == false:
			music_4.play()
			tween2 = get_tree().create_tween()
			tween2.tween_property(music_4,"volume_db",0,1).from(-30)
			await get_tree().create_timer(1).timeout
			#if music_4.volume_db == 0:
			tween.kill()

	if sanity == 100:
		pass
		#if is_game_over == false:
			#game_over()
			#SignalManager.on_game_over.emit()
			#
			#is_game_over = true
			#print_debug("teste")
		
	#endregion
