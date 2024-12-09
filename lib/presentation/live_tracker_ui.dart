import 'package:flutter/material.dart';
import 'package:football_live_ticker/data/event.dart';
import 'package:football_live_ticker/data/repository.dart';

class LiveTrackerScreen extends StatefulWidget {
  const LiveTrackerScreen({super.key});

  @override
  _LiveTrackerScreenState createState() => _LiveTrackerScreenState();
}

class _LiveTrackerScreenState extends State<LiveTrackerScreen> {
  // Instanz des EventRepository, das die Event-Daten generiert und bereitstellt
  final EventRepository eventRepository = EventRepository();

  // Liste zum Speichern der empfangenen Events für die Anzeige in der UI
  final List<Event> eventList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('⚽ Football Live Tracker'),
        backgroundColor: Colors.green.shade500,
      ),
      body: StreamBuilder<Event>(
        // Lauscht auf den Event-Stream vom EventRepository
        stream: eventRepository.events,
        builder: (context, snapshot) {
          // Wenn neue Daten im Stream verfügbar sind
          if (snapshot.hasData) {
            // Fügt das neue Event an den Anfang der Liste hinzu
            eventList.insert(0, snapshot.data!);
          }

          // Baut eine scrollbare Liste für die Events
          return ListView.builder(
            itemCount: eventList.length,
            itemBuilder: (context, index) {
              final event = eventList[index];
              // Ruft die Hilfsmethode auf, um eine Event-Card zu erstellen
              return _buildEventTile(event);
            },
          );
        },
      ),
    );
  }

  Widget _buildEventTile(Event event) {
    IconData eventIcon = Icons.info;
    Color eventColor = Colors.grey.shade600;

    if (event.text.contains("Tor")) {
      eventIcon = Icons.sports_soccer;
      eventColor = Colors.green.shade700;
    } else if (event.text.contains("Gelbe Karte")) {
      eventIcon = Icons.warning;
      eventColor = Colors.amber.shade800;
    } else if (event.text.contains("Freistoß")) {
      eventIcon = Icons.flag;
      eventColor = Colors.blue.shade600;
    } else if (event.text.contains("Eckball")) {
      eventIcon = Icons.near_me;
      eventColor = Colors.deepPurple.shade400;
    } else if (event.text.contains("Auswechslung")) {
      eventIcon = Icons.swap_horiz;
      eventColor = Colors.orange.shade600;
    }

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: eventColor,
          child: Icon(eventIcon, color: Colors.white),
        ),
        title: Text(
          event.text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          "Zeit: ${event.timestamp.hour}:${event.timestamp.minute}:${event.timestamp.second}",
          style: TextStyle(color: Colors.grey.shade600),
        ),
        trailing: Icon(Icons.arrow_forward, color: eventColor),
      ),
    );
  }

  @override
  void dispose() {
    eventRepository.dispose();
    super.dispose();
  }
}
