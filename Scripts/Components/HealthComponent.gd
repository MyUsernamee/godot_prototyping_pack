extends FloatComponent

class_name HealthComponent

var max_health: float = 100

signal died
signal healed(amount: float)
signal took_damage(amount: float)

func _ready():
    value = max_health

func take_damage(amount: float):
    value -= amount
    emit_signal("took_damage", amount)
    if value <= 0:
        kill()

func kill():
    value = 0
    emit_signal("died")
    queue_free()

func heal(amount: float):
    value += amount
    if value > max_health:
        value = max_health
    emit_signal("healed", amount)

func get_health() -> float:
    return value
