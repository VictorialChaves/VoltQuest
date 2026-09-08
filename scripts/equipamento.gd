extends Area2D

@onready var painel_info = $Panel

func _ready():
	painel_info.hide()

# Coloca-se o "_" antes de viewport e shape_idx para o Godot ignorar o aviso amarelo
func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		print("O mouse clicou na peça!") 
		painel_info.visible = !painel_info.visible
