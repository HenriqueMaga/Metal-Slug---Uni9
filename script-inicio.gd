extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#$ColorRect/Servidor.text = ScriptGlobal.site
	#$ColorRect/Email.text = ScriptGlobal.email
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var enter = Input.is_action_just_pressed("ui_accept")
	
	if enter:
		print("Apertei")
		$ColorRect.visible = true
	#get_tree().change_scene("res://cena-missão-1.tscn")

func piscar():
	if $RichTextLabel.visible == true:
		$RichTextLabel.visible = false
	else:
		$RichTextLabel.visible = true


func iniciar_jogo():
	get_tree().change_scene("res://cena-missão-1.tscn")


func ativar_musica(button_pressed):
	if button_pressed == true:
		ScriptGlobal.status_musica = true
		$AudioStreamPlayer.play()
		if ScriptGlobal.status_sons:
			$ColorRect/Ok.play()
	else:
		ScriptGlobal.status_musica = false
		$AudioStreamPlayer.stop()
		$AudioStreamPlayer.autoplay = false
		if ScriptGlobal.status_sons:
			$ColorRect/Ok.play()


func ativar_sons(button_pressed):
	if button_pressed == true:
		ScriptGlobal.status_sons = true
		if ScriptGlobal.status_sons:
			$ColorRect/Ok.play()
	else:
		ScriptGlobal.status_sons = false
		if ScriptGlobal.status_sons:
			$ColorRect/Ok.play()

#-------------------------------------------------------------------------------
# requests de usuário
func enviar_requisicao_POST():
	
	var url_requisicao = ScriptGlobal.getUrl_login()
	var dados_envio = "username="   +$ColorRect/username.text+   "&password="+   $ColorRect/senha.text
	print(dados_envio)
	var cabecalho  = ["Content-Type: application/x-www-form-urlencoded"] #para POST usamos application/json
	$HTTPRequest.request(url_requisicao, cabecalho, false,HTTPClient.METHOD_POST, dados_envio) # requisicao para POST

	

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)
	if (json.result and json.result.size()>0):
		print(json.result)
		ScriptGlobal.id_usuario = json.result["id"]
		ScriptGlobal.username = json.result["username"]
		ScriptGlobal.usuario = json.result["name"]
		
		$ColorRect/Button.visible = true
		$ColorRect/bemvindo.text += json.result["name"]
		$ColorRect/bemvindo.visible = true
		print($ColorRect/bemvindo.text)
		
	else:
		print(result)
		print(response_code)
	


func login():
	enviar_requisicao_POST()
