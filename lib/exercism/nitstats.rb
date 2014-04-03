class Nitstats
  def initialize(user)
    @user = user
  end

  def data
    {
      labels: labels,
      given: given,
      received: received,
      steps: steps,
      step: step
    }
  end

  private

  def labels
    (from..to).map { |d| d.strftime("%b %e").squeeze(" ") }
  end

  def given
    nitpicks(given: true, recieved: false)
  end

  def received
    nitpicks(given: false, recieved: true)
  end

  def nitpicks(given:, recieved:)
    given_condition = given ? "=" : "!="
    recieved_condition = recieved ? "=" : "!="
    sql = "select date(c.created_at) as date, count(1) as count
           from comments c, submissions s
           where c.user_id #{given_condition} #{user.id}
           and c.submission_id = s.id
           and s.user_id #{recieved_condition} #{user.id}
           group by date(c.created_at) order by date(c.created_at)"
    extract_stat Submission.connection.execute(sql)
  end

  def from
    to - 29
  end

  def to
    Time.now.utc.to_date
  end

  def max
    [received.max, given.max].max
  end

  def steps
    max / step
  end

  def step
    [max / 15, 1].max
  end

  attr_reader :user

  def extract_stat(results)
    results = results.reduce({}) { |acc, r| acc.merge(r["date"] => r["count"]) }
    (from..to).map { |d| results[d.to_s].to_i }
  end

end
