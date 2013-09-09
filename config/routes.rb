Rglossa::Engine.routes.draw do

  namespace :r do
    namespace :search_engines do
      match 'cwb/query_freq', to: 'cwb#query_freq'
    end
  end
end
