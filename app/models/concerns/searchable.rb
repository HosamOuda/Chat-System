module Searchable
  extend ActiveSupport::Concern
 
  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
 
    def as_indexed_json(_options = {})
      as_json(only: %i[content sender])
    end
 
    settings settings_attributes do
      mappings dynamic: false do
        indexes :content, type: :text
        indexes :sender, type: :text
      end
    end
 
    def self.search(query, filters)
      set_filters = lambda do |context_type, filter|
        @search_definition[:query][:bool][context_type] |= [filter]
        puts"THE SEARCH DEFINITION IS #{@search_definition}"
      end
      puts "the parameters in search are #{query} and #{filters}"
      @search_definition = {
        size: 5,
        query: {
          bool: {
            must: [],
            should: [],
            filter: []
          }
        }
      }
 
      if query.blank?
        set_filters.call(:must, match_all: {})
      else
        set_filters.call(
          :must,
          match: {
            name: {
              query: query,
              fuzziness: 1
            }
          }
        )
      end
      puts "THE FILETERS CONTENT #{filters} and the filters send content is #{filters[:sender]}"
      if filters[:sender].present?
        set_filters.call(:filter, term: { sender: filters[:sender] })
      end
 
      __elasticsearch__.search(@search_definition)
    end
  end
 
  class_methods do
    def settings_attributes
      {
        index: {
          analysis: {
            analyzer: {
              autocomplete: {
                type: :custom,
                tokenizer: :standard,
                filter: %i[lowercase autocomplete]
              }
            },
            filter: {
              autocomplete: {
                type: :edge_ngram,
                min_gram: 2,
                max_gram: 25
              }
            }
          }
        }
      }
    end
  end
 end