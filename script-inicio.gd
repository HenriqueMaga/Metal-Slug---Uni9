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
		get_tree().change_scene("res://cena-missão-1.tscn")

func piscar():
	if $RichTextLabel.visible == true:
		$RichTextLabel.visible = false
	else:
		$RichTextLabel.visible = true
