extends DifficultySettings

class_name NormalSettings

func _init(p_words: Array[String]):
	board_size = 3
	total_time_sec = 99
	lives = 4
	hints = 1
	name = "NORMAL"
	words = p_words
