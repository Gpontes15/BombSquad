extends Control

@onready var settings: DifficultySettings = GameController.selected_mode
@onready var grid: GridContainer = %Grid

var words: Array[String]

func _ready():
	words = settings.words.duplicate()
	words.shuffle()
	
	grid.columns = settings.board_size

func _process(_delta):
	pass
