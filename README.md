# Poker Hand

The PokerHand class is written in Ruby. It takes in a hand of cards consisting of an array of strings and can tell you the hand's rank.

```ruby
hand = PokerHand.new(["Ah", "Ad", "2s", "2c", "As"])
hand.rank
# => "Full House"

hand = PokerHand.new(["Ah", "As", "10c", "7d", "6s"])
hand.rank
# => "Pair of Aces"

hand = PokerHand.new(["Kh", "Kc", "3s", "3h", "2d"])
hand.rank
# => "Two Pair"

hand = PokerHand.new(["Kh", "Qh", "6h", "2h", "9h"])
hand.rank
# => "Flush"
```

The code checks for valid input type (it must be an array of strings), hand size (5 cards), valid cards
(the first part of the string represents the card value and the second represents the suit), and uniqueness 
of cards (you can't have a hand with two or more of the same card).

Testing is done with MiniTest. There are 21 passing tests which can be run in the terminal:
```
$ ruby poker_hand_test.rb
```
