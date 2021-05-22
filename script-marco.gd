extends KinematicBody2D

const velocidade = 150
const velPulo = 500
const gravidade = 800

var cena_tiro = preload("res://cena-tiro.tscn")
var velocidadeY = 0
var andar = Vector2(0, 0)
var posicao = "direita"
var agaixado = false
var noChao = true
var pulando = false
var tiro

func _physics_process(delta):
	if ScriptGlobal.laser_equipado == true:
		cena_tiro = preload("res://cena-laser.tscn")
		tiro = Input.is_action_pressed("tiro")
	else:
		cena_tiro = preload("res://cena-tiro.tscn")
		tiro = Input.is_action_just_pressed("tiro")
	
	ajustar_posicao()
	var esquerda = Input.is_action_pressed("ui_left")
	var direita = Input.is_action_pressed("ui_right")
	var cima = Input.is_action_pressed("ui_up")
	var baixo = Input.is_action_pressed("ui_down")
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
			
		if noChao==true && $AnimationPlayer.current_animation != "Atirando":
			if baixo && $AnimationPlayer.current_animation != "agaixado-atirando":
				$AnimationPlayer.play("Agaixar")
			else:
				$AnimationPlayer.play("Andando")
#--------------
	elif direita:
		andar.x = velocidade
		if posicao == "esquerda":
			posicao = "direita"
			scale.x *= -1
			$Position2D.scale.x *= -1
		
		if noChao==true && $AnimationPlayer.current_animation != "Atirando":
			if baixo && $AnimationPlayer.current_animation != "agaixado-atirando":
				$AnimationPlayer.play("Agaixar")
			else:
				$AnimationPlayer.play("Andando")
#--------------
	elif soltouEsquerda || soltouDireita || soltouCima || soltouBaixo || soltouTiro:
		$AnimationPlayer.play("Descansando")
#--------------
	if noChao==true:
		if pular && pulando == false:
			pulando = true
			noChao = false
			$AnimationPlayer.play("pulando")
			velocidadeY = -velPulo 
		else:
			velocidadeY += gravidade * delta
		andar.y = velocidadeY
	noChao = true
	
	if tiro:
		if ScriptGlobal.status_sons == true && ScriptGlobal.laser_equipado == false:
			$AudioStreamPlayer.play()
		if agaixado == false:
			$AnimationPlayer.stop()
			$AnimationPlayer.play("Atirando")
		else:
			$AnimationPlayer.stop()
			$AnimationPlayer.play("agaixado-atirando")
		var objeto_tiro = cena_tiro.instance()
		
		#Essa parte inverte o tiro, mas conflita com a colisão do tiro com outros corpos
		if posicao == "direita":
			objeto_tiro.get_node("Tiro-Aliado").setar_direcao(1)
		else:
			objeto_tiro.get_node("Tiro-Aliado").setar_direcao(-1)
		
		objeto_tiro.global_position = $Position2D.global_position
		get_tree().root.add_child(objeto_tiro)
	
	andar = move_and_slide(andar,Vector2(0,-1))
	
	#----------------------------------
	if baixo:
		if $AnimationPlayer.current_animation != "agaixado-atirando":
			$AnimationPlayer.play("Agaixar")
		$"png jogo".position.y = 40
		$Position2D.position.y = 40
		$CollisionShape2D.scale.y = 0.3
		$CollisionShape2D.position.y = 40
		$Area2D/CollisionShape2D.position.y = 40
		agaixado = true
	if soltouBaixo:
		$"png jogo".position.y = 0
		$Position2D.position.y = -13.059
		$CollisionShape2D.scale.y = 1
		$CollisionShape2D.position.y = 1.765
		$Area2D/CollisionShape2D.position.y = 0
		agaixado = false
		
func ajustar_posicao():
	if (global_position.x < 60):
		global_position.x = 60
	if (global_position.x > get_viewport().size.x-60):
		global_position.x = get_viewport().size.x-60



	if (global_position.y < 60):
		global_position.y = 60
	if (global_position.y > get_viewport().size.y-60):
		global_position.y = get_viewport().size.y-60


func colisao_com_chao(body):
	if body.name == "StaticBody2D":
		velocidadeY = 0
		pulando = false
		noChao = true
