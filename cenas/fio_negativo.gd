extends Area2D

# Variáveis universais para o Drag and Drop
var selecionado = false       
var offset_mouse = Vector2()  

# Faz a peça seguir o rato a cada frame
func _process(delta):
	if selecionado:
		global_position = get_global_mouse_position() - offset_mouse

# Deteta os cliques do rato na peça
func _on_input_event(_viewport, event, _shape_idx):
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			# Pega na peça
			selecionado = true
			offset_mouse = get_global_mouse_position() - global_position
			z_index = 10 # Puxa para a frente de tudo
		else:
			# Larga a peça
			selecionado = false
			z_index = 1 # Devolve ao plano normal


# --- PONTA 1 ---
func _on_ponta_1_area_entered(area: Area2D) -> void:
	if area.is_in_group("coluna") or area.is_in_group("alimentacao"):
		GestorCircuito.conectar_pino(area.name, "Ponta1_FioNegativo")

func _on_ponta_1_area_exited(area: Area2D) -> void:
	if area.is_in_group("coluna") or area.is_in_group("alimentacao"):
		GestorCircuito.desconectar_pino(area.name, "Ponta1_FioNegativo")

# --- PONTA 2 ---
func _on_ponta_2_area_entered(area: Area2D) -> void:
	if area.is_in_group("coluna") or area.is_in_group("alimentacao"):
		GestorCircuito.conectar_pino(area.name, "Ponta2_FioNegativo")

func _on_ponta_2_area_exited(area: Area2D) -> void:
	if area.is_in_group("coluna") or area.is_in_group("alimentacao"):
		GestorCircuito.desconectar_pino(area.name, "Ponta2_FioNegativo")
