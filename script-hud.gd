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
		ScriptGlobal.fim_de_jogo = true
		get_tree().change_scene("res://cena-game-over.tscn")
		
	if ScriptGlobal.qtd_vidas < 10:
		$AnimationPlayer.play("1")
	elif ScriptGlobal.qtd_vidas < 20:
		$AnimationPlayer.play("2")
	elif ScriptGlobal.qtd_vidas < 30:
		$AnimationPlayer.play("3")
	elif ScriptGlobal.qtd_vidas < 40:
		$AnimationPlayer.play("4")
	elif ScriptGlobal.qtd_vidas < 50:
		$AnimationPlayer.play("5")
		
	
	$"vida-atual".text = str(ScriptGlobal.qtd_vidas)


func ir_para_vitoria():
	get_tree().change_scene("res://cena_vitoria.tscn")


func subir_tempo():
	$tempo.text = str(int($tempo.text)+1)
	ScriptGlobal.tempo_decorrido += 1

