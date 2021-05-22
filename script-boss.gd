extends Node2D

var vida_boss = 400
var corOriginal
var misseisDisparados = 0
var protocoloDeFogo = false

# Called when the node enters the scene tree for the first time.
func _ready():
	corOriginal = $"Boss/cima".modulate
	$disparaMissel.wait_time = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global_position.x > 800:
		translate(Vector2(-1,0))
	
	if $"Boss/animacao-baixo".current_animation == "furado-fogo":
		if $Boss/cima.position.y != -70:
			$Boss/posicaoMissel.position.y -= 0.3
			$Boss/cima.position.y -= 0.3
			$Boss/missel.position.y -= 0.3
			#$Boss/CollisionShape2D.scale.y += 0.003
	if vida_boss <= 200 && $"Boss/animacao-baixo".current_animation != "furado-fogo" && protocoloDeFogo == false:
		protocoloDeFogo = true
		$"Boss/animacao-baixo".play("furado-fogo")
		$disparaFogo.start()
	
	if vida_boss <=0 :
		ScriptGlobal.boss_vivo = false
		$Boss/explodindo.visible = true
		$Boss/cima.visible = false
		$Boss/baixo.visible = false
		$Boss/missel.visible = false
		$"Boss/animacao-explodindo".play("explodindo")
		


#func mudar_animacao():
	#$"Boss/animacao-baixo".play("furado-fogo")
func dispara_fogo():
	lanca_chamas()

func fica_parado(anim_name):
	if anim_name == "furado-fogo":
		$"Boss/animacao-baixo".stop()
		lanca_chamas()

func lanca_chamas():
	print("Sou eu bola de fogo")
	var objeto_fogo = preload("res://cena-fogo-boss.tscn").instance()
	objeto_fogo.global_position = $Boss/posicaoFogo.global_position
	get_tree().root.add_child(objeto_fogo)
	


func colisao(body):
	if body.name == "Tiro-Aliado":
		vida_boss -= 1
		print(vida_boss)
		if $"Boss/cima".modulate == corOriginal:
			$"Boss/cima".modulate = "873d3d"
			$"Boss/baixo".modulate = "873d3d"
			$"Boss/missel".modulate = "873d3d"
		else:
			$"Boss/cima".modulate = corOriginal
			$"Boss/baixo".modulate = corOriginal
			$"Boss/missel".modulate = corOriginal


func disparar():
	misseisDisparados +=1
	if ScriptGlobal.chuva_de_misseis == false && misseisDisparados == 4:
		ScriptGlobal.chuva_de_misseis = true
	var objeto_missel = preload("res://cena-missel-disparando.tscn").instance()
	objeto_missel.global_position = $Boss/posicaoMissel.global_position
	
	if ScriptGlobal.boss_vivo == true:
		get_tree().root.add_child(objeto_missel)


func encostou_morreu(body):
	if body.name == "KinematicBody2D":
		ScriptGlobal.qtd_vidas += -50
		print("Sofri dano ",ScriptGlobal.qtd_vidas)


func derrotou(anim_name):
	queue_free()
