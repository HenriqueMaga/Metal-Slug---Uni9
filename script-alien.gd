extends Area2D

const cena_tiro = preload("res://cena-tiro-inimigo.tscn")
const gravidade = 800

var descerAte
var chegou = false
var velocidadeY = 0
var velocidade = -2
var posicao = 1
var morto = false

func _ready():
	morto = false
func _process(delta):
	#Alien irá descer coma animação inicial até a posição do parametro
	if descerAte != null && chegou == false && morto == false:
		translate(Vector2(0,2))
	
	#Quando chegar, ele passará a andar e atirar normalmente
	if global_position.y == descerAte && morto == false && chegou == false:
		chegou = true
		$AnimationPlayer.play("Andando")
		$"raio-trator".visible = false
		
	if chegou == true:
		if posicao == -1:
			velocidade *= (posicao * delta)
		if morto == false:
			velocidadeY += (gravidade * delta)
			translate(Vector2(velocidade,0))
	

func setar_direcao(direcao):
	velocidade *= direcao
	scale.x *= -1
	
func setar_posicao_do_alien(x):
	#recebe até onde o Alien descerá no raio trator
	descerAte = x
	
func morrer():
	velocidade = 0
	$CollisionShape2D.set_deferred("disabled",true)
	$AnimationPlayer.play("Morrendo")
	
func colisao(body):
	#Inimigos morrem por colisão
	if body.name != "StaticBody2D":
		morto = true
		morrer()
	#else:
		#print("Inimigo no chão")
		
func colisao_com_tiro(area):
	#inimigos ficavam imortais porque o tiro é um area, esse método garante que eles morrem por tiro
	if area.name == "Tiro-Aliado":
		morto = true
		morrer()
	#else:
		#print("Inimigo no chão")


func finalizar_acao(anim_name):
	#Quando terminar animação de tiro, atira de fato e volta a andar
	if anim_name == "Atirando":
		var objeto_tiro = cena_tiro.instance()
		if posicao == 1:
			objeto_tiro.get_node("Area2D").setar_direcao(1)
		else:
			objeto_tiro.get_node("Area2D").setar_direcao(-1)
		objeto_tiro.global_position = $Position2D.global_position
		get_tree().root.add_child(objeto_tiro)
		#Voltar a Andar
		velocidade = -2
		$AnimationPlayer.play("Andando")
	#Quando terminar a animação de morte, morre hehe
	else:
		queue_free()

func atirar():
	if morto == false && chegou == true:
		#Não atira morto porque né ¯\_(ツ)_/¯ (incluí para não atirar no raio trator)
		var chanceDeTiro = rand_range(0,4)
		if chanceDeTiro < 1:
			velocidade = 0
			$AnimationPlayer.play("Atirando")


func garante_que_morreu(old_name, new_name):
	#Seguro morreu de velho hehehe (Tive problemas com inimigos que ficavam imortais)
	if old_name == "Morrendo":
		print("Entrei em outra cena depois de morrer")
		queue_free()
