class BowlingScoreMaster

  SCORE_REGEX = /^[1-9X\/\-]+$/

  # validation isn't required but it's here for peace of mind.
  INVALID_FORMAT_MSG = 'Invalid score string -- must contain only digits 1-9, ' +
        '- (zero), / (spare), or X (strike).'

  # metaclass -- treat all methods below as class methods
  # (i.e. use singleton pattern.  We don't really care about instances.)
  class << self

    def score(score_string)
      raise INVALID_FORMAT_MSG unless SCORE_REGEX.match(score_string)
      parse_frames(score_string).flatten.inject(0) {|val, sum| sum + val }
    end

  private

    def parse_frames(score_string)
      frames = []
      all_balls = score_string.split(//)
      10.times do |n|
        ball1 = score_by_ball(all_balls.shift)
        if ball1 == 10
          frames.push [10]
        else
          ball2 = score_by_ball(all_balls.shift, ball1)
          frames.push [ball1, ball2]
        end
      end
      return frames
    end

    def score_by_ball(single_ball, previous_ball_score = 0)
      case single_ball
      when '1'..'9' then return single_ball.to_i
      when '-'      then return 0
      when 'X'      then return 10
      when '/'      then return (10 - previous_ball_score)
      end
    end

  end

end
