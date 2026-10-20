extends Area2D

# 1. ESTA VARIÁVEL VAI APARECER NO INSPETOR À DIREITA
@export var meu_marcador_alvo: String = ""

var selecionado = false
var encaixado = false
var offset_mouse = Vector2()

func _on_perna_esquerda_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and not encaixado:
			selecionado = true
			offset_mouse = get_global_mouse_position() - global_position

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if not event.pressed and selecionado:
			selecionado = false
			tentar_encaixar()

func _process(delta):
	if selecionado and not encaixado:
		global_position = get_global_mouse_position() - offset_mouse

func tentar_encaixar():
	var corpo = get_tree().root.find_child("Corpo", true, false)
	
	if corpo != null:
		var marcadores = corpo.get_children()
		
		for marcador in marcadores:
			# 2. A MAGIA AQUI: Agora ele exige que a distância seja menor que 40 
			# E que o nome do marcador seja exatamente igual à palavra que definirmos
			if global_position.distance_to(marcador.global_position) < 40 and marcador.name == meu_marcador_alvo:
				
				reparent(corpo)
				global_position = marcador.global_position
				encaixado = true
				
				# --- 🎵 NOVA PARTE: O SOM DO ENCAIXE 🎵 ---
				var alto_falante = get_tree().root.find_child("SomEncaixe", true, false)
				if alto_falante != null:
					alto_falante.play()
				# ------------------------------------------
				
				var robo_pai = get_tree().root.find_child("RoboMontagem", true, false)
				if robo_pai != null and robo_pai.has_method("registrar_peca"):
					robo_pai.registrar_peca()
					
				print("✅ Peça grudada no lugar certo: ", marcador.name)
				break
