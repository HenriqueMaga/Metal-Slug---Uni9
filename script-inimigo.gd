extends Area2D

const cena_tiro = preload("res://cena-tiro-inimigo.tscn")
const gravidade = 800

var velocidadeY = 0
var velocidade = -2
var posicao = 1
var morto = false

func _ready():
	pass # Replace with function body.
func _process(delta):
	if posicao == -1:
		velocidade *= posicao
	if morto == false:
		#velocidadeY += gravidade * delta
		translate(Vector2(velocidade,0))


func setar_direcao(direcao):
	velocidade *= direcao
	scale.x *= -1
	
func morrer():
	velocidade = 0
	$CollisionShape2D.set_deferred("disabled",true)
	$AnimationPlayer.play("Morrendo")
	queue_free()
func colisao(body):
	if body.name != "StaticBody2D":
		print("Inimigo Morrendo")
		morrer()
	else:
		print("Inimigo no chão")


func finalizar_acao(anim_name):
	if anim_name == "Morrendo":
		morto = true
		
	else:
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

func atirar():
	if morto == false:
		var chanceDeTiro = rand_range(0,4)
		if chanceDeTiro < 1:
			velocidade = 0
			$AnimationPlayer.play("Atirando")
