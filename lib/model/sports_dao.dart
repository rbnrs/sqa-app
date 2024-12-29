import 'package:flutter/material.dart';
import 'package:sqa/entities/sport_type.dart';

class SportsDao {
  List<SportType> getSportsTypes() {
    return [
      SportType(name: "football", icon: Icons.sports_soccer),
      SportType(name: "basketball", icon: Icons.sports_basketball),
      SportType(name: "volleyball", icon: Icons.sports_volleyball),
      SportType(name: "tennis", icon: Icons.sports_tennis),
      SportType(
          name: "badminton",
          icon:
              Icons.sports_tennis), // No specific badminton icon; using tennis
      SportType(
          name: "squash",
          icon: Icons.sports_tennis), // No squash icon; using tennis
      SportType(
          name: "table tennis",
          icon: Icons
              .sports_tennis), // Table tennis is not in Material Icons; using tennis
      SportType(name: "cricket", icon: Icons.sports_cricket),
      SportType(name: "rugby", icon: Icons.sports_rugby),
      SportType(name: "hockey", icon: Icons.sports_hockey),
      SportType(name: "ice hockey", icon: Icons.sports_hockey),
      SportType(name: "handball", icon: Icons.sports_handball),
      SportType(
          name: "water polo",
          icon: Icons.pool), // No specific icon; using pool icon
      SportType(name: "rowing", icon: Icons.rowing),
      SportType(
          name: "canoe sprint", icon: Icons.rowing), // No canoe-specific icon
      SportType(
          name: "dragon boat racing",
          icon: Icons.rowing), // No dragon boat icon; using rowing
      SportType(
          name: "cheerleading",
          icon: Icons
              .sports_gymnastics), // Assuming custom extension; replace if needed
      SportType(
          name: "dance",
          icon: Icons
              .directions_run), // No dance icon; using running as placeholder
      SportType(name: "relay racing", icon: Icons.run_circle),
      SportType(
          name: "gymnastics",
          icon: Icons.accessibility_new), // Placeholder for gymnastics
      SportType(name: "martial arts sparring", icon: Icons.sports_mma),
      SportType(name: "boxing", icon: Icons.sports_mma),
      SportType(
          name: "wrestling",
          icon: Icons.sports_mma), // Placeholder for wrestling
      SportType(
          name: "karate", icon: Icons.sports_mma), // Placeholder for karate
      SportType(
          name: "jiu-jitsu",
          icon: Icons.sports_mma), // Placeholder for jiu-jitsu
      SportType(
          name: "taekwondo sparring",
          icon: Icons.sports_mma), // Placeholder for taekwondo
      SportType(
          name: "fencing",
          icon: Icons.sports_esports), // Placeholder for fencing
      SportType(
          name: "archery", icon: Icons.architecture), // Placeholder for archery
      SportType(
          name: "paintball",
          icon: Icons.sports_kabaddi), // Placeholder for paintball
      SportType(
          name: "airsoft",
          icon: Icons.sports_kabaddi), // Placeholder for airsoft
      SportType(
          name: "ultimate frisbee",
          icon: Icons.sports_soccer), // Placeholder for frisbee
      SportType(name: "disc golf", icon: Icons.sports_golf),
      SportType(
          name: "kickball",
          icon: Icons.sports_baseball), // Placeholder for kickball
      SportType(
          name: "dodgeball",
          icon: Icons.sports_volleyball), // Placeholder for dodgeball
      SportType(
          name: "pickleball",
          icon: Icons.sports_tennis), // Placeholder for pickleball
      SportType(name: "softball", icon: Icons.sports_baseball),
      SportType(name: "baseball", icon: Icons.sports_baseball),
      SportType(name: "American football", icon: Icons.sports_football),
      SportType(name: "lacrosse", icon: Icons.sports),
      SportType(name: "paddle tennis", icon: Icons.sports_tennis),
      SportType(name: "paddleball", icon: Icons.sports_tennis),
      SportType(name: "beach volleyball", icon: Icons.sports_volleyball),
      SportType(name: "kite surfing", icon: Icons.surfing),
      SportType(name: "sailing", icon: Icons.sailing),
      SportType(
          name: "kart racing",
          icon: Icons.directions_car), // Placeholder for kart racing
      SportType(name: "eSports", icon: Icons.sports_esports),
      SportType(
          name: "tabletop RPGs",
          icon: Icons.table_chart), // Placeholder for tabletop RPGs
      SportType(name: "bowling", icon: Icons.sports),
      SportType(name: "curling", icon: Icons.sports), // Placeholder for curling
      SportType(
          name: "tug of war", icon: Icons.sports), // Placeholder for tug of war
      SportType(name: "track and field", icon: Icons.directions_run),
      SportType(
          name: "cross-country skiing",
          icon: Icons.snowboarding), // Placeholder for skiing
      SportType(name: "cycling", icon: Icons.directions_bike),
      SportType(name: "mountain biking", icon: Icons.directions_bike),
      SportType(
          name: "skating", icon: Icons.ice_skating), // Placeholder for skating
      SportType(name: "snowboarding", icon: Icons.snowboarding),
      SportType(name: "skiing", icon: Icons.downhill_skiing),
      SportType(name: "paragliding", icon: Icons.paragliding),
      SportType(
          name: "scuba diving",
          icon: Icons
              .scuba_diving), // Assuming custom extension; replace if needed
      SportType(name: "snorkeling", icon: Icons.pool),
      SportType(name: "rafting", icon: Icons.rowing),
      SportType(name: "hiking", icon: Icons.hiking),
      SportType(
          name: "climbing", icon: Icons.terrain), // Placeholder for climbing
      SportType(name: "adventure racing", icon: Icons.directions_run),
      SportType(name: "obstacle course racing", icon: Icons.directions_run),
      SportType(name: "triathlon", icon: Icons.run_circle),
      SportType(name: "golf", icon: Icons.sports_golf),
      SportType(name: "mini-golf", icon: Icons.sports_golf),
      SportType(
          name: "laser tag",
          icon: Icons.sports_esports), // Placeholder for laser tag
      SportType(
          name: "escape rooms",
          icon: Icons.vpn_key), // Placeholder for escape rooms
      SportType(name: "horse riding", icon: Icons.sports),
      SportType(name: "polo", icon: Icons.sports),
      SportType(name: "team swimming relays", icon: Icons.pool),
      SportType(
          name: "orienteering",
          icon: Icons.explore), // Placeholder for orienteering
      SportType(name: "treasure hunts", icon: Icons.explore),
      SportType(
          name: "trampoline dodgeball",
          icon:
              Icons.sports_volleyball), // Placeholder for trampoline dodgeball
      SportType(name: "drum corps", icon: Icons.music_note),
      SportType(name: "sled hockey", icon: Icons.sports_hockey),
      SportType(name: "canoe polo", icon: Icons.rowing),
      SportType(
          name: "bocce ball",
          icon: Icons.sports_baseball), // Placeholder for bocce ball
      SportType(
          name: "sepaktakraw",
          icon: Icons.sports_soccer), // Placeholder for sepaktakraw
      SportType(name: "kabaddi", icon: Icons.sports_kabaddi),
      SportType(
          name: "quidditch",
          icon: Icons.sports_soccer), // Placeholder for quidditch
      SportType(name: "speed skating relays", icon: Icons.ice_skating),
      SportType(name: "synchronized swimming", icon: Icons.pool)
    ];
  }
}
