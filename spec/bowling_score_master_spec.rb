require 'bowling_score_master'

RSpec.describe BowlingScoreMaster do

  it 'should score all-zero frames as zero' do
    zero_game = ('-' * 20)
    expect(BowlingScoreMaster.new.score(zero_game)).to eq 0
  end

  it 'should score all-nine frames as ninety' do
    flat_game = ('9-' * 10)
    expect(BowlingScoreMaster.new.score(flat_game)).to eq 90
  end

  it 'should score ten spares with all fives on spare as one hundred fifty' do
    all_spare_game = ('5/' * 10) + '5'
    expect(BowlingScoreMaster.new.score(all_spare_game)).to eq 150
  end

  it 'should score a perfect game correctly as three hundred' do
    perfect_game = ('X' * 12)
    expect(BowlingScoreMaster.new.score(perfect_game)).to eq 300
  end

  it 'should score an almost-perfect game with nine in the tenth frame as two hundred seventy-nine' do
    almost_perfect_game = ('X' * 9) + '9/X'
    expect(BowlingScoreMaster.new.score(almost_perfect_game)).to eq 279
  end

  it 'should score "X7/9-X-88/-6XXX81" as one hundred sixty-seven as per example test cases' do
    sample_game = 'X7/9-X-88/-6XXX81'
    expect(BowlingScoreMaster.new.score(sample_game)).to eq 167
  end

end
