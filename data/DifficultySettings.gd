extends Resource

class_name DifficultySettings

@export var name: String
@export var board_size: int
@export var words: Array[String]
@export var total_time_sec: int
@export var lives: int
@export var hints: int

func _init(p_words: Array[String]):
	words = p_words
