extends CanvasLayer

@onready var game_title_label = $MarginContainer/CenterContainer/VBoxContainer/Label
@onready var easy_button = $MarginContainer/CenterContainer/VBoxContainer/VBoxContainer/Button
@onready var medium_button = $MarginContainer/CenterContainer/VBoxContainer/VBoxContainer/Button2
@onready var hard_button = $MarginContainer/CenterContainer/VBoxContainer/VBoxContainer/Button3
@onready var options_button = $MarginContainer/CenterContainer/VBoxContainer/VBoxContainer/Button4

var control_array = []

func _ready():
	control_array = [game_title_label, easy_button, medium_button, hard_button, options_button]
	for control in control_array:
		(control as Control).visible = false

func _process(_delta):
	if control_array.size() > 0:
		var control = control_array.pop_front() as Control
		control.visible = true

func _on_button_pressed(button_name):
	match button_name:
		"easy":
			print("Botão Fácil pressionado!")
			# Lógica para iniciar o nível fácil (substitua com a lógica real)
			get_tree().change_scene("res://Cenas/main.tscn")
		"medium":
			print("Botão Médio pressionado!")
			# Lógica para iniciar o nível médio (substitua com a lógica real)
			get_tree().change_scene("res://Cenas/main.tscn")
		"hard":
			print("Botão Difícil pressionado!")
			# Lógica para iniciar o nível difícil (substitua com a lógica real)
			get_tree().change_scene("res://Cenas/main.tscn")
		"options":
			print("Botão Opções pressionado!")
			# Lógica para abrir a tela de opções (substitua com a lógica real)
			get_tree().change_scene("res://Cenas/options.tscn")
		"exit":
			print("Botão Sair pressionado!")
			get_tree().quit()

# Este método seria chamado quando um botão é pressionado
# O argumento button_name seria o nome do botão pressionado
# Por exemplo, "easy", "medium", "hard", "options", etc.
