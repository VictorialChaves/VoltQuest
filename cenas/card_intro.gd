extends Node2D

# Cria a caixinha no Inspetor para escrever a história de cada fase
@export_multiline var texto_da_missao: String = "Texto da missão aqui..."

func _ready():
	# Usando o atalho mágico %, ele encontra o Label instantaneamente
	if %Label != null:
		%Label.text = texto_da_missao

# --- LIGAÇÃO DO BOTÃO ---
func _on_button_pressed() -> void:
	queue_free()
