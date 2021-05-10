extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$inimigos.text = str(ScriptGlobal.qtd_inimigos_derrotados)
	$tempo.text = str(ScriptGlobal.tempo_decorrido)
	$pontos.text = str(ScriptGlobal.qtd_pontos)
	$total.text = str(ScriptGlobal.qtd_pontos + ScriptGlobal.tempo_decorrido + ScriptGlobal.qtd_inimigos_derrotados)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
