extends Node2D

var velocidade = 2 
func _ready():
	pass


func _process(delta):
	translate(Vector2(0,velocidade))
	
	if ScriptGlobal.fim_de_jogo == true:
		queue_free()


func dano_no_marco(body):
	if body.name == "KinematicBody2D":
		ScriptGlobal.qtd_vidas += -5
		velocidade = 0
		print("Sofri dano ",ScriptGlobal.qtd_vidas)
		$Area2D/CollisionShape2D.set_deferred("disable", true)
		$Area2D/AnimationPlayer.play("explodindo")


func explodiu(anim_name):
	if anim_name == "explodindo":
		queue_free() 
