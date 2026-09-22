import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class MovieListing extends StatefulWidget {
  const MovieListing({super.key});

  @override
  State<MovieListing> createState() {
    return _MovieListingState();
  }
}

class _MovieListingState extends State<MovieListing> {
  int _quantity = 0;

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle, style: cinemaHeaderStyle),
        backgroundColor: cinemaSurface,
        iconTheme: const IconThemeData(color: cinemaBrand),
        elevation: 0,
      ),
      drawer: const NavDrawer(),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: cinemaBrand),
          color: cinemaSurface
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Interstellar (2014) (PG-13)'),
            const SizedBox(height: 16.0),
            Text(
              'When Earth becomes uninhabitable in the future, a farmer and ex-NASA pilot, Joseph Cooper, is tasked to pilot a spacecraft, along with a team of researchers, to find a new planet for humans.'
              ),
            const SizedBox(height: 16.0),
            DropdownMenu<int>(
              initialSelection: 0,
              onSelected: (int? value) {
                if (value != null) {
                  setState(() {
                    _quantity = value;
                  });
                }
              },
              dropdownMenuEntries: [
                for (int i = 0; i <= 5; i++)
                  DropdownMenuEntry(value: i, label: '$i')
              ],
            )
          ],
        )
      )
    );
  }
}
