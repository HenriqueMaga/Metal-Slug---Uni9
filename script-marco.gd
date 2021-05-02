extends KinematicBody2D

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
			scale.x *= -1
			posicao = "esquerda"
			
		if noChao==true:
			$AnimationPlayer.play("Andando")
#--------------
	elif direita:
		andar.x = velocidade
		if posicao == "esquerda":
			posicao = "direita"
			scale.x *= -1
		
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
	
	move_and_slide(andar)
	
	if tiro:
		$AnimationPlayer.play("Atirando")
	
	if baixo:
		print("agaixando")
		$AnimationPlayer.play("Agaixar")
		scale.y = 0.6
	if soltouBaixo:
		print("levantando")
		scale.y = 1.002
		
