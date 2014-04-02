require 'api/stats/submissions_sql'
require 'api/stats/streak'
require 'api/stats/streak_type'

module Api
  module Stats
    module SubmissionStreak
      extend StreakType
      private
      SQL = SubmissionsSQL
    end
  end
end
