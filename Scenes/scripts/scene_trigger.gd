class_name SceneTrigger
extends Area2D

@export var connected_scene: String
@export	var eh_elevador: bool
@export var andar_atual: int
@onready var painel_elevador: Node2D = $"../PainelElevador"

@onready var acesso_liberado: AudioStreamPlayer2D = $"Acesso liberado"
@onready var aceso_negado: AudioStreamPlayer2D = $"Aceso negado"

var andar_elevador_to_change : int 
var dentro_da_area : bool = false
var body_p : Player

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		dentro_da_area = true
		body_p = body


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		dentro_da_area = false
		
func _get_connect_scene_andar_novo(andar : int) -> String:
	if andar == 1:
		return "andar_saida"
	if andar == 2:
		return "andar_hall"
	if andar == 3:
		return "andar_hall"
	if andar == 4:
		return "andar_ferramentas"
	if andar == 5:
		return "andar_centro_de_energia"
	if andar == 6:
		return "andar_data_center"
		
	return "andar_invalido"
	
func usar_elevador(andar: int) -> void:
	if andar != andar_atual and eh_elevador:
		if dentro_da_area:
			scene_manager.change_scene(body_p, _get_connect_scene_andar_novo(andar))


func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("usar_cartao") and eh_elevador and dentro_da_area:
		painel_elevador.visible = true
		get_tree().paused = true

	if event.is_action_pressed("usar_cartao") and dentro_da_area and body_p.inventory.get_item_on_inventary("cartao") and body_p.usando_cartao and not eh_elevador:
		var tipo_cartao = body_p.inventory.get_item_control("cartao").tipo
		var tipo_sala_acessando
		
		if connected_scene.containsn("chefe"):
			tipo_sala_acessando = 3
		elif connected_scene.containsn("forte"):
			tipo_sala_acessando = 2
		else:
			tipo_sala_acessando = 1
		
		if tipo_cartao >= tipo_sala_acessando:
			acesso_liberado.play()
			await  acesso_liberado.finished
			if dentro_da_area:
				scene_manager.change_scene(body_p, connected_scene)
		else:
			aceso_negado.play()
			print("Acesso Negado")
			
