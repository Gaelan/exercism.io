class Cohort
  def self.for(user)
    new(user)
  end

  attr_reader :user
  def initialize(user)
    @user = user
  end

  def users
    members | managers
  end

  def members
    @members ||= compute :members
  end

  def managers
    @managers ||= compute :managers
  end

  def sees(exercise)
    managers + members.select do |member|
      sees?(member, exercise)
    end
  end

  private

  def sees?(member, exercise)
    member.completed?(exercise) || member.working_on?(exercise)
  end

  def compute(type)
    result = Set.new
    user.teams.each do |team|
      result += team.send type
    end
    result.delete user
  end
end
