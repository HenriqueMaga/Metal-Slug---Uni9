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
	if ScriptGlobal.status_musica == false:
		$AudioStreamPlayer.autoplay = false
		$AudioStreamPlayer.stop()
	else:
		$AudioStreamPlayer.autoplay = true
		$AudioStreamPlayer.play()
	novo_ranking_POST()
	
	$erro.visible = false
	$sucesso.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func jogar_novamente():
	ScriptGlobal.jogar_novamente()
	get_tree().change_scene("res://cena-missão-1.tscn")

func ir_para_menu():
	ScriptGlobal.jogar_novamente()
	get_tree().change_scene("res://cena-inicio.tscn")



func novo_ranking_POST():
	
	var url_requisicao = ScriptGlobal.obter_url_insere_ranking()
	var total = ScriptGlobal.qtd_pontos + ScriptGlobal.tempo_decorrido + ScriptGlobal.qtd_inimigos_derrotados
	var dados_envio = "id=" +str(ScriptGlobal.id_usuario)+ "&inimigos="+ str(ScriptGlobal.qtd_inimigos_derrotados) +"&tempo="+ str(ScriptGlobal.tempo_decorrido) +"&pontos="+ str(ScriptGlobal.qtd_pontos) +"&total="+ str(total)
	print(dados_envio)
	var cabecalho  = ["Content-Type: application/x-www-form-urlencoded"] #para POST usamos application/json
	$HTTPRequest.request(url_requisicao, cabecalho, false,HTTPClient.METHOD_POST, dados_envio) # requisicao para POST
	
	

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)
	if (json.result and json.result.size()>0):
		print(json.result)
		$sucesso.visible = true
		
	else:
		$erro.visible = true
		print(result)
		print(response_code)
