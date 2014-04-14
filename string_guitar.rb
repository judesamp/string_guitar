class GuitarStringer
  attr_reader :guitar, :current_stores
  attr_accessor :new_strings, :tuner, :polish, :pliers, :cloth
  def initialize
    @guitar = Guitar.new
    @pliers
    @polish
    @cloth
    @new_strings = 0
    @tuner
    @current_stores = [] 
  end

  def check_for_bad_strings
    bad_strings = []
    @guitar.strings.each do |string, condition|
      bad_strings << string if condition == "bad"
    end
    bad_strings
  end

  def new_string_supply
    @new_strings
  end

  def go_to_new_store
    new_store = Store.new
    @current_stores << new_store
    new_store
  end

  def check_stores_for_strings
    while @current_stores.empty?
      go_to_new_store
    end
    current_store = @current_stores.find { |store| store.new_strings > 0 }
    while current_store_has_no_strings?(current_store)
      go_to_new_store
      current_store = @current_stores.find { |store| store.new_strings > 0 }
    end
    current_store
  end

  def buy_new_strings?
    new_string_supply < 3
  end

  def buy_strings
    if @new_strings.nil?
      @new_strings = 1
    else
      @new_strings += 1
    end
  end

  def string_guitar
    if @new_strings >= 1
      open_and_use_set_of_new_strings
      guitar.strings.each do |string, condition|
        guitar.strings[string] = "good"
      end
      return self.guitar.strings
    else
      return "You don't have any new strings!"
    end
  end

  def open_and_use_set_of_new_strings
    @new_strings -= 1
  end

  def current_store_has_no_strings?(current_store)
    current_store.nil?
  end

  def look_for_tuner
    self.tuner = true
  end

  def look_for_polish
    self.polish = true
  end

   def look_for_pliers
    self.pliers = true
  end

  def look_for_cloth
    self.cloth = true
  end
end

class Guitar
  attr_reader :pegs
  attr_accessor :strings

  def initialize
    @strings = {e: nil, a: nil, d: nil, g: nil, b: nil, :E => nil}
    @pegs = ["e", "a", "d", "g", "b", "E"]
  end

  def set_string_condition(string_data)
    strings[string_data[:string]] = string_data[:condition]
  end
end

class Store
  attr_reader :new_strings

  def initialize
    @new_strings = generate_random_supply_of_new_strings
  end

  def generate_random_supply_of_new_strings
    rand(0..4)
  end

  #resupply strings

end

