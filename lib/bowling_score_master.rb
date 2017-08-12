class BowlingScoreMaster

  SCORE_REGEX = /^[1-9X\/\-]+$/

  # validation isn't required but it's here for peace of mind.
  INVALID_FORMAT_MSG = 'Invalid score string -- must contain only digits 1-9, ' +
        '- (zero), / (spare), or X (strike).'


  def score(score_string)
    raise INVALID_FORMAT_MSG unless SCORE_REGEX.match(score_string)
    parse_frames(score_string)
    (0..9).map {|n| score_by_frame(n) }.reduce(0, :+)
  end

private

  def parse_frames(score_string)
    @frames = []
    all_balls = score_string.split(//)
    10.times {|n| @frames.push(parse_single_frame(all_balls)) }

    # handle bonus balls at end of game, where bonus ball count
    # equals (3 - <balls_rolled_in_frame_10>)
    if raw_score_by_frame(9) == 10
      @frames[10] = parse_single_frame(all_balls)
      if raw_score_by_frame(10) == 10
        @frames[11] = parse_single_frame(all_balls)
      end
    end
  end

  def parse_single_frame(all_balls)
    ball1 = score_by_ball(all_balls.shift)
    if ball1 == 10
      return [10]
    elsif all_balls.count > 0
      ball2 = score_by_ball(all_balls.shift, ball1)
      return [ball1, ball2]
    else # 10th frame bonus balls edge case
      return [ball1]
    end
  end

  def score_by_ball(single_ball, previous_ball_score = 0)
    case single_ball
    when '1'..'9' then return single_ball.to_i
    when '-'      then return 0
    when 'X'      then return 10
    when '/'      then return (10 - previous_ball_score)
    end
  end

  def score_by_frame(frame_index)
    if mark?(frame_index)
      ball_count = @frames[frame_index].count
      return 10 + score_on_extra_balls(frame_index, (3 - ball_count))
    else
      return raw_score_by_frame(frame_index)
    end
  end

  def score_on_extra_balls(frame_index, num_balls)
    extra_balls = []
    extra_frame_count = 1
    while extra_balls.count < num_balls
      extra_balls.concat @frames[frame_index + extra_frame_count]
      extra_frame_count += 1
    end
    extra_balls.slice(0, num_balls).reduce(0, :+)
  end

  def raw_score_by_frame(frame_index)
    @frames[frame_index].reduce(0, :+)
  end

  def num_extra_balls(frame_index)
    if mark?(frame_index)
      return (3 - @frames[frame_index].count)
    else
      return 0
    end
  end

  def mark?(frame_index)
    raw_score = raw_score_by_frame(frame_index)
    return (raw_score >= 10)
  end


end
