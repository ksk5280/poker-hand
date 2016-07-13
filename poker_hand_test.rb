require_relative "poker_hand"
require "minitest/autorun"
require "minitest/pride"

class PokerHandTest < Minitest::Test
  def test_class_exists
    assert PokerHand
  end

  def test_ranks_flush
    hand = PokerHand.new(["Ah", "5h", "10h", "Kh", "3h"])
    assert_equal "Flush", hand.rank
  end

  def test_ranks_four_of_a_kind
    hand = PokerHand.new(["Ah", "2s", "Ad", "Ac", "As"])
    assert_equal "Four of a Kind", hand.rank
  end

  def test_ranks_full_house
    hand = PokerHand.new(["Ah", "Ad", "2s", "2c", "As"])
    assert_equal "Full House", hand.rank
  end

  def test_ranks_three_of_a_kind
    hand1 = PokerHand.new(["Ah", "2c", "As", "Ad", "5s"])
    hand2 = PokerHand.new(["4h", "4c", "Kc", "4d", "3s"])

    assert_equal "Three of a Kind", hand1.rank
    assert_equal "Three of a Kind", hand2.rank
  end

  def test_ranks_number_straight
    hand1 = PokerHand.new(["5d", "2h", "4d", "6h", "3s"])
    hand2 = PokerHand.new(["7h", "3d", "6c", "4s", "5h"])

    assert_equal "Straight", hand1.rank
    assert_equal "Straight", hand2.rank
  end

  def test_ranks_straight_with_face_cards
    hand = PokerHand.new(["Kh", "10d", "Qs", "9h", "Jd"])
    assert_equal "Straight", hand.rank
  end

  def test_ranks_straight_flush
    hand1 = PokerHand.new(["Qh", "9h", "Jh", "Kh", "10h"])
    hand2 = PokerHand.new(["9d", "6d", "10d", "8d", "7d"])

    assert_equal "Straight Flush", hand1.rank
    assert_equal "Straight Flush", hand2.rank
  end

  def test_ranks_royal_flush
    hand = PokerHand.new(["Qh", "10h", "Kh", "Jh", "Ah"])
    assert_equal "Royal Flush", hand.rank
  end

  def test_ranks_straight_ace
    high_ace_hand = PokerHand.new(["Kh", "10d", "Ad", "Jd", "Qs"])
    low_ace_hand = PokerHand.new(["3d", "2h", "As", "5d", "4d"])

    assert_equal "Straight", high_ace_hand.rank
    assert_equal "Straight", low_ace_hand.rank
  end

  def test_ranks_two_pair
    hand1 = PokerHand.new(["4d", "9c", "Ks", "9s", "Kd"])
    hand2 = PokerHand.new(["As", "5d", "Ad", "5h", "10d"])

    assert_equal "Two Pair", hand1.rank
    assert_equal "Two Pair", hand2.rank
  end

  def test_ranks_pair
    ace_hand = PokerHand.new(["Ah", "As", "10c", "7d", "6s"])
    king_hand = PokerHand.new(["Kh", "Ks", "10c", "7d", "6s"])

    assert_equal "Pair of Aces", ace_hand.rank
    assert_equal "Pair of Kings", king_hand.rank
  end

  def test_defaults_to_high_card
    hand = PokerHand.new(["2h", "8d", "Ks", "Qs", "4c"])
    assert_equal "High Card", hand.rank
  end

  def test_returns_high_card_for_non_sequential_straight
    hand = PokerHand.new(["2s", "Kh", "Ad", "3c", "Qs"])
    assert_equal "High Card", hand.rank
  end

  def test_argument_error_raised_if_hand_is_not_5_cards
    assert_raises ArgumentError do
      PokerHand.new(["5h", "6d", "Ac", "Kd", "3s", "9h"])
    end

    assert_raises ArgumentError do
      PokerHand.new(["Qh", "9d", "Jh", "5s"])
    end
  end

  def test_card_values_and_suit_must_be_in_right_order
    assert_raises ArgumentError do
      PokerHand.new(["h8", "d10", "sK", "c4", "dA"])
    end
  end

  def test_argument_error_raised_if_there_are_invalid_cards
    assert_raises ArgumentError do
      PokerHand.new(["3h", "4d", "9f", "10s", "Ks"])
    end

    assert_raises ArgumentError do
      PokerHand.new(["3h", "sd", "9c", "10s", "Ks"])
    end

    assert_raises ArgumentError do
      PokerHand.new(["ffdsa", "s24d", "9fgsd3", "13g0s", "2Ks"])
    end
  end

  def test_argument_error_raised_for_duplicate_cards
    assert_raises ArgumentError do
      PokerHand.new(["Ah", "5d", "9h", "Kc", "5d"])
    end
  end

  def test_argument_error_raised_for_invalid_input_type
    assert_raises ArgumentError do
      PokerHand.new("fdkjd")
    end
    assert_raises ArgumentError do
      PokerHand.new([12, 34, 45, 65, 76])
    end
  end

  def test_face_cards_are_case_insensitive
    hand = PokerHand.new(["as", "jd", "kh", "qs", "ac"])
    assert_equal "Pair of Aces", hand.rank
  end

  def test_suits_are_case_insensitive
    hand = PokerHand.new(["AS", "JD", "KH", "QS", "AC"])
    assert_equal "Pair of Aces", hand.rank
  end
end
