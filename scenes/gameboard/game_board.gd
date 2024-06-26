extends Control

@onready var settings: DifficultySettings = GameController.selected_mode
@onready var grid: GridContainer = %Grid
@onready var category_panels: VBoxContainer = %CategoryPanels
@onready var timer: Timer = %Timer
@onready var lives_and_hints: Label = %LivesAndHints
@onready var timer_label: Label = %TimerLabel

var category_panel = preload("res://scenes/gameboard/CategoryPanel.tscn")
var tela_disarm_scene = preload("res://cena_disarm.tscn")


# [{ text: String, category: String }]
var selected_words: Array[Dictionary]

var pressed_buttons: Array[GameButton]

var total_time_sec: int
var lives: int
var hints: int

var grab_focus_flag = true
var grab_focus_counter = 10

var buttons = []

func _ready():
	_select_words()
	grid.set_columns(settings.board_size)
	
	total_time_sec = settings.total_time_sec
	lives = settings.lives
	hints = settings.hints
	
	timer.wait_time = total_time_sec
	lives_and_hints.text = "Lives: " + str(lives) + " | Hints: " + str(hints)
	
	for word in selected_words:
		var button = GameButton.new(word.text, word.category)
		grid.add_child(button)
		button.pressed.connect(_on_word_button_pressed.bind(button))
	
	timer.start()

func _process(_delta):
	buttons = grid.get_children()
	timer_label.text = str(int(timer.time_left))
	GameController.time_left = timer.time_left
	
	if grid.get_child_count() == 0:
		_win()
	if lives == 0:
		_lose()
		
	lives_and_hints.text = "Lives: " + str(lives) + " | Hints: " + str(hints)
		
	if grab_focus_flag and not buttons.is_empty():
		grab_focus_counter -= 1
		if grab_focus_counter == 0:
			var game_button_to_focus = (grid.get_children()[0] as GameButton)
			if game_button_to_focus != null:
				game_button_to_focus.select()
			grab_focus_flag = false
			grab_focus_counter = 10

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

func _on_word_button_pressed(button: GameButton):
	pressed_buttons.append(button)
	
	var words: Array[String] = []
	for element in pressed_buttons:
		words.append(element.text as String)
	
	if pressed_buttons.size() == settings.board_size:
		if (pressed_buttons.all(func(b: GameButton): return b.category == button.category)):
			var new_panel = category_panel.instantiate()
			new_panel.initialize(button.category, words)
			category_panels.add_child(new_panel)
			
			for game_button in (grid.get_children() as Array[GameButton]):
				if game_button.category == button.category:
					game_button.queue_free()
		else:
			for pressed_button in pressed_buttons:
				pressed_button.set_pressed_no_signal(false)
			lives -= 1
		pressed_buttons = []
		grab_focus_flag = true

func _win():
	GameController.winning_cable = (randi()%2) + 1
	print("You win!")
	GameController.goto_scene("res://cena_disarm.tscn")

func _lose():
	timer.stop()
	print("You lose!")
	GameController.goto_scene("res://canvas_layer.tscn")
