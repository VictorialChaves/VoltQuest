extends AnimatedSprite2D

var velocidade = 150 # Velocidade do passo (pixels por segundo)

func _ready():
	# Começa o jogo sem poder andar
	set_meta("andando", false)

func _process(delta):
	if get_meta("andando") == true:
		position.x += velocidade * delta
		
		# Ajuste o valor 1000 para o limite da sua tela
		if position.x > 1000:
			set_meta("andando", false)
			var tela_fim = get_tree().root.find_child("TelaFimDeFase", true, false)
			if tela_fim != null:
				tela_fim.mostrar_vitoria()
