extends Node

var score1 = 0
var score2 = 0

var spinner1Parado = false
var spinner2Parado = false

var resetando = false
var time
var botaoPressionado = false

signal block
signal unblock

func _ready():
	pass

func atualizaScore():
	get_node("Control/Player/Score").set_text(str(score1))
	get_node("Control/Player2/Score").set_text(str(score2))
	
	emit_signal("block")
	
	spinner1Parado = false
	spinner2Parado = false
	

func _on_Spinner_limit():
	score1 += 1
	get_node("Control/Player/Msg").set_text("Você Ganhou!")
	get_node("Control/Player2/Msg").set_text("Você Perdeu!")
	atualizaScore()


func _on_Spinner2_limit():
	score2 += 1
	get_node("Control/Player/Msg").set_text("Você Perdeu!")
	get_node("Control/Player2/Msg").set_text("Você Ganhou!")
	atualizaScore()


func _on_Spinner_zero():
	spinner1Parado = true
	if spinner2Parado:
		reset()


func _on_Spinner2_zero():
	spinner2Parado = true
	if spinner1Parado:
		reset()
		
func reset():
	if resetando: return
	resetando = true
	get_node("Control/Player/Msg").set_text("")
	get_node("Control/Player2/Msg").set_text("")
	time = 4
	get_node("Timer").start()

func _on_Timer_timeout():
	time -=1
	if time > 1:
		get_node("Control/Player/Msg").set_text(str(time))
		get_node("Control/Player2/Msg").set_text(str(time))
	if time == 1:
		get_node("Control/Player/Msg").set_text("Senta a Mão!")
		get_node("Control/Player2/Msg").set_text("Senta a Mão!")
		resetando = false
		emit_signal("unblock")
	if time == 0:
		get_node("Control/Player/Msg").set_text("")
		get_node("Control/Player2/Msg").set_text("")


func _on_Button_pressed():
	get_node("Control/Player/Msg").set_text("Jogo Resetado.")
	get_node("Control/Player2/Msg").set_text("Jogo Resetado.")
	score1 = 0
	score2 = 0
	atualizaScore()