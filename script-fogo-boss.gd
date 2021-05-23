extends Node2D

var posicaoX
var posicaoY

func _ready():
	posicaoX = global_position.x -300
	posicaoY = global_position.y + 5
	

func _process(delta):
	if ScriptGlobal.boss_vivo == false:
		queue_free()
	
	if $Area2D/AnimationPlayer.current_animation == "queimando" and global_position.x != posicaoX:
		global_position.x = posicaoX
		global_position.y = posicaoY 
		$Area2D/Sprite.scale.x *= 4
		$Area2D/CollisionPolygon2D.scale.x *= 8
		
	if ScriptGlobal.fim_de_jogo == true:
		queue_free()


func apaga_fogo():
	$Area2D/Sprite.scale.x = 1
	$Area2D/CollisionPolygon2D.scale.x = 1
	global_position.x += 250
	$Area2D/AnimationPlayer.play("apagando")


func apaga(anim_name):
	if anim_name == "apagando":
		queue_free()


func dano_no_marco(body):
	if body.name == "KinematicBody2D":
		ScriptGlobal.qtd_vidas += -10
		print("Sofri dano ",ScriptGlobal.qtd_vidas)
