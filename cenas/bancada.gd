extends Node2D

func _ready():
	print("Laboratório VoltQuest iniciado e pronto para montagem!")
	
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/menu_principal.tscn")

func _on_button_2_pressed() -> void:
	print("O botão foi clicado com sucesso!") # <- Adicione esta linha
	get_tree().change_scene_to_file("res://cenas/seguidor_de_linha.tscn")
