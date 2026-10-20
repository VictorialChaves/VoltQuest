extends Area2D

@onready var painel_info = $Panel

# Variáveis para o Drag and Drop
var selecionado = false       
var offset_mouse = Vector2()  

func _ready():
	painel_info.hide()

# Faz a peça seguir o rato a cada frame
func _process(delta):
	if selecionado:
		global_position = get_global_mouse_position() - offset_mouse

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.double_click:
			# === DUPLO CLIQUE (Informação) ===
			# Inverte a visibilidade do painel (se está escondido, mostra; se está visível, esconde)
			painel_info.visible = not painel_info.visible
			print("Duplo clique detetado! Painel do resistor alterado.")
			
		elif event.pressed:
			# === CLIQUE SIMPLES (Arrastar) ===
			selecionado = true
			offset_mouse = get_global_mouse_position() - global_position
			z_index = 10 
			
		else:
			# === SOLTAR O BOTÃO (Largar) ===
			selecionado = false
			z_index = 1

# --- PINO 1 ---
func _on_pino_1_resistor_area_entered(area):
	if area.is_in_group("coluna"):
		# Chama o Autoload e regista a ligação
		GestorCircuito.conectar_pino(area.name, "Pino1_Resistor")

func _on_pino_1_resistor_area_exited(area):
	if area.is_in_group("coluna"):
		GestorCircuito.desconectar_pino(area.name, "Pino1_Resistor")

# --- PINO 2 ---
func _on_pino_2_resistor_area_entered(area):
	if area.is_in_group("coluna"):
		GestorCircuito.conectar_pino(area.name, "Pino2_Resistor")

func _on_pino_2_resistor_area_exited(area):
	if area.is_in_group("coluna"):
		GestorCircuito.desconectar_pino(area.name, "Pino2_Resistor")
