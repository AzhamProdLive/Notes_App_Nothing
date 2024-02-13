
import 'package:app_client/blocs/notes_search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  SearchAppBar({super.key});

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var searchCubit = context.read<NotesSearchCubit>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: TextField(
          onSubmitted: (value) {
            if (value.isEmpty) {
            } else {
              searchCubit.getNoteByKeyword(value);
            }
          },
          autofocus: true,
          textInputAction: TextInputAction.search,
          controller: _controller,
          textAlignVertical: TextAlignVertical.bottom,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            suffixIcon: IconButton(
              splashRadius: 100,
              padding: const EdgeInsets.only(right: 20),
              onPressed: () => {
                _controller.clear,
                Navigator.pop(context),
              },
              icon: const Icon(Icons.close_rounded, color: Colors.white),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none),
            hintText: 'Search by the keyword...',
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(82.0);
}
