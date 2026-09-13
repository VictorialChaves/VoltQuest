extends Area2D

# Atenção aqui: O nome depois do $ tem que ser igualzinho ao da lista!
@onready var painel_info = $Painel 

func _ready():
	painel_info.hide()

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		print("Clicou na lâm|pada!") 
		painel_info.visible = !painel_info.visible
