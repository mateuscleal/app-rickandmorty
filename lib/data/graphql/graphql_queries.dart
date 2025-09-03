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
    query (\$name: String!) {
      episodes(filter: { name: \$name }) {
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
