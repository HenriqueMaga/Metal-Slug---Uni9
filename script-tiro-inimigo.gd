extends Area2D

var direcao = 1
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

func colisao(area):
	if area.name == "KinematicBody2D":
		print("Sofri dano")
