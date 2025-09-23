import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/utils/texts/app_text.dart';

class CustomDropdown<T> extends StatefulWidget {
  final String? hint; // Custom button content
  final void Function(T, int) onChange; // Callback when item is selected
  final List<DropdownItem<T>>? items; // List of dropdown items
  final DropdownStyle? dropdownStyle; // Customization for dropdown appearance
  final DropdownButtonStyle? dropdownButtonStyle; // Customization for button
  final Widget? prefixIcon; // Optional prefix icon
  final Widget? suffixIcon; // Optional suffix icon
  final bool? hideIcon; // Whether to hide the icon
  final MainAxisSize mainAxisSize;
  final double height;

  const CustomDropdown({
    Key? key,
    this.hint,
    required this.items,
    required this.onChange,
    this.dropdownStyle = const DropdownStyle(),
    this.height = 120,
    this.dropdownButtonStyle = const DropdownButtonStyle(
      height: 48,
    ),
    this.mainAxisSize = MainAxisSize.max,
    this.prefixIcon,
    this.suffixIcon,
    this.hideIcon = false,
  }) : super(key: key);

  @override
  _CustomDropdownState<T> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>>
    with TickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  int _currentIndex = -1;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _expandAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    var style = widget.dropdownButtonStyle;

    // Get the selected item's prefix icon if available
    Widget? selectedPrefixIcon;
    if (_currentIndex != -1) {
      selectedPrefixIcon = widget.items?[_currentIndex].prefixIcon;
    }
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          // Add a Container to give bounded width
          width: 320.w, // Ensure full width or provide a custom width
          child: Row(
            mainAxisAlignment:
                style?.mainAxisAlignment ?? MainAxisAlignment.start,
            mainAxisSize: widget.mainAxisSize,
            children: [
              // Show prefixIcon of the selected item if it exists
              if (selectedPrefixIcon != null)
                SizedBox(
                  height: 25.w, // Ensure this is a valid size in the context
                  width: 25.w,
                  child: selectedPrefixIcon,
                ),

              // Display the hint text or selected item text
              Expanded(
                child: AppText.subHeader(
                  text: _currentIndex == -1
                      ? widget.hint ?? 'Select'
                      : widget.items![_currentIndex].text,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),

              // Show suffix icon if it exists
              if (widget.suffixIcon != null)
                Align(
                  alignment: Alignment.centerRight,
                  child: widget.suffixIcon!,
                ),
            ],
          ),
        ),
      ),
    );
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    var topOffset = offset.dy + size.height + 5;

    return OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: () => _toggleDropdown(close: true),
        behavior: HitTestBehavior.translucent,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.black38),
          child: Stack(
            children: [
              Positioned(
                left: offset.dx,
                top: topOffset,
                width: widget.dropdownStyle?.width ?? size.width,
                child: CompositedTransformFollower(
                  offset: widget.dropdownStyle?.offset ??
                      Offset(0, size.height + 15),
                  link: _layerLink,
                  showWhenUnlinked: false,
                  child: Material(
                    elevation: widget.dropdownStyle?.elevation ?? 0,
                    borderRadius:
                        widget.dropdownStyle?.borderRadius ?? BorderRadius.zero,
                    color: widget.dropdownStyle?.color ?? Colors.white,
                    child: SizeTransition(
                      axisAlignment: 1,
                      sizeFactor: _expandAnimation,
                      child: ConstrainedBox(
                        constraints: widget.dropdownStyle?.constraints ??
                            BoxConstraints(
                                maxHeight: MediaQuery.of(context).size.height -
                                    topOffset -
                                    15),
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: widget.items?.length ?? 0,
                          itemBuilder: (context, index) {
                            final item = widget.items![index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 12)
                                  .r,
                              child: InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  setState(() {
                                    _currentIndex = index;
                                  });
                                  widget.onChange(item.value, index);
                                  _toggleDropdown();
                                },
                                child: item,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              color: Colors.grey.shade200,
                              height: 0.5,
                              thickness: 0.1,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleDropdown({bool close = false}) async {
    if (_isOpen || close) {
      await _animationController.reverse();
      _overlayEntry?.remove();
      setState(() => _isOpen = false);
    } else {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context)?.insert(_overlayEntry!);
      setState(() => _isOpen = true);
      _animationController.forward();
    }
  }
}

class DropdownItem<T> extends StatelessWidget {
  final T value;
  final String text;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const DropdownItem({
    Key? key,
    required this.value,
    required this.text,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (prefixIcon != null)
          Padding(padding: EdgeInsets.only(right: 8), child: prefixIcon!),
        Expanded(child: AppText.subHeader(text: text)),
        if (suffixIcon != null)
          Padding(padding: EdgeInsets.only(left: 8), child: suffixIcon!),
      ],
    );
  }
}

class DropdownButtonStyle {
  final MainAxisAlignment? mainAxisAlignment;
  final ShapeBorder? shape;
  final double? elevation;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;
  final double? width;
  final double? height;
  final Color? primaryColor;

  const DropdownButtonStyle({
    this.mainAxisAlignment,
    this.backgroundColor,
    this.primaryColor,
    this.constraints,
    this.height,
    this.width,
    this.elevation,
    this.padding,
    this.shape,
  });
}

class DropdownStyle {
  final BorderRadius? borderRadius;
  final double? elevation;
  final Color? color;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;
  final Offset? offset;
  final double? width;

  const DropdownStyle({
    this.constraints,
    this.offset,
    this.width,
    this.elevation,
    this.color,
    this.padding,
    this.borderRadius,
  });
}
