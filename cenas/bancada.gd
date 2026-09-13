extends Node2D # (ou extends Node, dependendo de como foi criado)

# 1. Dizemos para a Bancada onde está o desenho do LED
@onready var led_sprite = $Led/Sprite2D

# 2. Carregamos as duas imagens da pasta (Confira se os nomes estão exatos!)
var img_acesa = preload("res://assets/sprites/led_aceso.png")
var img_apagada = preload("res://assets/sprites/led_apagado.png")

# Variável para controlar se o circuito está ligado ou não
var circuito_ligado = false

# 3. A função que recebe o clique do interruptor
func _on_interruptor_input_event(_viewport, event, _shape_idx):
	
	# Se for um clique do botão esquerdo do mouse...
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		
		# Inverte o estado (se era falso vira verdadeiro, e vice-versa)
		circuito_ligado = !circuito_ligado
		
		# Troca a imagem do LED dependendo do estado do circuito
		if circuito_ligado == true:
			led_sprite.texture = img_acesa
		else:
			led_sprite.texture = img_apagada
