import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Copy of Flutter's SlottedMultiChildRenderObjectWidgetMixin but with support
/// for Slivers.
mixin SlottedMultiChildRenderObjectWidgetMixin<S> on RenderObjectWidget {
  /// Returns a list of all available slots.
  ///
  /// The list of slots must be static and must never change for a given class
  /// implementing this mixin.
  ///
  /// Typically, an [Enum] is used to identify the different slots. In that case
  /// this getter can be implemented by returning what the `values` getter
  /// of the enum used returns.
  @protected
  Iterable<S> get slots;

  /// Returns the widget that is currently occupying the provided `slot`.
  ///
  /// The [RenderObject] configured by this class will be configured to have
  /// the [RenderObject] produced by the returned [Widget] in the provided
  /// `slot`.
  @protected
  Widget? childForSlot(S slot);

  @override
  SlottedContainerRenderObjectMixin<S> createRenderObject(BuildContext context);

  @override
  void updateRenderObject(
      BuildContext context, SlottedContainerRenderObjectMixin<S> renderObject);

  @override
  SlottedRenderObjectElement<S> createElement() =>
      SlottedRenderObjectElement<S>(this);
}

/// Mixin for a [RenderObject] configured by a [SlottedMultiChildRenderObjectWidgetMixin].
///
/// The [RenderObject] child currently occupying a given slot can be obtained by
/// calling [childForSlot].
///
/// Implementers may consider overriding [children] to return the children
/// of this render object in a consistent order (e.g. hit test order).
///
/// The type parameter `S` is the type for the slots to be used by this
/// [RenderObject] and the [SlottedMultiChildRenderObjectWidgetMixin] it was
/// configured by. In the typical case, `S` is an [Enum] type.
///
/// See [SlottedMultiChildRenderObjectWidgetMixin] for example code showcasing
/// how this mixin is used in combination with the
/// [SlottedMultiChildRenderObjectWidgetMixin].
///
/// See also:
///
///  * [ContainerRenderObjectMixin], which organizes its children in a single
///    list.
mixin SlottedContainerRenderObjectMixin<S> on RenderObject {
  /// Returns the [RenderObject] child that is currently occupying the provided
  /// `slot`.
  ///
  /// Returns null if no [RenderObject] is configured for the given slot.
  @protected
  RenderObject? childForSlot(S slot) => _slotToChild[slot];

  /// Returns an [Iterable] of all non-null children.
  ///
  /// This getter is used by the default implementation of [attach], [detach],
  /// [redepthChildren], [visitChildren], and [debugDescribeChildren] to iterate
  /// over the children of this [RenderObject]. The base implementation makes no
  /// guarantee about the order in which the children are returned. Subclasses,
  /// for which the child order is important should override this getter and
  /// return the children in the desired order.
  @protected
  Iterable<RenderObject> get children => _slotToChild.values;

  /// Returns the debug name for a given `slot`.
  ///
  /// This method is called by [debugDescribeChildren] for each slot that is
  /// currently occupied by a child to obtain a name for that slot for debug
  /// outputs.
  ///
  /// The default implementation calls [EnumName.name] on `slot` it it is an
  /// [Enum] value and `toString` if it is not.
  @protected
  String debugNameForSlot(S slot) {
    if (slot is Enum) {
      return slot.name;
    }
    return slot.toString();
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    for (final child in children) {
      child.attach(owner);
    }
  }

  @override
  void detach() {
    super.detach();
    for (final child in children) {
      child.detach();
    }
  }

  @override
  void redepthChildren() {
    children.forEach(redepthChild);
  }

  @override
  void visitChildren(RenderObjectVisitor visitor) {
    children.forEach(visitor);
  }

  @override
  List<DiagnosticsNode> debugDescribeChildren() {
    final List<DiagnosticsNode> value = <DiagnosticsNode>[];
    final childToSlot = Map<RenderObject, S>.fromIterables(
      _slotToChild.values,
      _slotToChild.keys,
    );
    for (final child in children) {
      _addDiagnostics(child, value, debugNameForSlot(childToSlot[child] as S));
    }
    return value;
  }

  void _addDiagnostics(
    RenderObject child,
    List<DiagnosticsNode> value,
    String name,
  ) {
    value.add(child.toDiagnosticsNode(name: name));
  }

  final _slotToChild = <S, RenderObject>{};

  void _setChild(RenderObject? child, S slot) {
    final oldChild = _slotToChild[slot];
    if (oldChild != null) {
      dropChild(oldChild);
      _slotToChild.remove(slot);
    }
    if (child != null) {
      _slotToChild[slot] = child;
      adoptChild(child);
    }
  }
}

