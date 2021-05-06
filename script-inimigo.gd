extends Area2D

const cena_tiro = preload("res://cena-tiro.tscn")
var velocidade = -2
var posicao = 1
var morto = false

func _ready():
	pass # Replace with function body.
func _process(delta):
	if posicao == -1:
		velocidade *= posicao
	if morto == false:
		translate(Vector2(velocidade,0))


func setar_direcao(direcao):
	velocidade *= direcao
	scale.x *= -1
	
func morrer():
	velocidade = 0
	$CollisionShape2D.set_deferred("disabled",true)
	$AnimationPlayer.play("Morrendo")

func colisao(body):
	morrer()


func finalizar_acao(anim_name):
	if anim_name == "Morrendo":
		morto = true
		queue_free()
		
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
