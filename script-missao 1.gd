extends Node2D


func _ready():
	$descer_vida.wait_time = 30
	if ScriptGlobal.status_musica == false:
		$AudioStreamPlayer.autoplay = false
		$AudioStreamPlayer.stop()
	else:
		$AudioStreamPlayer.autoplay = true
		$AudioStreamPlayer.play()
		
	
func cria_inimigo():
	var direcao = rand_range(0,4)
	var cena_inimigo = preload("res://cena-inimigo.tscn")
	
	
	if direcao < 1:
		var objeto_inimigo = cena_inimigo.instance()
		objeto_inimigo.global_position = $esquerdaB.global_position
		objeto_inimigo.get_node("Inimigo").setar_direcao(-1)
		get_tree().root.add_child(objeto_inimigo)
		
	elif direcao < 2:
		var objeto_inimigo = cena_inimigo.instance()
		objeto_inimigo.global_position = $esquerdaC.global_position
		objeto_inimigo.get_node("Inimigo").setar_direcao(-1)
		get_tree().root.add_child(objeto_inimigo)
		
	elif direcao < 3:
		var objeto_inimigo = cena_inimigo.instance()
		objeto_inimigo.global_position = $direitaB.global_position
		objeto_inimigo.get_node("Inimigo").setar_direcao(1)
		get_tree().root.add_child(objeto_inimigo)
		
	elif direcao < 4:
		var objeto_inimigo = cena_inimigo.instance()
		objeto_inimigo.global_position = $direitaC.global_position
		objeto_inimigo.get_node("Inimigo").setar_direcao(1)
		get_tree().root.add_child(objeto_inimigo)
	
	#print("Nascendo")
#func _process(delta):
#	pass


func cria_alien():
	var direcao = rand_range(0,4)
	var cena_alien = preload("res://cena-alien.tscn")
	var objeto_alien = cena_alien.instance()
	if direcao < 1:
		objeto_alien.global_position.y = -20
		objeto_alien.global_position.x = rand_range(50,450)
		objeto_alien.get_node("Alien").setar_direcao(-1)
		objeto_alien.get_node("Alien").setar_posicao_do_alien(266)
		
	elif direcao < 2:
		objeto_alien.global_position.y = -20
		objeto_alien.global_position.x = rand_range(650,1000)
		objeto_alien.get_node("Alien").setar_direcao(1)
		objeto_alien.get_node("Alien").setar_posicao_do_alien(266)
	
	elif direcao < 3:
		objeto_alien.global_position.y = -20
		objeto_alien.global_position.x = rand_range(50,500)
		objeto_alien.get_node("Alien").setar_direcao(-1)
		objeto_alien.get_node("Alien").setar_posicao_do_alien(500)
	
	elif direcao < 4:
		objeto_alien.global_position.y = -20
		objeto_alien.global_position.x = rand_range(550,1000)
		objeto_alien.get_node("Alien").setar_direcao(1)
		objeto_alien.get_node("Alien").setar_posicao_do_alien(500)
	get_tree().root.add_child(objeto_alien)


func aumenta_dificuldade():
	$Tempo_Inimigo.wait_time *= 0.5
	$Tempo_Alien.wait_time *= 0.5
	print("novo tempo de dificuldade soldado = ",$Tempo_Inimigo.wait_time )
	print("novo tempo de dificuldade Alien = ",$Tempo_Alien.wait_time )


#func repetir():
	#if ScriptGlobal.status_musica == true:
		#$AudioStreamPlayer.play()


func descer_laser():
	var altura = rand_range(0,3)
	var cena_laser_box = preload("res://cena-laser-box.tscn")
	var objeto_laser = cena_laser_box.instance()
	
	if altura < 1:
		objeto_laser.global_position.x = rand_range(50,450)
		objeto_laser.setar_posicao_da_caixa(280)
	elif altura < 2:
		objeto_laser.global_position.x = rand_range(650,1000)
		objeto_laser.setar_posicao_da_caixa(280)
	else:
		objeto_laser.global_position.x = rand_range(50,1000)
		objeto_laser.setar_posicao_da_caixa(510)
	get_tree().root.add_child(objeto_laser)


func descer_vida():
	var altura = rand_range(0,3)
	var cena_vida = preload("res://cena-vida.tscn")
	var objeto_vida = cena_vida.instance()
	
	if altura < 1:
		objeto_vida.global_position.x = rand_range(50,450)
		objeto_vida.setar_posicao_da_vida(280)
	elif altura < 2:
		objeto_vida.global_position.x = rand_range(650,1000)
		objeto_vida.setar_posicao_da_vida(280)
	else:
		objeto_vida.global_position.x = rand_range(50,1000)
		objeto_vida.setar_posicao_da_vida(512)
	get_tree().root.add_child(objeto_vida)


func que_venha_a_chuva():
	if ScriptGlobal.chuva_de_misseis == true && ScriptGlobal.boss_vivo == true:
		
		var objeto_missel = preload("res://cena-missel-boss.tscn").instance()
		objeto_missel.global_position.x = rand_range(50,600)
		objeto_missel.global_position.y = -5
		
		get_tree().root.add_child(objeto_missel)
		
func invoca_o_boss():
	$AudioStreamPlayer.stop()
	$BossTheme.play()
	var objeto_boss = preload("res://cena-boss.tscn").instance()
	objeto_boss.global_position.x = 1260
	objeto_boss.global_position.y = 350
	get_tree().root.add_child(objeto_boss)


func prepara_para_boss():
	$Tempo_Alien.stop()
	$Tempo_Inimigo.stop()
	$AudioStreamPlayer.stop()
