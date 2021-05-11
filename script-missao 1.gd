extends Node2D


func _ready():
	pass # Replace with function body.
	
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


func repetir():
	$AudioStreamPlayer.play()
