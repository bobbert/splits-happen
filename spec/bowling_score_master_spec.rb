require 'bowling_score_master'

RSpec.describe BowlingScoreMaster do

  it 'should score all-zero frames as zero' do
    zero_game = ('-' * 20)
    expect(BowlingScoreMaster.score(zero_game)).to eq 0
  end

  it 'should score all-nine frames as ninety' do
    flat_game = ('9-' * 10)
    expect(BowlingScoreMaster.score(flat_game)).to eq 90
  end

end
