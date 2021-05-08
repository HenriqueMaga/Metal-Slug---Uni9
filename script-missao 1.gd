extends Node2D


func _ready():
	pass # Replace with function body.


func cria_inimigo():
	var direcao = rand_range(0,4)
	var cena_inimigo = preload("res://cena-inimigo.tscn")
	var objeto_inimigo = cena_inimigo.instance()
	
	if direcao < 1:
		objeto_inimigo.global_position = $esquerdaB.global_position
		objeto_inimigo.get_node("Inimigo").setar_direcao(-1)
		
	elif direcao < 2:
		objeto_inimigo.global_position = $esquerdaC.global_position
		objeto_inimigo.get_node("Inimigo").setar_direcao(-1)
		
	elif direcao < 3:
		objeto_inimigo.global_position = $direitaB.global_position
		
	elif direcao < 4:
		objeto_inimigo.global_position = $direitaC.global_position
	
	get_tree().root.add_child(objeto_inimigo)
	#print("Nascendo")
#func _process(delta):
#	pass
