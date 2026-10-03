extends Area2D

var pecas_conectadas = 0
var velocidade = 150 # Ajuste a velocidade do carrinho aqui (pixels por segundo)
var circuito_fechado = false

# Esta função será chamada pelas peças sempre que uma se encaixar
func registrar_peca():
	pecas_conectadas += 1
	print("Peças conectadas: ", pecas_conectadas, "/4")
	
	if pecas_conectadas == 4:
		print("🤖 Robô totalmente montado! Motores ligados!")
		circuito_fechado = true

func _process(delta):
	# Se as 4 peças estiverem no lugar, o carrinho anda!
	if circuito_fechado:
		var trilho = get_parent() # O pai do Carrinho é o nó PathFollow2D
		
		if trilho is PathFollow2D:
			# progress_ratio vai de 0.0 (início) a 1.0 (fim)
			if trilho.progress_ratio < 1.0:
				trilho.progress += velocidade * delta
			else:
				# Quando bater no 1.0, chegou ao fim da pista!
				print("🏁 Chegou à linha de chegada!")
				circuito_fechado = false # Desliga os motores
