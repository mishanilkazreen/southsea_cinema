import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class MovieListing extends StatefulWidget {
  final Movie movie;

  const MovieListing({super.key, required this.movie});

  @override
  State<MovieListing> createState() {
    return _MovieListingState();
  }
}

class _MovieListingState extends State<MovieListing> {
  int _adultQuantity = 0;

  void _ticketsPopup() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
          Text('$_adultQuantity adult tickets added to order')));
  }

  @override
  Widget build(BuildContext context) {
    final Movie movie = widget.movie;
    final String price = (movie.ticketPrice / 100).toStringAsFixed(2);

    return Scaffold(
        appBar: AppBar(
          title: const Text(appTitle, style: cinemaHeaderStyle),
          backgroundColor: cinemaSurface,
          iconTheme: const IconThemeData(color: cinemaBrand),
          elevation: 0,
        ),
        drawer: const NavDrawer(),
        body: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16.0,
              children: [
                // Movie Title
                Text(
                  '${movie.name} (${movie.publishedYear}) (${movie.ageRating})',
                  style: const TextStyle(
                    color: cinemaFontWhite,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Movie Description
                Text(
                  movie.description,
                  style: const TextStyle(color: cinemaFontWhite),
                ),
                // Booking Information
                Text(
                  'Southsea Cinema Room\n${movie.screenings.join('\n')}',
                  style: const TextStyle(color: cinemaFontWhite),
                ),
                const Text(
                  'Please note that Discounts / Membership Benefits will be applied once you have selected your tickets\nSelect Quantities (Up to 5 in total)',
                  style: TextStyle(color: cinemaFontWhite),
                ),
                // Ticket Information
                const Text(
                  'Tickets',
                  style: TextStyle(
                    color: cinemaFontWhite,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final List<Widget> ticketBookingWidget = [
                        DropdownMenu<int>(
                          initialSelection: 0,
                          textStyle: const TextStyle(color: cinemaSurface),
                          inputDecorationTheme: const InputDecorationTheme(
                            filled: true,
                            fillColor: cinemaFontWhite
                          ),
                          onSelected: (int? value) {
                            if (value != null) {
                              setState(() {
                                _adultQuantity = value;
                              });
                            }
                          },
                          dropdownMenuEntries: [
                            for (int i = 0; i <= 5; i++)
                              DropdownMenuEntry(value: i, label: '$i')
                          ],
                        ),
                        Text(
                          'Adults (£$price)',
                          style: const TextStyle(color: cinemaFontWhite),
                        )
                    ];
                    
                    if (constraints.maxWidth > 260) {
                      return Row(
                        spacing: 16.0,
                        children: ticketBookingWidget
                      );
                    } else {
                      return Column(
                        spacing: 16.0,
                        children: ticketBookingWidget,
                      );
                    }
                  }
                ), 
                // Add to Order Button
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: cinemaBrandDark,
                      foregroundColor: cinemaFontWhite,
                    ),
                    onPressed: _ticketsPopup,
                    child: const Text('ADD TO ORDER')),
              ],
            )
        )
    );
  }
}