/// Element used by the [SlottedMultiChildRenderObjectWidgetMixin].
class SlottedRenderObjectElement<S> extends RenderObjectElement {
  /// Creates an element that uses the given widget as its configuration.
  SlottedRenderObjectElement(
      SlottedMultiChildRenderObjectWidgetMixin<S> super.widget);

  final Map<S, Element> _slotToChild = <S, Element>{};

  @override
  SlottedContainerRenderObjectMixin<S> get renderObject =>
      super.renderObject as SlottedContainerRenderObjectMixin<S>;

  @override
  void visitChildren(ElementVisitor visitor) {
    _slotToChild.values.forEach(visitor);
  }

  @override
  void forgetChild(Element child) {
    assert(_slotToChild.containsValue(child));
    assert(child.slot is S);
    assert(_slotToChild.containsKey(child.slot));
    _slotToChild.remove(child.slot);
    super.forgetChild(child);
  }

  @override
  void mount(Element? parent, Object? newSlot) {
    super.mount(parent, newSlot);
    _updateChildren();
  }

  @override
  void update(SlottedMultiChildRenderObjectWidgetMixin<S> newWidget) {
    super.update(newWidget);
    assert(widget == newWidget);
    _updateChildren();
  }

  List<S>? _debugPreviousSlots;

  void _updateChildren() {
    final SlottedMultiChildRenderObjectWidgetMixin<S>
        slottedMultiChildRenderObjectWidgetMixin =
        widget as SlottedMultiChildRenderObjectWidgetMixin<S>;
    assert(() {
      _debugPreviousSlots ??=
          slottedMultiChildRenderObjectWidgetMixin.slots.toList();
      return listEquals(_debugPreviousSlots,
          slottedMultiChildRenderObjectWidgetMixin.slots.toList());
    }(), '${widget.runtimeType}.slots must not change.');
    assert(
        slottedMultiChildRenderObjectWidgetMixin.slots.toSet().length ==
            slottedMultiChildRenderObjectWidgetMixin.slots.length,
        'slots must be unique');

    for (final S slot in slottedMultiChildRenderObjectWidgetMixin.slots) {
      _updateChild(
          slottedMultiChildRenderObjectWidgetMixin.childForSlot(slot), slot);
    }
  }

  void _updateChild(Widget? widget, S slot) {
    final Element? oldChild = _slotToChild[slot];
    assert(oldChild == null ||
        oldChild.slot ==
            slot); // Reason why [moveRenderObjectChild] is not reachable.
    final Element? newChild = updateChild(oldChild, widget, slot);
    if (oldChild != null) {
      _slotToChild.remove(slot);
    }
    if (newChild != null) {
      _slotToChild[slot] = newChild;
    }
  }

  @override
  void insertRenderObjectChild(RenderObject child, S slot) {
    renderObject._setChild(child, slot);
    assert(renderObject._slotToChild[slot] == child);
  }

  @override
  void removeRenderObjectChild(RenderObject child, S slot) {
    assert(renderObject._slotToChild[slot] == child);
    renderObject._setChild(null, slot);
    assert(renderObject._slotToChild[slot] == null);
  }

  @override
  void moveRenderObjectChild(
    RenderObject child,
    Object? oldSlot,
    Object? newSlot,
  ) {
    // Existing elements are never moved to a new slot, see assert in [_updateChild].
    assert(false, 'not reachable');
  }
}
