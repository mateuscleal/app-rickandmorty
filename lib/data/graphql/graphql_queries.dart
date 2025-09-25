const Map<String, dynamic> queries = {
  'getEpisodesByIds': """
    query EpisodesByIds(\$ids: [ID!]!) {
      episodesByIds(ids: \$ids) {
        id
        name
        air_date
        episode
        characters {
          id
          name
          status
          species
          gender
          image
        }
      }
    }
  """,
  'getFilteredEpisodes': """
    query (\$name: String!, \$page: Int!) {
      episodes(page: \$page, filter: { name: \$name }) {
        info {
          count
          pages
          next
        }
        results {
          id
          name
          air_date
          episode
          characters {
            id
            name
            status
            species
            gender
            image
          }
        }
      }
    }
  """,
  'getLocations': """
    query {
      locations {
        results {
          id
          name,
          type,
          dimension,
          residents {
            id,
            name,
            image,
          }
        }
      }
    }
  """,
};

///Se necessário pode adicionar mais queries
