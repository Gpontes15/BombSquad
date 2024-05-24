extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	var colors = ["Azul", "Preto"]
	var cor_aleatoria = colors[randi() % colors.size()]
	$Cor.text = "Cor: " + cor_aleatoria




