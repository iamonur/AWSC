extends CharacterBody2D

@onready
var player = get_node("/root/Game/Player")#Will be the player node.

var health = 2

func _ready():
	%Slime.play_walk()


func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 300.0
	if not get_node("/root/Game").defeated:
		move_and_slide()

func take_damage():
	health -= 1
	%Slime.play_hurt()
	if health == 0:
		queue_free()
		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		get_node("/root/Game").score += 1
