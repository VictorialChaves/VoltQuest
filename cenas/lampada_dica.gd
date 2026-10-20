extends Area2D

# 1. Cria as caixas no Inspetor para preencher em cada fase
@export_multiline var texto_da_dica: String = ""
@export var imagem_da_dica: Texture2D 

# Mantém a sua variável de acesso rápido!
@onready var painel_info = $Painel 

func _ready():
	painel_info.hide()

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		print("💡 Clicou na lâmpada!") 
		
		# Mantém a sua lógica genial de abrir/fechar com o mesmo clique
		painel_info.visible = !painel_info.visible
		
		# Se a lâmpada acabou de acender o painel, escolhe o que mostrar:
		if painel_info.visible == true:
			atualizar_conteudo()

func atualizar_conteudo():
	# Cenário 1: Se você colocou a imagem da tabela no Inspetor
	if imagem_da_dica != null:
		$Painel/TextureRect.texture = imagem_da_dica
		$Painel/TextureRect.visible = true
		
		# Esconde o texto para não atrapalhar a imagem
		if $Painel.has_node("TextoDica"):
			$Painel/TextoDica.visible = false
			
	# Cenário 2: Se não há imagem, mas há texto escrito no Inspetor
	elif texto_da_dica != "":
		if $Painel.has_node("TextoDica"):
			$Painel/TextoDica.text = texto_da_dica
			$Painel/TextoDica.visible = true
			
		# Esconde a caixa de imagem para não ficar um quadrado vazio
		$Painel/TextureRect.visible = false
		
