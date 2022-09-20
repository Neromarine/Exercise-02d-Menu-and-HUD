extends Control

onready var indicator = load("res://UI/Indicator.tscn")

var lives_pos = Vector2.ZERO
var lives_index = 30

func _ready():
	update_score()
	update_time()
	update_lives()
	pass

func update_score():
	$Score.text = "Score: " + str(Global.score)
func update_time():
	$Time.text = "Time Remaining: " + str(Global.time)
	
func update_lives():
	lives_pos = Vector2(20,Global.VP.y - 20)
	for child in $indicator_container.get_children():
		child.queue_free()
	for i in range(Global.lives):
		var Indicator = indicator.instance()
		Indicator.position = Vector2(lives_pos.x + i*lives_index, lives_pos.y)
		$indicator_container.add_child(Indicator)

func _on_Timer_timeout():
	Global.time -= 1
	if Global.time < 0:
		var _scene = get_tree().change_scene("res://UI/End_Game.tscn")
	else:
		update_time()


