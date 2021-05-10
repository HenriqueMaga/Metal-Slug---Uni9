extends Node

var qtd_vidas = 50
var qtd_pontos = 0
var valor_ponto_inimigo = 10
var valor_ponto_alien = 15
var qtd_inimigos_derrotados = 0
var tempo_decorrido = 0

var personagem = 1
var status_musica = true
var status_sons = true
var nivel_dificuldade = 1 #1-facil, 2-medio, 3-dificil

func redefinir_config():
	qtd_vidas = 3
	qtd_pontos = 0
	nivel_dificuldade = 1 #1-facil, 2-medio, 3-dificil
	status_musica = true
	status_sons = true
