extends Area3D

signal interact()

# todo реализовать - единичный тык
@export var is_once := false
#@export var is_delay := false
#@export var delay_time := 0.0

# todo интернациализация. сюда должно быть передано, какую реакцию вызовет и на какую кнопку
@export var message := ''
@export var button := ''

var _is_interact := false

func _process(_delta: float) -> void:
    if _is_interact and Input.is_action_just_pressed('interact'):
        interact.emit()

func start_interact() -> void:
    _is_interact = true
    # todo показывать уведомление (UI)
    # еще уведомление на экране, что элемент интерактивный и можно нажать клавишу Е
    print('start_interact ', message, ' ', button)

func end_interact() -> void:
    _is_interact = false
    print('end_interact')
    # todo скрывать уведомление (UI)
