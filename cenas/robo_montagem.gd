extends Node2D

var pecas_conectadas = 0
var total_pecas = 6 

func registrar_peca():
	pecas_conectadas += 1
	print("Peças montadas: ", pecas_conectadas, " de ", total_pecas)
	
	if pecas_conectadas == total_pecas:
		print("🔥 O Robô está totalmente montado!")
		transformar_robo()

func transformar_robo():
	# --- 🎵 O SOM ÉPICO DE MONTAGEM 🎵 ---
	$SomTransformacao.play()
	# ------------------------------------
	# 1. Esconde o corpo inteiro (que agora tem todas as peças coladas a ele)
	$Corpo.visible = false
	
	# 2. Revela o robô em pé
	$RoboEmPe.visible = true
	
	# 3. Dá o Play na animação dele a andar
	$RoboEmPe.play("default")
	
	# 4. Cria uma etiqueta (meta) para avisar o script de movimento que ele já pode andar
	$RoboEmPe.set_meta("andando", true)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/menu_principal.tscn")
