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
  String _feedbackMessage = ''; // TO-DO: Convert to a Popup Notification

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
          spacing: 16.0,
          children: [
            Text(
              'Interstellar (2014) (PG-13)',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const Text(
              'When Earth becomes uninhabitable in the future, a farmer and ex-NASA pilot, Joseph Cooper, is tasked to pilot a spacecraft, along with a team of researchers, to find a new planet for humans.'
              ),
            const Text('Southsea Cinema Room\nWednesday 23rd Sep 2026, 18:00 - ends at 19:54'),
            const Text('Please note that Discounts / Membership Benefits will be applied once you have selected your tickets\nSelect Quantities (Up to 5 in total)'),
            Text(
              'Tickets',
              style: Theme.of(context).textTheme.headlineSmall
            ),
            Row(
              spacing: 16.0,
              children: [
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
                ),
                const Text("Adults (£7.50)")
              ],
            ),
            ElevatedButton(
              // TO-DO: Convert to a Popup Notification
              onPressed: () { 
                setState(() {
                  _feedbackMessage = '$_quantity tickets added to order';
                });
              },
              child: const Text('ADD TO ORDER')
            ),
            Text(_feedbackMessage), // TO-DO: Convert to a Popup Notification
          ],
        )
      )
    );
  }
}
