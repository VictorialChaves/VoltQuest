extends AnimatedSprite2D

var velocidade = 150 # Velocidade do passo (pixels por segundo)

func _ready():
	# Começa o jogo sem poder andar
	set_meta("andando", false)

func _process(delta):
	# Se a transformação ativou a variável "andando"...
	if get_meta("andando") == true:
		# Move o robô para a direita
		position.x += velocidade * delta
