extends CanvasLayer

@onready var cor = $MarginContainer/CenterContainer/Rows/Title/Cor

# Called when the node enters the scene tree for the first time.
func _ready():
	var colors = ["Azul", "Vermelho"]
	var cor_aleatoria = colors[randi() % colors.size()]
	cor.text = cor_aleatoria




