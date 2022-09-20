extends Node

var score
var time
var lives

var VP = null


func _physics_process(_delta):
	var Asteroid_Container = get_node_or_null("/root/Game/Asteroid_Container")
	var Enemy_Container = get_node_or_null("/root/Game/Enemy_Container")
	if Asteroid_Container != null and Enemy_Container != null:
		if Asteroid_Container.get_child_count() == 0 and Enemy_Container.get_child_count()==0:
			var _scene = get_tree().change_scene("res://UI/End_Game.tscn")

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	randomize()
	VP = get_viewport().size
	var _signal = get_tree().get_root().connect("size_changed",self,"_resize")
	reset()

func _resize():
	VP = get_viewport().size
	var HUD = get_node_or_null("/root/Game/UI/HUD")
	if HUD != null:
		HUD.update_lives()


func _unhandled_input(event):
	if event.is_action_pressed("menu"):
		var Pause_Menus = get_node_or_null("/root/Game/UI/Pause_Menus")
		if Pause_Menus == null:
			get_tree().quit()
		else:
			if Pause_Menus.visible:
				Pause_Menus.hide()
				get_tree().paused = false
			else:
				Pause_Menus.show()
				get_tree().paused = true

func reset():
	score = 0
	time = 30
	lives = 5
	
func update_score(s):
	score = score + s
	var HUD = get_node_or_null("/root/Game/UI/HUD")
	if HUD != null:
		HUD.update_score()

func update_lives(l):
	lives += l
	if lives < 0:
		var _scene = get_tree().change_scene("res://UI/End_Game.tscn")
	var HUD = get_node_or_null("/root/Game/UI/HUD")
	if HUD != null:
		HUD.update_lives()	
