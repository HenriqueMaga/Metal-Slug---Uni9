extends Node2D

var descerAte
var chegou = false

#func _ready():
	#pass
	
func _process(delta):
	#Alien irá descer coma animação inicial até a posição do parametro
	if descerAte != null && chegou == false && global_position.y != descerAte:
		translate(Vector2(0,2))
	
	
func setar_posicao_da_caixa(y):
	#recebe até onde o Alien descerá no raio trator
	descerAte = y

func equipar_laser(body):
	if body.name != "StaticBody2D":
		$AudioStreamPlayer.play()
		$Area2D/CollisionShape2D.set_deferred("disabled",true)
		$Area2D/Sprite.visible = false
		ScriptGlobal.laser_equipado = true
		ScriptGlobal.combustivel_do_laser = 300


func sumir_com_a_caixa():
	queue_free()
