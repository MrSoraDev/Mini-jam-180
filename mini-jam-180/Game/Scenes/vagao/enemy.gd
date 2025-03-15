extends Sprite2D

var progresso: float = 0
var die: bool = false

func _ready() -> void:
	SignalManager.on_monster_death.connect(dead)
	
	
func _process(delta: float) -> void:
	if die:
		material.set_shader_parameter("progress", progresso)
		var tween = get_tree().create_tween()
		tween.tween_property(self,"progresso",1,10)

func dead():
	await get_tree().create_timer(1).timeout
	die = true
