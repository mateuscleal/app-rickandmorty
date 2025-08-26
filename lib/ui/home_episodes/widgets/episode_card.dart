import 'package:app/ui/_core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/episode.dart';

class EpisodeCard extends StatelessWidget {
  const EpisodeCard({super.key, required this.episode, required this.markAsWatched, required this.markAsFavorite});

  final Episode episode;
  final Function(int id) markAsWatched;
  final Function(int id) markAsFavorite;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: NetworkImage(episode.imagePath),
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
        ),
        boxShadow: [BoxShadow(color: Colors.grey.shade800, spreadRadius: 1, blurRadius: 7, offset: Offset(0, 3))],
      ),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              height: 35,
              width: 65,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.backgroundCard,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade800,
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                episode.episodeName,
                style: TextStyle(fontSize: 14, height: 1.0, fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ),
          ),
          Visibility(
            visible: episode.isWatched,
            child: Container(
              height: 230,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  'Watched',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ),
          Container(
            height: 80,
            decoration: BoxDecoration(color: AppColors.backgroundCard, borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    episode.title,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    episode.date,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                  Text(
                    'Number of characters: ${episode.characters.length}',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PopupMenuButton(
                  iconColor: Colors.white,
                  color: AppColors.background,
                  menuPadding: EdgeInsets.zero,
                  offset: Offset(0, 5),
                  elevation: 4,
                  position: PopupMenuPosition.under,
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      onTap: () => markAsWatched(int.parse(episode.id) - 1),
                      child: Row(
                        spacing: 10,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            episode.isWatched ? 'Mark as Unwatched' : 'Mark as Watched',
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(
                            episode.isWatched ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 1,
                      onTap: () => markAsFavorite(int.parse(episode.id) - 1),
                      child: Row(
                        spacing: 10,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            episode.isFavorite ? 'Remove from Favorites' : 'Mark as Favorite',
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(
                            episode.isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                            color: episode.isFavorite ? Colors.red : Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
