extends CanvasLayer

# Variável para escrever no Inspetor qual é a próxima fase
@export var caminho_proxima_fase: String = "res://cenas/seguidor_de_linha.tscn"

func _ready():
	# Garante por precaução que as telas começam invisíveis
	$ColorRect.visible = false
	$BotaoVitoria.visible = false
	$BotaoDerrota.visible = false


# Funções que a fase vai chamar quando o jogador ganhar ou perder
func mostrar_vitoria():
	$ColorRect.visible = true
	$BotaoVitoria.visible = true
	esconder_interface_do_jogo() # Chama a função que limpa a tela

func mostrar_game_over():
	$ColorRect.visible = true
	$BotaoDerrota.visible = true
	esconder_interface_do_jogo() # Chama a função que limpa a tela


# --- LIGAÇÕES DOS BOTÕES (SINAIS) ---
func _on_botao_vitoria_pressed():
	# Muda para o caminho que você definiu no Inspetor
	get_tree().change_scene_to_file(caminho_proxima_fase)

func _on_botao_derrota_pressed():
	# Recarrega a fase atual do zero para tentar de novo
	get_tree().reload_current_scene()


# --- NOVA FUNÇÃO PARA LIMPAR A TELA ---
func esconder_interface_do_jogo():
	# Procura o texto informativo e esconde-o
	var texto_info = get_tree().root.find_child("TextoInformativo", true, false)
	if texto_info != null:
		texto_info.visible = false
		
	# Procura o menu de volume e esconde-o
	var menu_vol = get_tree().root.find_child("MenuVolume", true, false)
	if menu_vol != null:
		menu_vol.visible = false
