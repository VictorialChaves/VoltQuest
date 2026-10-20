extends HSlider

# Digite o nome exato do Bus que criámos no Passo 1
@export var nome_do_bus: String = "Musica" 
var indice_do_bus: int

func _ready():
	# Descobre qual é o número daquele canal de áudio na mesa de som
	indice_do_bus = AudioServer.get_bus_index(nome_do_bus)

# ATENÇÃO: Conecte o sinal 'value_changed' do HSlider a esta função!
func _on_value_changed(value: float) -> void:
	if value == 0:
		# Muta totalmente o som se o slider estiver no zero
		AudioServer.set_bus_mute(indice_do_bus, true)
	else:
		AudioServer.set_bus_mute(indice_do_bus, false)
		# A mágica que converte a barra (0 a 1) em Decibéis
		AudioServer.set_bus_volume_db(indice_do_bus, linear_to_db(value))
