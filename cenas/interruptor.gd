extends Area2D

# Variáveis do Drag and Drop
var selecionado = false
var offset_mouse = Vector2()

# Memória do estado do botão
var ligado = false

func _process(delta):
	if selecionado:
		global_position = get_global_mouse_position() - offset_mouse

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.double_click:
			alternar_estado()
		elif event.pressed:
			selecionado = true
			offset_mouse = get_global_mouse_position() - global_position
			z_index = 10
		else:
			selecionado = false
			z_index = 1
			# 🎵 SOM DO ENCAIXE / SOLTAR A PEÇA
			var alto_falante = get_tree().root.find_child("SomEncaixe", true, false)
			if alto_falante != null:
				alto_falante.play()

# Função que faz a magia acontecer
func alternar_estado():
	ligado = not ligado # Inverte o estado
	
	if ligado:
		print("🔘 Interruptor LIGADO!")
		
		# 🎵 Som do clique duplo (Opcional)
		var alto_falante = get_tree().root.find_child("SomEncaixe", true, false)
		if alto_falante != null:
			alto_falante.play()
			
		# O GRANDE MOMENTO: Chama a simulação
		GestorCircuito.testar_circuito()
		
	else:
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
