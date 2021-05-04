extends KinematicBody2D

const cena_tiro = preload("res://cena-tiro.tscn")
const velocidade = 150
const velPulo = 400
const gravidade = 800

var velocidadeY = 0
var andar = Vector2(0, 0)
var posicao = "direita"
var noChao = true

func _physics_process(delta):
	
	var esquerda = Input.is_action_pressed("ui_left")
	var direita = Input.is_action_pressed("ui_right")
	var cima = Input.is_action_pressed("ui_up")
	var baixo = Input.is_action_pressed("ui_down")
	var tiro = Input.is_action_just_pressed("tiro")
	var pular = Input.is_action_just_pressed("ui_accept")
	
	var soltouEsquerda = Input.is_action_just_released("ui_left")
	var soltouDireita = Input.is_action_just_released("ui_right")
	var soltouCima = Input.is_action_just_released("ui_up")
	var soltouBaixo = Input.is_action_just_released("ui_down")
	var soltouTiro = Input.is_action_just_released("tiro")
	
	andar = Vector2()
	if esquerda:
		andar.x = -velocidade
		if posicao == "direita":
			posicao = "esquerda"
			scale.x *= -1
			$Position2D.scale.x *= -1
			
		if noChao==true:
			$AnimationPlayer.play("Andando")
#--------------
	elif direita:
		andar.x = velocidade
		if posicao == "esquerda":
			posicao = "direita"
			scale.x *= -1
			$Position2D.scale.x *= -1
		
		if noChao==true:
			$AnimationPlayer.play("Andando")
#--------------
	elif soltouEsquerda || soltouDireita || soltouCima || soltouBaixo || soltouTiro:
		$AnimationPlayer.play("Descansando")
#--------------
	if noChao==true:
		if pular:
			noChao = false
			$AnimationPlayer.play("pulando")
			velocidadeY = -velPulo 
		else:
			velocidadeY += gravidade * delta
		andar.y = velocidadeY
	noChao = true
	
	if tiro:
		$AnimationPlayer.play("Atirando")
		var objeto_tiro = cena_tiro.instance()
		
		#Essa parte deveria fazer o tiro ir para ambos os lados, mas não reconhece a função de inverter da cena tiro
		if posicao == "direita":
			objeto_tiro.setar_direcao(1)
		else:
			objeto_tiro.setar_direcao(-1)
		
		objeto_tiro.global_position = $Position2D.global_position
		get_tree().root.add_child(objeto_tiro)
	
	move_and_slide(andar)
	
	if baixo:
		$AnimationPlayer.play("Agaixar")
		scale.y = 0.6
	if soltouBaixo:
		print("levantando")
		scale.y = 1.002
		
