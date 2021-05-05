extends Area2D


var velocidade = -2

func _ready():
	pass # Replace with function body.
func _process(delta):
	translate(Vector2(velocidade,0))

func morrer():
	velocidade = 0
	$CollisionShape2D.set_deferred("disabled",true)
	$AnimationPlayer.play("Morrendo")

func colisao(body):
	morrer()


func excluir_definitivamente(anim_name):
	if anim_name == "Morrendo":
		queue_free()
