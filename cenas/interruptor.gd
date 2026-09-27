extends Area2D

# Variáveis do Drag and Drop
var selecionado = false       
var offset_mouse = Vector2()  

# NOVO: Memória do estado do botão
var ligado = false 

func _process(delta):
	if selecionado:
		global_position = get_global_mouse_position() - offset_mouse

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.double_click:
			# Se for duplo clique, muda o estado (liga/desliga)
			alternar_estado()
		elif event.pressed:
			# Se for só um clique simples, pega na peça
			selecionado = true
			offset_mouse = get_global_mouse_position() - global_position
			z_index = 10 
		else:
			# Larga a peça
			selecionado = false
			z_index = 1 

# NOVO: Função que faz a magia acontecer
func alternar_estado():
	ligado = not ligado # Inverte o estado (se estava off, fica on)
	
	if ligado:
		# Muda a cor da imagem ($Sprite2D) para um tom verde claro
		#$Sprite2D.modulate = Color(0.5, 1.0, 0.5) 
		print("🔘 Interruptor LIGADO!")
		
		# O GRANDE MOMENTO: Chama a simulação (Adeus tecla Espaço!)
		GestorCircuito.testar_circuito()
		
	else:
		# Volta a colocar a imagem na cor original branca/cinza
		$Sprite2D.modulate = Color(1.0, 1.0, 1.0) 
		print("🔘 Interruptor DESLIGADO!")
		GestorCircuito.emit_signal("energia_desligada")
		
# --- PINO 1 ---
func _on_pino_1_area_entered(area: Area2D) -> void:
	if area.is_in_group("coluna") or area.is_in_group("alimentacao"):
		GestorCircuito.conectar_pino(area.name, "Pino1_Interruptor")

func _on_pino_1_area_exited(area: Area2D) -> void:
	if area.is_in_group("coluna") or area.is_in_group("alimentacao"):
		GestorCircuito.desconectar_pino(area.name, "Pino1_Interruptor")

# --- PINO 2 ---
func _on_pino_2_area_entered(area: Area2D) -> void:
	if area.is_in_group("coluna") or area.is_in_group("alimentacao"):
		GestorCircuito.conectar_pino(area.name, "Pino2_Interruptor")

func _on_pino_2_area_exited(area: Area2D) -> void:
	if area.is_in_group("coluna") or area.is_in_group("alimentacao"):
		GestorCircuito.desconectar_pino(area.name, "Pino2_Interruptor")
