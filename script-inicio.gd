extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var enter = Input.is_action_just_pressed("ui_accept")
	
	if enter:
		print("Apertei")
		$ColorRect.visible = true
		$Timer.one_shot = true
		$"Label username".visible = true
		$"Label senha".visible = true
		$username.visible = true
		$senha.visible = true
		$Button.visible = true
		$musica.visible = true
		$"ativar-musica".visible = true
		$sons.visible = true
		$"ativar-sons".visible = true
	#get_tree().change_scene("res://cena-missão-1.tscn")

func piscar():
	if $RichTextLabel.visible == true:
		$RichTextLabel.visible = false
	else:
		$RichTextLabel.visible = true


func iniciar_jogo():
	get_tree().change_scene("res://cena-missão-1.tscn")


func ativar_musica(button_pressed):
	if button_pressed == true:
		ScriptGlobal.status_musica = true
		$AudioStreamPlayer.play()
		if ScriptGlobal.status_sons:
			$Ok.play()
	else:
		ScriptGlobal.status_musica = false
		$AudioStreamPlayer.stop()
		$AudioStreamPlayer.autoplay = false
		if ScriptGlobal.status_sons:
			$Ok.play()


func ativar_sons(button_pressed):
	if button_pressed == true:
		ScriptGlobal.status_sons = true
		if ScriptGlobal.status_sons:
			$Ok.play()
	else:
		ScriptGlobal.status_sons = false
		if ScriptGlobal.status_sons:
			$Ok.play()
