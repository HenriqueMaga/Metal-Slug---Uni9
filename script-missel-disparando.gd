extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	translate(Vector2(-8,0))
	
	if ScriptGlobal.fim_de_jogo == true:
		queue_free()


func deletar():
	queue_free()


func dano_no_marco(body):
	if body.name == "KinematicBody2D":
		ScriptGlobal.qtd_vidas += -5
		print("Sofri dano ",ScriptGlobal.qtd_vidas)
