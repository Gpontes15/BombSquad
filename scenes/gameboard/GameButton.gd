extends Control

class_name GameButton

@export var text: String
@export var category: String

var button: Button = null
signal pressed()

func _init(word: String, word_category: String):
	text = word
	category = word_category

func _ready():
	button = Button.new()
	button.text = text
	button.pressed.connect(_pressed)
	button.toggle_mode = true
	add_child(button)

func select():
	print("Select: " + text)
	(button as Button).grab_focus.call_deferred()

func _pressed():
	pressed.emit()

func set_pressed_no_signal(boolean: bool):
	(button as Button).set_pressed_no_signal(boolean)
