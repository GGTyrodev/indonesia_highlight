import 'package:flutter/material.dart' as mtr;

final mtr.Color defaultColor = mtr.Colors.grey[700];
final mtr.Color defaultSelectedColor = mtr.Colors.blue;

class IconTabBar extends mtr.StatefulWidget {
  final int index;
  final void Function(int i) onTap;
  final List<IconTabBarItem> items;
  final double elevation;
  final IconStyle iconStyle;
  final mtr.Color backgroundColor;

  IconTabBar({
    this.index,
    this.onTap,
    this.items,
    this.elevation = 8.0,
    this.iconStyle,
    this.backgroundColor = mtr.Colors.white,
  })  : assert(items != null),
        assert(items.length >= 2);

  @override
  _IconTabBarState createState() => _IconTabBarState();
}

class _IconTabBarState extends mtr.State<IconTabBar> {
  int currentIndex;
  IconStyle iconStyle;

  @override
  void initState() {
    currentIndex = widget.index ?? 0;
    iconStyle = widget.iconStyle ?? IconStyle();
    super.initState();
  }

  @override
  mtr.Widget build(mtr.BuildContext context) {
    return mtr.Material(
        elevation: widget.elevation,
        color: widget.backgroundColor,
        child: mtr.Row(
          mainAxisAlignment: mtr.MainAxisAlignment.spaceAround,
          mainAxisSize: mtr.MainAxisSize.max,
          children: widget.items.map((b) {
            final int i = widget.items.indexOf(b);
            final bool selected = i == currentIndex;

            return _IconTabBarItemButton(
              icon: b.icon,
              iconSize:
                  selected ? iconStyle.getSelectedSize() : iconStyle.getSize(),
              onTap: () => _onItemClick(i),
              color: selected
                  ? iconStyle.getSelectedColor()
                  : iconStyle.getColor(),
            );
          }).toList(),
        ));
  }

  _onItemClick(int i) {
    setState(() {
      currentIndex = i;
    });
    if (widget.onTap != null) widget.onTap(i);
  }
}

class IconTabBarItem {
  final mtr.IconData icon;
  IconTabBarItem(this.icon);
}

class IconStyle {
  final double size;
  final double onSelectSize;
  final mtr.Color color;
  final mtr.Color onSelectColor;

  IconStyle({this.size, this.onSelectSize, this.color, this.onSelectColor});

  getSize() {
    return size ?? 24.0;
  }

  getSelectedSize() {
    return onSelectSize ?? 24.0;
  }

  getColor() {
    return color ?? defaultColor;
  }

  getSelectedColor() {
    return onSelectColor ?? defaultSelectedColor;
  }
}
class _IconTabBarItemButton extends mtr.StatelessWidget {
  final mtr.IconData icon;
  final double iconSize;
  final void Function() onTap;
  final mtr.Color color;

  const _IconTabBarItemButton({
    mtr.Key key,
    this.icon,
    this.iconSize,
    this.onTap,
    this.color,
  }) :
        assert(icon != null),
        assert(iconSize != null),
        assert(color != null),
        assert(onTap != null),
        super(key: key);

  @override
  mtr.Widget build(mtr.BuildContext context) {
    return mtr.Expanded(
        child: mtr.InkResponse(
          key: key,
          child: mtr.Padding(
              padding: getPadding(),
              child: mtr.Column(
                  mainAxisSize: mtr.MainAxisSize.min,
                  children: <mtr.Widget>[
                    mtr.Icon(icon, size: iconSize, color: color),
                  ]
              )
          ),
          highlightColor: mtr.Theme.of(context).highlightColor,
          splashColor: mtr.Theme.of(context).splashColor,
          radius: mtr.Material.defaultSplashRadius,
          onTap: () => onTap(),
        )
    );
  }

  // returns the padding after adjusting the top and bottom
  getPadding() {
    return mtr.EdgeInsets.fromLTRB(
        0.0, (56-iconSize)/2, 0.0, (56-iconSize)/2
    );
  }
}

