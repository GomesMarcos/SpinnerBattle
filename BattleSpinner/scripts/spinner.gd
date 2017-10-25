extends Node2D

var vel = 0
var block = false
var acel = -2

signal speed(valor)
signal limit
signal zero

func _ready():
	set_process(true)

func _process(delta):
	if vel > 1:
		vel += acel * delta
		
		if vel >= 4.9 and vel < 5:
			get_node("SamplePlayer2D").play("spinner_lento")
		elif vel > 9.99 and vel <= 10:
			get_node("SamplePlayer2D").play("spinner_medio")
		elif vel > 19.99 and vel <= 20:
			get_node("SamplePlayer2D").play("spinner_medio2")
		elif vel > 29.99 and vel <=30:
			get_node("SamplePlayer2D").play("spinner_rapido")
		elif vel >39.99 and vel <= 40:
			get_node("SamplePlayer2D").play("spinner_rapido2")
		
	else:
		vel = 0
		get_node("SamplePlayer2D").stop_all()
		if block:
			emit_signal("zero")
		
	get_node("corpo").set_rot(get_node("corpo").get_rot() + delta * vel)
	emit_signal("speed", vel/50)
	

func _on_Contato_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.SCREEN_TOUCH and event.pressed and not block:
		vel += 5
		
		if vel >= 5 and vel < 10:
			get_node("SamplePlayer2D").play("spinner_lento")
		elif vel >= 9.9 and vel <= 20:
			get_node("SamplePlayer2D").stop_all()
			get_node("SamplePlayer2D").play("spinner_medio")
		elif vel >= 19.9 and vel <= 30:
			get_node("SamplePlayer2D").stop_all()
			get_node("SamplePlayer2D").play("spinner_medio2")
		elif vel >= 29.9 and vel <= 40:
			get_node("SamplePlayer2D").stop_all()
			get_node("SamplePlayer2D").play("spinner_rapido")
		elif vel >=40:
			get_node("SamplePlayer2D").stop_all()
			get_node("SamplePlayer2D").play("spinner_rapido2")
		print(vel)
		
		if vel > 50:
			vel = 50
			emit_signal("limit")
		
		
		

func _on_BtnBlack_pressed():
	get_node("corpo/Sprite").set_texture(load("res://assets/black_ready.png"))


func _on_BtnYellow_pressed():
	get_node("corpo/Sprite").set_texture(load("res://assets/yellow_ready.png"))


func _on_BtnRed_pressed():
	get_node("corpo/Sprite").set_texture(load("res://assets/red_ready.png"))


func _on_Game_block():
	block = true
	acel = -10
	if vel >= 5 and vel < 10:
		get_node("SamplePlayer2D").play("spinner_lento")
	elif vel > 9.9 and vel <= 20:
		get_node("SamplePlayer2D").stop_all()
		get_node("SamplePlayer2D").play("spinner_medio")
	elif vel > 19.9 and vel <= 30:
		get_node("SamplePlayer2D").stop_all()
		get_node("SamplePlayer2D").play("spinner_medio2")
	elif vel > 29.9 and vel <= 40:
		get_node("SamplePlayer2D").stop_all()
		get_node("SamplePlayer2D").play("spinner_rapido")
	elif vel >40:
		get_node("SamplePlayer2D").stop_all()
		get_node("SamplePlayer2D").play("spinner_rapido2")
	
	
func _on_Game_unblock():
	block = false
	acel = -2
