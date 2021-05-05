extends Sprite


func _ready():
	pass # Replace with function body.


func cria_inimigo():
	var objeto_inimigo = preload("res://cena-inimigo.tscn").instance()
	objeto_inimigo.global_position.x = 900
	objeto_inimigo.global_position.y = 500
	
	get_tree().root.add_child(objeto_inimigo)
#func _process(delta):
#	pass
