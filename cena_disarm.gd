extends CanvasLayer

@onready var cor = $MarginContainer/CenterContainer/Rows/Title/Cor
@onready var timer = $Timer
@onready var timer_label = %TimerLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	var colors = ["Azul", "Vermelho"]
	var cor_aleatoria = colors[GameController.winning_cable - 1]
	cor.text = cor_aleatoria
	
	timer.wait_time = GameController.time_left
	timer.start()

func _process(_delta):
	timer_label.text = str(int(timer.time_left))
	
	if Input.is_action_just_pressed("cable_1"):
		if GameController.winning_cable == 1:
			GameController.goto_scene("res://cena_win.tscn")
		else:
			GameController.goto_scene("res://canvas_layer.tscn")
	elif Input.is_action_just_pressed("cable_2"):
		if GameController.winning_cable == 2:
			GameController.goto_scene("res://cena_win.tscn")
		else:
			GameController.goto_scene("res://canvas_layer.tscn")


func _on_timer_timeout():
	GameController.goto_scene("res://canvas_layer.tscn")
