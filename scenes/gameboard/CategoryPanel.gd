extends PanelContainer

var category: String = "CATEGORY"
var words: Array[String] = ["WORD", "WORD", "WORD", "WORD"]

@onready var category_label = %Category
@onready var words_label = %Words

func _ready():
	category_label.text = category
	words_label.text = ", ".join(words) 

func initialize(new_category: String, new_words: Array[String]):
	category = new_category
	words = new_words
