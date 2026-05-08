class_name menu_principal extends Node2D
@onready var transition: AnimatedSprite2D = $Input_transition
@onready var primeira_vez: Node2D = $PrimeiraVez/PrimeiraVez

func _ready() -> void:
	HighContrast.apply_to_tree(self)
		
	SaveLoad._load()
	transition.visible = true
	transition.frame = 7
	transition.play_backwards("default")
	
	if Configs.configs.primeira_vez:
		primeira_vez._iniciar()
		primeira_vez.visible = true
		Configs._change_primeira_vez()
	else:
		primeira_vez.visible = false

	

func _on_new_game_button_mouse_entered() -> void:
	if Configs.configs.leitor_de_tela:
		LeitorDeTela._ler_texto(atr("NOVO JOGO"))


func _on_options_game_button_mouse_entered() -> void:
	if Configs.configs.leitor_de_tela:
		LeitorDeTela._ler_texto(atr("OPÇÕES"))
	

func _on_exit_game_button_mouse_entered() -> void:
	if Configs.configs.leitor_de_tela:
		LeitorDeTela._ler_texto(atr("SAIR"))
