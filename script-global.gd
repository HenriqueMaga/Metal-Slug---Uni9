extends Node

var site = "http://metalsluguni9.freevar.com"
func getUrl_login():
	return site + "/db/jogo_autenticar.php"
func obter_url_insere_ranking():
	return site + "/db/jogo_novo_record.php"
func obter_url_insere_usuario():
	return site + "/db/jogo_novo_user.php"
	
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

var status_musica = true
var status_sons = true
var chuva_de_misseis = false
var boss_vivo = true
var inimigos_reativados = false

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
	chuva_de_misseis = false
	boss_vivo = true
	inimigos_reativados = false
	
func redefinir_config():
	qtd_vidas = 50
	qtd_pontos = 0
	status_musica = true
	status_sons = true
