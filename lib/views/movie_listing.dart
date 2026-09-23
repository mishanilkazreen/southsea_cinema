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
  int _adultQuantity = 0;

  void _ticketsPopup() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
          Text('$_adultQuantity adult tickets added to order')));
  }

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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16.0,
              children: [
                // Movie Title
                const Text(
                  'Interstellar (2014) (PG-13)',
                  style: TextStyle(
                    color: cinemaFontWhite,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Movie Description
                const Text(
                  'When Earth becomes uninhabitable in the future, a farmer and ex-NASA pilot, Joseph Cooper, is tasked to pilot a spacecraft, along with a team of researchers, to find a new planet for humans.',
                  style: TextStyle(color: cinemaFontWhite),
                ),
                // Booking Information
                const Text(
                  'Southsea Cinema Room\nWednesday 23rd Sep 2026, 18:00 - ends at 19:54',
                  style: TextStyle(color: cinemaFontWhite),
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
                        const Text(
                          "Adults (£7.50)",
                          style: TextStyle(color: cinemaFontWhite),
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
