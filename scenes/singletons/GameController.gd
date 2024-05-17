extends Node

class_name GameController

@export var hard_mode: DifficultySettings = load("res://data/hard_mode.tres")
@export var normal_mode: DifficultySettings = load("res://data/normal_mode.tres")
@export var easy_mode: DifficultySettings = load("res://data/easy_mode.tres")

@export var selected_mode: DifficultySettings
@export var difficulties: Array[DifficultySettings]

func _ready():
	difficulties = [easy_mode, normal_mode, hard_mode]

func select_difficulty(name: String):
	var byName: Callable = func(diff: DifficultySettings): return diff.name == name
	selected_mode = difficulties.filter(byName).front()
