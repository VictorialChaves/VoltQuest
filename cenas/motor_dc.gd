extends Area2D

@export var mensagem_educativa: String = "Mensagem padrão" # O @export deixa você editar isto no Inspetor!

var selecionado = false
var encaixado = false
var offset_mouse = Vector2() 

# 1. ESTA FUNÇÃO DETETA QUANDO CLICAMOS EM CIMA DA PEÇA
func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		# Se clicou (pressed) e a peça ainda não foi colada no carrinho
		if event.pressed and not encaixado:
			selecionado = true
			offset_mouse = get_global_mouse_position() - global_position

# 2. ESTA FUNÇÃO DETETA QUANDO LARGAMOS O BOTÃO DO RATO EM QUALQUER LUGAR
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		# Se soltou o clique e a peça estava a ser arrastada
		if not event.pressed and selecionado:
			selecionado = false
			tentar_encaixar() # Tenta colar no carrinho!

# 3. ESTA FUNÇÃO FAZ A PEÇA SEGUIR O RATO
func _process(delta):
	if selecionado and not encaixado:
		global_position = get_global_mouse_position() - offset_mouse

# 4. A NOSSA LÓGICA DE ÍMAN
func tentar_encaixar():
	var carrinho = get_tree().root.find_child("Carrinho", true, false)
	
	if carrinho != null and carrinho.has_node("Encaixes"):
		var marcadores = carrinho.get_node("Encaixes").get_children()
		
		for marcador in marcadores:
			if global_position.distance_to(marcador.global_position) < 40:
				reparent(carrinho)
				global_position = marcador.global_position
				encaixado = true
				carrinho.registrar_peca()
				var label_texto = get_tree().root.find_child("TextoInformativo", true, false)
				if label_texto:
					label_texto.text = mensagem_educativa

				print("✅ Peça encaixada com sucesso!")
				break
