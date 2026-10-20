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
			
			# --- 🎵 SOM DO ENCAIXE / SOLTAR A PEÇA 🎵 ---
			var alto_falante = get_tree().root.find_child("SomEncaixe", true, false)
			if alto_falante != null:
				alto_falante.play()
			# --------------------------------------------

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
	
	# --- NOVO: Ensina o LED a ouvir a explosão! ---
	GestorCircuito.curto_circuito.connect(_explodir)

func _acender():
	$SpriteApagado.visible = false
	$SpriteAceso.visible = true
	print("💡 O LED acendeu-se (Troca de Visibilidade)!")
	
	# --- 🏆 ATIVA A TELA DE VITÓRIA AQUI 🏆 ---
	var tela_fim = get_tree().root.find_child("TelaFimDeFase", true, false)
	if tela_fim != null:
		tela_fim.mostrar_vitoria()

func _apagar():
	$SpriteApagado.visible = true
	$SpriteAceso.visible = false
	print("🌑 O LED apagou-se.")

func _explodir():
	print("💥 KABUM! Curto-circuito detetado!")
	
	# O seu código visual de explosão e som ficam aqui
	# Ex: $SomExplosao.play()
	# Ex: $SpriteApagado.visible = false
	
	# ---  (1.5 segundos) ---
	await get_tree().create_timer(1.5).timeout
	# -----------------------------------------
	
	# --- 💥 ATIVA A TELA DE GAME OVER APÓS A ESPERA 💥 ---
	var tela_fim = get_tree().root.find_child("TelaFimDeFase", true, false)
	if tela_fim != null:
		tela_fim.mostrar_game_over()
