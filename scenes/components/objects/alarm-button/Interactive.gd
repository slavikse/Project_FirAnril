extends Area3D

signal interact(is_interact: bool)

# todo интернациализация. сюда должно быть передано, какую реакцию вызовет и на какую кнопку
@export var message := ''
@export var button := ''

var _is_interact := false

func _process(_delta: float) -> void:
    if _is_interact and Input.is_action_just_pressed('interact'):
        print('interact - кнопка нажата')

# TODO добавить обработку нажатия клавиши. если в момент, когда приблизился к кнопке нажал Е,
# то сработает нажатие красной кнопки.
# еще уведомление на экране, что элемент интерактивный и можно нажать клавишу Е

func start_interact() -> void:
    _is_interact = true
    interact.emit(_is_interact)
    # todo показывать уведомление (UI)
    print('start_interact ', message, ' ', button)

func end_interact() -> void:
    _is_interact = false
    interact.emit(_is_interact)
    # todo скрывать уведомление (UI)
