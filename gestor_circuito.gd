extends Node

# Sinais globais de energia
signal energia_ligada
signal energia_desligada
signal curto_circuito

# O caderno de anotações (onde as peças se ligam)
var trilhas = {}

# O mapa de pontes (como a eletricidade viaja por dentro das peças)
var pontes_internas = {
	"Pino1_Resistor": "Pino2_Resistor",
	"Pino2_Resistor": "Pino1_Resistor",
	"Pino1_LED": "Pino2_LED",
	"Pino2_LED": "Pino1_LED",
	"Ponta1_FioPositivo": "Ponta2_FioPositivo",
	"Ponta2_FioPositivo": "Ponta1_FioPositivo",
	"Ponta1_FioNegativo": "Ponta2_FioNegativo",
	"Ponta2_FioNegativo": "Ponta1_FioNegativo",
	"Pino1_Interruptor": "Pino2_Interruptor",
	"Pino2_Interruptor": "Pino1_Interruptor"
}

# A Bateria é a base de tudo, por isso já nasce anotada!
func _ready():
	trilhas["PinoPositivo"] = ["Positivo_Bateria"]
	trilhas["PinoNegativo"] = ["Negativo_Bateria"]

# --- FUNÇÕES DE SENSOR ---
func conectar_pino(nome_da_trilha, nome_do_pino):
	if not trilhas.has(nome_da_trilha):
		trilhas[nome_da_trilha] = []
	if not nome_do_pino in trilhas[nome_da_trilha]:
		trilhas[nome_da_trilha].append(nome_do_pino)
	print("🔌 CONECTADO: ", nome_do_pino, " na ", nome_da_trilha)

func desconectar_pino(nome_da_trilha, nome_do_pino):
	if trilhas.has(nome_da_trilha):
		trilhas[nome_da_trilha].erase(nome_do_pino)
		print("❌ DESCONECTADO: ", nome_do_pino, " da ", nome_da_trilha)

# --- O ALGORITMO DE VALIDAÇÃO ---
func testar_circuito():
	print("\n--- A INICIAR MAPEAMENTO DO CIRCUITO ---")
	print("Base de Dados Atual: ", trilhas) 
	
	# 1. Verifica se o LED está conectado em alguma trilha da protoboard
	var led_na_placa = false
	for pinos_da_trilha in trilhas.values():
		if "Pino1_LED" in pinos_da_trilha or "Pino2_LED" in pinos_da_trilha:
			led_na_placa = true
			break
	
	var trilhas_para_visitar = []
	var trilhas_visitadas = []
	var pinos_visitados = ["Positivo_Bateria"] 
	
	for nome_da_trilha in trilhas:
		if "Positivo_Bateria" in trilhas[nome_da_trilha]:
			trilhas_para_visitar.append(nome_da_trilha)
			
	if trilhas_para_visitar.size() == 0:
		print("❌ ERRO: O Positivo da Bateria não está ligado em lado nenhum!")
		emit_signal("energia_desligada") 
		# Só explode se o LED estiver na mesa
		if led_na_placa:
			emit_signal("curto_circuito") 
		return false
		
	while trilhas_para_visitar.size() > 0:
		var trilha_explorada = trilhas_para_visitar.pop_front()
		
		if trilha_explorada in trilhas_visitadas:
			continue
			
		trilhas_visitadas.append(trilha_explorada)
		print("🔍 A explorar a trilha: ", trilha_explorada)
		
		for pino in trilhas[trilha_explorada]:
			if pino == "Negativo_Bateria":
				print("✅ SUCESSO! Circuito Fechado! A corrente chegou ao negativo!")
				emit_signal("energia_ligada")
				return true
				
			if not pino in pinos_visitados:
				pinos_visitados.append(pino)
				
				if pontes_internas.has(pino):
					var pino_saida = pontes_internas[pino]
					pinos_visitados.append(pino_saida)
					
					for nome_trilha in trilhas:
						if pino_saida in trilhas[nome_trilha]:
							if not nome_trilha in trilhas_visitadas:
								trilhas_para_visitar.append(nome_trilha)
								print("   ➡️ Corrente viajou até ", pino_saida, " (Nova Trilha: ", nome_trilha, ")")
							break

	print("❌ FALHA: O circuito está interrompido (aberto). A corrente perdeu-se!")
	emit_signal("energia_desligada") 
	# Só explode se o LED estiver na mesa
	if led_na_placa:
		emit_signal("curto_circuito")    
	return false
	
# Gatilho de teste (Tecla Espaço)
func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE:
		testar_circuito()
