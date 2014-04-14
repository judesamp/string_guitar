#add test for nil result on check_stores for strings just be sure

require 'rspec'
require './string_guitar'

describe Guitar do
  let( :guitar ) { Guitar.new }

  it "should have places for six strings" do
    expect(guitar.strings.length).to eq 6
  end

  it "should have no strings to start program" do
    guitar.strings.each do|key, value|
      value_to_check = value
      expect(value_to_check).to eq nil
    end
  end

  it "should have six pegs" do
    expect(guitar.pegs.length).to eq 6
  end

  it "should set the condition of strings to good or bad" do
    guitar.set_string_condition({string: :e, condition: "bad"})
    expect(guitar.strings[:e]).to eq "bad"
  end

end

describe GuitarStringer do
  let( :stringer ) { GuitarStringer.new }
  context "initialization" do

    it "should not have a pair of wire-cutting pliers before deciding to string guitar" do
      stringer.pliers.should be nil
    end

    it "should not have a new pair of strings before deciding to string guitar" do
      stringer.new_strings.should be 0
    end

    it "should not have a tuner before deciding to string guitar" do
      stringer.tuner.should be nil
    end

    it "should not have guitar polish before deciding to string guitar" do
      stringer.polish.should be nil
    end

     it "should not have a cloth before deciding to string guitar" do
      stringer.cloth.should be nil
    end

  end

  context "stringing the guitar" do

    it "should check strings to see if they need changing" do
      stringer.guitar.set_string_condition({string: :e, condition: "bad"})
      checked_strings = stringer.check_for_bad_strings
      checked_strings.length.should eq 1
    end

    it "should check supply of strings" do
      stringer.new_strings = 3
      string_supply = stringer.new_string_supply
      expect(string_supply).to eq 3
    end

    it "should decide to buy new strings if new string supply less than 3" do
      stringer.new_strings = 2
      decision = stringer.buy_new_strings?
      expect(decision).to eq true
    end

    it "should not decide to buy new strings if new string supply greater than 2" do
      stringer.new_strings = 3
      decision = stringer.buy_new_strings?
      expect(decision).to eq false
    end

    it "should check current stores for sets of new strings" do
      store = stringer.check_stores_for_strings
      expect(store.class).to eq Store
    end

     it "should go to a new store if current stores do not have strings" do
      store = stringer.check_stores_for_strings
      stringer.current_stores.should_not be_empty
    end

    it "should buy new strings" do
      stringer.buy_strings
      expect(stringer.new_strings).to eq 1
    end

    it "should put new strings on the guitar" do
      stringer.buy_strings
      stringer.guitar.set_string_condition({string: :e, condition: "bad"})
      stringer.string_guitar
      expect(stringer.check_for_bad_strings.length).to eq 0
    end

    it "should open and use a set of new strings to string guitar" do
      stringer.buy_strings
      stringer.open_and_use_set_of_new_strings
      expect(stringer.new_strings).to eq 0
    end

    it "should look for and find tuner" do
      stringer.look_for_tuner
      expect(stringer.tuner).to eq true
    end

    it "should look for and find polish" do
      stringer.look_for_polish
      expect(stringer.polish).to eq true
    end

    it "should check for and find pliers" do
      stringer.look_for_pliers
      expect(stringer.pliers).to eq true
    end

    it "should check for and find cloth" do
      stringer.look_for_cloth
      expect(stringer.cloth).to eq true
    end

    it "should string guitar" do
      stringer.guitar.set_string_condition({string: :e, condition: "bad"})
      stringer.buy_strings
      stringer.string_guitar
      expect(stringer.check_for_bad_strings.length).to eq 0
    end

    it "should not string guitar if there aren't any new strings" do
      string_guitar_attempt = stringer.string_guitar
      expect(string_guitar_attempt).to eq "You don't have any new strings!"
    end

  end

end

describe Store do
  let(:store) {Store.new}
  context "initialization" do
    
    it "should have a random number of new string sets, from 0 to 4" do
      store.new_strings.should_not be nil 
    end

  end

end