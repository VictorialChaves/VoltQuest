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
			selecionado = true
			offset_mouse = get_global_mouse_position() - global_position
			z_index = 10 
		else:
			selecionado = false
			z_index = 1 

# --- CONEXÕES COM A PROTOBOARD ---
func _on_pino_1_led_area_entered(area: Area2D) -> void:
	if area.is_in_group("coluna"):
		GestorCircuito.conectar_pino(area.name, "Pino1_LED")

func _on_pino_1_led_area_exited(area: Area2D) -> void:
	if area.is_in_group("coluna"):
		GestorCircuito.desconectar_pino(area.name, "Pino1_LED")

func _on_pino_2_led_area_entered(area: Area2D) -> void:
	if area.is_in_group("coluna"):
		GestorCircuito.conectar_pino(area.name, "Pino2_LED")

func _on_pino_2_led_area_exited(area: Area2D) -> void:
	if area.is_in_group("coluna"):
		GestorCircuito.desconectar_pino(area.name, "Pino2_LED")

# --- LÓGICA DE ILUMINAÇÃO ---
func _ready():
	$SpriteApagado.visible = true
	$SpriteAceso.visible = false
	
	GestorCircuito.energia_ligada.connect(_acender)
	GestorCircuito.energia_desligada.connect(_apagar)

func _acender():
	$SpriteApagado.visible = false
	$SpriteAceso.visible = true
	print("💡 O LED acendeu-se (Troca de Visibilidade)!")

func _apagar():
	$SpriteApagado.visible = true
	$SpriteAceso.visible = false
	print("🌑 O LED apagou-se.")
