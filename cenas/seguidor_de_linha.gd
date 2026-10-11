extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/menu_principal.tscn")


func _on_button_2_pressed() -> void:
	print("O botão foi clicado com sucesso!") # <- Adicione esta linha
	get_tree().change_scene_to_file("res://cenas/robo_montagem.tscn")
