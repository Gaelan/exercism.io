require 'api/stats/nitpicks_sql'
require 'api/stats/streak_type'

module Api
  module Stats
    module NitStreak
      extend StreakType
      private
      SQL = NitpicksSQL
    end
  end
end
