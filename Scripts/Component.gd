extends Node
class_name Component

## This is a simple class for creating reusable components for composition.

static var components_by_type: Dictionary = {}

func _enter_tree():
    if self.class_name != "Component":
        if not Component.components_by_type.has(self.class_name):
            Component.components_by_type[self.class_name] = []
        Component.components_by_type[self.class_name].append(self)

func _exit_tree():
    if self.class_name != "Component":
        if Component.components_by_type.has(self.class_name):
            Component.components_by_type[self.class_name].erase(self)

## Get all components of a specific type.
static func get_components_by_type(component_type: String) -> Array:
    if Component.components_by_type.has(component_type):
        return Component.components_by_type[component_type]
    return []

## Get a component of a specific type from a node.
static func get_component(node: Node, component_type: String) -> Component:
    for component in node.get_children():
        if component is Component:
            if component.class_name == component_type:
                return component
    return null

## Get all components of a specific type from a node.
static func get_components(node: Node, component_type: String) -> Array:
    var components = []
    for component in node.get_children():
        if component is Component:
            if component.class_name == component_type:
                components.append(component)
    return components

## Get a component with the matching name from a node.
static func get_component_by_name(node: Node, component_name: String) -> Component:
    for component in node.get_children():
        if component is Component:
            if component.name == component_name:
                return component
    return null
