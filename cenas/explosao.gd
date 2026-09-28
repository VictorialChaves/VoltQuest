extends AnimatedSprite2D

func _ready():
	visible = false
	# Fica à escuta do nosso novo sinal de erro!
	GestorCircuito.curto_circuito.connect(_detonar)

func _detonar():
	visible = true
	# Volta para o frame 0 (explosao1) e toca a animação "default"
	set_frame_and_progress(0, 0.0)
	play("default")
	
	# Quando a animação terminar de tocar (os 7 frames), esconde a imagem
	await animation_finished
	visible = false
