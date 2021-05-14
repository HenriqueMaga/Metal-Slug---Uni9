extends Node

var site = "http://metalsluguni9.freevar.com"
func getUrl_login():
	return site + "/jogo_autenticar.php"
	
var id_usuario
var username
var usuario

var qtd_vidas = 50
var qtd_pontos = 0
var valor_ponto_inimigo = 10
var valor_ponto_alien = 15
var qtd_inimigos_derrotados = 0
var tempo_decorrido = 0
var fim_de_jogo = false

var personagem = 1
var status_musica = true
var status_sons = true
var nivel_dificuldade = 1 #1-facil, 2-medio, 3-dificil

var laser_equipado = false
var combustivel_do_laser = 0

func jogar_novamente():
	qtd_vidas = 50
	qtd_pontos = 0
	qtd_inimigos_derrotados = 0
	tempo_decorrido = 0
	fim_de_jogo = false
	laser_equipado = false
	combustivel_do_laser = 0
	
func redefinir_config():
	qtd_vidas = 50
	qtd_pontos = 0
	nivel_dificuldade = 1 #1-facil, 2-medio, 3-dificil
	status_musica = true
	status_sons = true
