extends Node2D


#func _ready():
	#$Tempo_jogo.wait_time = ScriptGlobal.tempo_jogo
	#$Tempo_jogo.start()

func atualizar_hud():
	#$Vidas.text = "X " + str(ScriptGlobal.qtd_vidas)	
	
	$pontos.text = str(ScriptGlobal.qtd_pontos)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	atualizar_hud()
	if (ScriptGlobal.qtd_vidas==0):
		get_tree().change_scene("res://cena-game-over.tscn")


func ir_para_vitoria():
	get_tree().change_scene("res://cena_vitoria.tscn")


func subir_tempo():
	$tempo.text = str(int($tempo.text)+1)
	ScriptGlobal.tempo_decorrido += 1

