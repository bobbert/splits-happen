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

  it 'should score ten spares with all nine on spare as one hundred ninety' do
    all_spare_game = ('9/' * 10) + '9'
    expect(BowlingScoreMaster.new.score(all_spare_game)).to eq 190
  end
end
