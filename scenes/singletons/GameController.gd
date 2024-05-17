extends Node

@export var hard_mode: DifficultySettings
@export var normal_mode: DifficultySettings
@export var easy_mode: DifficultySettings

@export var selected_mode: DifficultySettings
@export var difficulties: Array[DifficultySettings]

var word_list: Dictionary

func _ready():
	difficulties = [easy_mode, normal_mode, hard_mode]
	selected_mode = hard_mode
	_load_word_list("res://data/word_list.txt")

func select_difficulty(difficulty_name: String):
	var byName: Callable = func(diff: DifficultySettings): return diff.name == difficulty_name
	selected_mode = difficulties.filter(byName).front()

func _load_word_list(filename: String):
	var file = FileAccess.open(filename, FileAccess.READ)
	
	var current_category: String
	while (!file.eof_reached()):
		var line: String = file.get_line()
		if (line.contains("CATEGORY: ")):
			current_category = line.split(": ")[1]
			word_list[current_category] = []
		elif (line.begins_with("	")):
			(word_list[current_category] as Array[String]).append(line.replace("	", ""))
	file.close()
	print(word_list)
