class SearchController < ApplicationController
    def search
        puts "ENtered the search"
        puts MessageIndex.search('CHANGES').records
        query = MessageIndex.search(params[:query].to_s)
        puts query 

        @results = query.records
        @total_results = query.total_entries
        render json: @results
      end
end

