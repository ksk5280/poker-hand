class PokerHand
  attr_reader :hand, :value_count, :suit_count

  CARDS = {
    1 => "Aces",
    2 => "Twos",
    3 => "Threes",
    4 => "Fours",
    5 => "Fives",
    6 => "Sixes",
    7 => "Sevens",
    8 => "Eights",
    9 => "Nines",
    10 => "Tens",
    11 => "Jacks",
    12 => "Queens",
    13 => "Kings"
  }

  def initialize(hand)
    @hand = hand
    raise ArgumentError.new("Hand must be an array of strings") unless valid_input_type?
    @value_count = card_values.values
    @suit_count = card_suits.values
    check_hand_validity
  end

  def check_hand_validity
    raise ArgumentError.new("Hand must be 5 cards") unless hand.length == 5
    raise ArgumentError.new("One or more cards are invalid") unless valid_cards?
    raise ArgumentError.new("Cards cannot be identical") unless cards_unique?
  end

  def valid_input_type?
    hand.class == Array and hand.all? { |card| card.class == String }
  end

  def valid_cards?
    has_valid_values = !card_values.keys.include?(0)
    has_valid_suits = card_suits.keys.all? do |suit|
      ["h", "d", "s", "c"].include?(suit)
    end
    has_valid_values and has_valid_suits
  end

  def cards_unique?
    hand.each_with_object(Hash.new(0)) do |card, card_hash|
      card_hash[card] += 1
    end.values.count == 5
  end

  def rank
    return "Royal Flush" if straight_with_ace_high? and flush?
    return "Straight Flush" if straight? and flush?
    return "Four of a Kind" if value_count.include?(4)
    return "Full House" if value_count.include?(3) and value_count.include?(2)
    return "Flush" if flush?
    return "Straight" if straight?
    return "Three of a Kind" if value_count.include?(3)
    return "Two Pair" if value_count.grep(2).size == 2
    return "Pair of #{pair_string}" if pair_string
    "High Card"
  end

  def pair_string
    CARDS[card_values.key(2)]
  end

  def flush?
    suit_count.include?(5)
  end

  def straight?
    has_diff_cards = value_count.size == 5
    has_four_between_max_and_min = (card_values.keys.max - card_values.keys.min) == 4
    has_diff_cards and (has_four_between_max_and_min or straight_with_ace_high?)
  end

  def straight_with_ace_high?
    card_values.keys.sort == [1, 10, 11, 12, 13]
  end

  def card_values
    face_cards = {
      "A" => 1,
      "K" => 13,
      "Q" => 12,
      "J" => 11
    }
    hand.each_with_object(Hash.new(0)) do |card, card_values|
      card_value = card.chop
      is_face_card = face_cards.keys.include?(card_value.upcase)
      card_value_int = is_face_card ? face_cards[card_value.upcase] : card_value.to_i
      card_values[card_value_int] += 1
    end
  end

  def card_suits
    hand.each_with_object(Hash.new(0)) do |card, suits|
      suits[card[-1].downcase] += 1
    end
  end
end
