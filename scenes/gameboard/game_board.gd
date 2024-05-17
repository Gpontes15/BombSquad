extends Control

@onready var settings: DifficultySettings = GameController.selected_mode
@onready var grid: GridContainer = %Grid

# [{ text: String, category: String }]
var selected_words: Array[Dictionary]

func _ready():
	_select_words()
	grid.set_columns(settings.board_size)
	
	for word in selected_words:
		var button = GameButton.new(word.text, word.category)
		grid.add_child(button)

func _select_words():
	var word_list: Dictionary = GameController.word_list.duplicate(true)
	var categories = word_list.keys()
	categories.shuffle()
	
	var selected_categories = categories.slice(0, settings.board_size)
	
	for category in selected_categories:
		var words_in_category = word_list[category]
		words_in_category.shuffle()
		var selected_words_by_category = words_in_category.slice(0, settings.board_size)
		for word in selected_words_by_category:
			selected_words.append({ "text": word, "category": category })
	selected_words.shuffle()
