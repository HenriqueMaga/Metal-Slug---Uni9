extends Node2D

var direcao = 1
var velocidade = 600
var mov = Vector2(0,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	ScriptGlobal.combustivel_do_laser -= 1
	if ScriptGlobal.combustivel_do_laser == 0:
		ScriptGlobal.laser_equipado = false
		
	
func setar_direcao(novaDirecao):
	direcao = novaDirecao
	if novaDirecao == -1:
		$Sprite.flip_h = true
		position.x = -1060
		
func _process(delta):
	print(ScriptGlobal.combustivel_do_laser)
	$AudioStreamPlayer.play()
	if ScriptGlobal.combustivel_do_laser % 3 == 0:
		$Sprite.visible = false
		$Sprite2.visible = true
	else:
		$Sprite.visible = true
		$Sprite2.visible = false

func colisao(area):
	if area.name == "Inimigo" ||  area.name == "Alien":
		area.morrer()
		queue_free()



func some_com_o_laser():
	queue_free()
