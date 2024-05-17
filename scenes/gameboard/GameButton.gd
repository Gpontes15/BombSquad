extends Control

class_name GameButton

@export var text: String
@export var category: String


func _init(word: String, word_category: String):
	text = word
	category = word_category

func _ready():
	var button: Button = Button.new()
	button.text = text
	add_child(button)
