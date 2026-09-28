extends Node2D

func _ready():
	print("Laboratório VoltQuest iniciado e pronto para montagem!")
	
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/menu_principal.tscn")
