import 'dart:async';
import 'dart:math';

import 'event.dart';

class EventRepository {
  // StreamController, um Events in Echtzeit zu verwalten
  final StreamController<Event> _controller = StreamController<Event>();

  EventRepository() {
    // Startet die Generierung von Events, sobald ein Repository erstellt wird
    _startGeneratingEvents();
  }

  // Öffentlicher Stream, auf den andere Klassen lauschen können
  Stream<Event> get events => _controller.stream;

  // Methode, um die kontinuierliche Generierung von Events zu starten
  void _startGeneratingEvents() {
    // Timer, der alle 3 Sekunden ein neues Event erzeugt
    Timer.periodic(const Duration(seconds: 3), (timer) {
      // Erstelle ein neues Event mit zufälligem Text und aktuellem Zeitstempel
      final event = Event(
        text: _generateRandomEvent(),
        timestamp: DateTime.now(),
      );
      // Sende das Event an den Stream
      _controller.add(event);
    });
  }

  // Methode, die zufällig ein Event aus einer Liste auswählt
  String _generateRandomEvent() {
    final events = [
      "Tor für Team A!",
      "Gelbe Karte für Spieler B",
      "Eckball für Team A",
      "Freistoß für Team B",
      "Auswechslung bei Team A",
      "Abpfiff - Halbzeit",
    ];
    final Random random = Random();
    return events[random.nextInt(events.length)];
  }

  // Schließt den StreamController, um Speicherlecks zu vermeiden
  void dispose() {
    _controller.close();
  }
}
