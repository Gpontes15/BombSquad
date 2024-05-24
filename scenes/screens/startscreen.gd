extends CanvasLayer

@onready var game_title_label = $MarginContainer/CenterContainer/VBoxContainer/Label
@onready var easy_button = $MarginContainer/CenterContainer/VBoxContainer/VBoxContainer/EasyButton
@onready var medium_button = $MarginContainer/CenterContainer/VBoxContainer/VBoxContainer/NormalButton
@onready var hard_button = $MarginContainer/CenterContainer/VBoxContainer/VBoxContainer/HardButton

var control_array = []

func _ready():
	control_array = [game_title_label, easy_button, medium_button, hard_button]
	for control in control_array:
		(control as Control).visible = false
	easy_button.grab_focus()

func _process(_delta):
	if control_array.size() > 0:
		var control = control_array.pop_front() as Control
		control.visible = true


func _on_hard_button_pressed():
	GameController.select_difficulty("HARD")
	GameController.goto_scene("res://scenes/gameboard/GameBoard.tscn")


func _on_normal_button_pressed():
	GameController.select_difficulty("NORMAL")
	GameController.goto_scene("res://scenes/gameboard/GameBoard.tscn")

func _on_easy_button_pressed():
	GameController.select_difficulty("EASY")
	GameController.goto_scene("res://scenes/gameboard/GameBoard.tscn")
