extends Area2D

const cena_tiro = preload("res://cena-tiro-inimigo.tscn")

var velocidadePadrao
var velocidade = -2
var posicao = 1
var direcaoTiro = 1
var morto = false

func _ready():
	morto = false
func _process(delta):
	if posicao == -1:
		velocidade *= (posicao * delta)
	if morto == false:
		translate(Vector2(velocidade,0))
	ajustar_posicao()

func setar_direcao(direcao):
	velocidade *= direcao
	velocidadePadrao = velocidade
	direcaoTiro *= -direcao
	scale.x *= direcao
	
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
		#print("minha posição é ",posicao, " irei atirar para ",direcaoTiro)
		objeto_tiro.get_node("Area2D").setar_direcao(direcaoTiro)
		
		objeto_tiro.global_position = $Position2D.global_position
		get_tree().root.add_child(objeto_tiro)
		
		#Voltar a Andar
		velocidade = velocidadePadrao
		$AnimationPlayer.play("Andando")
	#Quando terminar a animação de morte, morre hehe
	else:
		queue_free()

func atirar():
	if morto == false:
		#Não atira morto porque né ¯\_(ツ)_/¯
		var chanceDeTiro = rand_range(0,4)
		if chanceDeTiro < 1:
			velocidade = 0
			$AnimationPlayer.play("Atirando")


func garante_que_morreu(old_name, new_name):
	#Seguro morreu de velho hehehe (Tive problemas com inimigos que ficavam imortais)
	if old_name == "Morrendo":
		print("Entrei em outra cena depois de morrer")
		queue_free()

#Tentativa de impedir que inimigos voem pelo vão
func ajustar_posicao():
	if global_position.y < 300 && global_position.x > 450 && global_position.x < 650:
		setar_direcao(-1)
	
	if (global_position.x < -26):
		setar_direcao(-1)
	if (global_position.x > get_viewport().size.x +40):
		setar_direcao(-1)
