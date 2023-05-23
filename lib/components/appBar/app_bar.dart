import 'package:flutter/material.dart';
import 'package:pokedex/components/radioList/radio_list.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final ImageProvider<Object> image;
  final int selectedValue;
  final Function(String) onSearch;
  final Function(int) onSort;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.image,
    required this.selectedValue,
    required this.onSearch,
    required this.onSort,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: Image(
        image: image,
        width: 50,
        height: 50,
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(20),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Pesquisar, nome ou numero...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                  ),
                  onChanged: (value) {
                    onSearch(value);
                  },
                ),
              ),
              FloatingActionButton(
                onPressed: () {
                  showPopover(context);
                },
                backgroundColor: Colors.white,
                mini: true,
                child: Image.asset(
                  (selectedValue == 1
                      ? 'lib/assets/filter_icon_number.png'
                      : 'lib/assets/filter_icon.png'),
                  width: 24,
                  height: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showPopover(BuildContext context) {
    final RenderBox appBarRenderBox = context.findRenderObject() as RenderBox;
    const buttonSize = kToolbarHeight - 50.0;

    final buttonTopLeft = Offset(
      appBarRenderBox.size.width - buttonSize,
      (appBarRenderBox.size.height - buttonSize) / 2,
    );
    final buttonBottomRight = Offset(
      appBarRenderBox.size.width,
      (appBarRenderBox.size.height + buttonSize) / 2,
    );

    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    showMenu(
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromPoints(
          appBarRenderBox.localToGlobal(buttonTopLeft, ancestor: overlay),
          appBarRenderBox.localToGlobal(buttonBottomRight, ancestor: overlay),
        ),
        Offset.zero & overlay.size,
      ),
      items: [
        PopupMenuItem(
          child: RadioList(
            onItemSelected: onSort,
          ),
        ),
      ],
      elevation: 8,
      color: Colors.red,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 80);
}
