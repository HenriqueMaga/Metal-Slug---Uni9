extends Node2D

var descerAte
var chegou = false
var juntou_a_comida = false

#func _ready():
	#pass
	
func _process(delta):
	#Item irá descer coma animação inicial até a posição do parametro
	if descerAte != null && chegou == false && global_position.y != descerAte:
		translate(Vector2(0,4))
	if global_position.y == descerAte && chegou == false:
		chegou = true
		
	if chegou == true && juntou_a_comida == false:
		$Area2D/AnimationPlayer.play("caindo")
	
	
func setar_posicao_da_vida(y):
	#recebe até onde o item descerá no raio trator
	descerAte = y

func equipar_vida(body):
	if body.name != "StaticBody2D":
		if ScriptGlobal.status_sons == true:
			$AudioStreamPlayer.play()
		$Area2D/CollisionShape2D.set_deferred("disabled",true)
		$Area2D/Sprite.visible = false
		#Vida nerfada agora que tudo está mais fraco por ter o boss
		ScriptGlobal.qtd_vidas += 10


func sumir_com_a_vida():
	queue_free()


func trocar_de_animacao(anim_name):
	if anim_name == "caindo":
		juntou_a_comida = true
		$Area2D/AnimationPlayer.stop()
		$Area2D/AnimationPlayer.play("parado")
