extends DifficultySettings

class_name EasySettings

func _init(p_words: Array[String]):
	board_size = 3
	total_time_sec = 999
	lives = 999
	hints = 3
	name = "EASY"
	words = p_words
