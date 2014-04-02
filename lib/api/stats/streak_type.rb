require 'api/stats/streak'

module Api
  module Stats
    module StreakType
      def self.for(username, year, month)
        user = User.find_by_username(username)
        data = SQL.new(user.id, year, month).execute
        Api::Stats::Streak.new(Exercism::Config.languages, data, year, month).to_h
      end
    end
  end
end
