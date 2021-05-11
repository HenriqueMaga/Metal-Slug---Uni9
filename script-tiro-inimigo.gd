extends Area2D

var direcao
var velocidade = 400
var mov = Vector2(0,0)

func _ready():
	pass
#Cena tiro inimigo foi criada para evitar Friendly Fire entre os inimigos

func setar_direcao(novaDirecao):
	direcao = novaDirecao
	if novaDirecao == -1:
		$Sprite.flip_h = true

func _process(delta):
	mov.x = velocidade * delta * direcao
	translate(mov)
	
	#Quando o jogo tiver acabado, limpa tudo para não ficar tiros aparecendo
	if ScriptGlobal.fim_de_jogo == true:
		queue_free()

func colisao(area):
	if area.name == "KinematicBody2D":
		ScriptGlobal.qtd_vidas += -2
		print("Sofri dano ",ScriptGlobal.qtd_vidas)
