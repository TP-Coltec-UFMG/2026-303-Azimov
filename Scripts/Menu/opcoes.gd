class_name menu_opcoes extends Node2D
@onready var transition: AnimatedSprite2D = $Input_transition

func _ready() -> void:
	HighContrast.apply_to_tree(self)
	transition.visible = true
	transition.frame = 5
	transition.play_backwards("default")


func _on_option_language_button_mouse_entered() -> void:
	if Configs.configs.leitor_de_tela:
		LeitorDeTela._ler_texto(atr("Idioma"))


func _on_menu_sounds_settings_mouse_entered() -> void:
	if Configs.configs.leitor_de_tela:
		LeitorDeTela._ler_texto(atr("Opções de Volume"))


func _on_menu_controllers_mouse_entered() -> void:
	if Configs.configs.leitor_de_tela:
		LeitorDeTela._ler_texto(atr("Opções de Controles"))


func _on_menu_interface_mouse_entered() -> void:
	if Configs.configs.leitor_de_tela:
		LeitorDeTela._ler_texto(atr("Opções de Interface"))


func _on_menu_acessibilidadades_mouse_entered() -> void:
	if Configs.configs.leitor_de_tela:
		LeitorDeTela._ler_texto(atr("Opções de Acessibilidade"))


func _on_back_to_menu_button_mouse_entered() -> void:
	if Configs.configs.leitor_de_tela:
		LeitorDeTela._ler_texto(atr("VOLTAR"))
