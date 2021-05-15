extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect/erro.visible = false
	if ScriptGlobal.id_usuario != null:
		$ColorRect/bemvindo.visible = true
		$ColorRect/bemvindo.text + ScriptGlobal.usuario
		$ColorRect/Button.visible = true
	else:
		$ColorRect/bemvindo.visible = false
		$ColorRect/Button.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var enter = Input.is_action_just_pressed("ui_accept")
	
	if enter:
		print("Apertei")
		$ColorRect.visible = true
		$Timer.one_shot = true
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
# login de usuário
func enviar_autenticar_POST():
	
	var url_requisicao = ScriptGlobal.getUrl_login()
	var dados_envio = "username="   +$ColorRect/username.text+   "&password="+   $ColorRect/senha.text
	print(dados_envio)
	var cabecalho  = ["Content-Type: application/x-www-form-urlencoded"] #para POST usamos application/json
	$HTTPRequestLogin.request(url_requisicao, cabecalho, false,HTTPClient.METHOD_POST, dados_envio) # requisicao para POST

	

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
		$ColorRect/erro.visible = true
		print(result)
		print(response_code)
	


func login():
	enviar_autenticar_POST()
	
	
#----------------------------
# Cadastrar novos usuários


func ir_para_cadastro():
	$ColorRect.visible = false
	$Cadastro.visible = true
	$Cadastro/sucesso.visible = false
	$Cadastro/erro.visible = false
	$Cadastro/erroDigitando.visible = false

func criar_usuario():
	$Cadastro/erro.visible = false
	if !$Cadastro/novoName.text || !$Cadastro/novoUsername.text || !$Cadastro/novaSenha.text:
		$Cadastro/erro.visible = true
		print("Não digitou algo") 
	else:
		criar_novo_user_POST()

func voltar_para_inicio():
	$ColorRect.visible = true
	$Cadastro.visible = false

func criar_novo_user_POST():
	var url_requisicao = ScriptGlobal.obter_url_insere_usuario()
	var dados_envio = "nome=" +$Cadastro/novoName.text+  "&usuario="  +$Cadastro/novoUsername.text+ "&senha=" +$Cadastro/novaSenha.text
	print(dados_envio)
	var cabecalho  = ["Content-Type: application/x-www-form-urlencoded"] #para POST usamos application/json
	$Cadastro/HTTPRequestCadastro.request(url_requisicao, cabecalho, false,HTTPClient.METHOD_POST, dados_envio) # requisicao para POST


func cadastro_completo(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)
	if (json.result and json.result.size()>0):
		print(json.result)
		$Cadastro/sucesso. visible = true
		$Cadastro/criarUsuario.visible = false
		
	else:
		$Cadastro/erro.visible = true
		print(json.result)
		print(response_code)
