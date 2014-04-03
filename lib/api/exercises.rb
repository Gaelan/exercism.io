require 'api/exercises/homework'

class ExercismAPI < Sinatra::Base
  get '/exercises' do
    get_exercises :all
  end

  get '/exercises/current' do
    get_exercises :current
  end

  def get_exercises(type)
    require_user
    content_type 'application/json', :charset => 'utf-8'
    Homework.new(current_user).send(type).to_json
  end
end
