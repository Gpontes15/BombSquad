extends Node

@export var hard_mode: DifficultySettings
@export var normal_mode: DifficultySettings
@export var easy_mode: DifficultySettings

@export var selected_mode: DifficultySettings
@export var difficulties: Array[DifficultySettings]

@export var time_left: float
@export var winning_cable: int = 0

var word_list: Dictionary
var current_scene = null

func _ready():
	difficulties = [easy_mode, normal_mode, hard_mode]
	selected_mode = hard_mode
	_load_word_list("res://data/word_list.txt")
	
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

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

func goto_scene(path):
	call_deferred("_deferred_goto_scene", path)
func _deferred_goto_scene(path):
	current_scene.free()
	var s = ResourceLoader.load(path)
	current_scene = s.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
