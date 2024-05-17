extends DifficultySettings

class_name HardSettings

func _init(p_words: Array[String]):
	board_size = 4
	total_time_sec = 60
	lives = 0
	hints = 0
	name = "HARD"
	words = p_words
