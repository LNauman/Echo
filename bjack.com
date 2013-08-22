#!/usr/bin/env ruby
# encoding: UTF-8


# build deck
SUITS = ['♠', '♣', '♥', '♦']
VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
@player_cards = []
@dealer_cards = []
@player_busted = false
@dealer_busted = false

def build_deck
  @deck = []
  SUITS.each do |suit|
    VALUES.each do |value|
      @deck.push(value + suit)
    end
  end
  @deck = @deck.shuffle
end

def deal_player
  @player_cards = [@deck.pop, @deck.pop]
  puts "Player has #{@player_cards[0]} and #{@player_cards[1]}"
  puts "Player score is " + score(@player_cards).to_s
end

def deal_dealer
  @dealer_cards = [@deck.pop, @deck.pop]
  puts
  puts "Dealer has #{@dealer_cards[0]} and #{@dealer_cards[1]}"
  puts "Dealer score is " + score(@dealer_cards).to_s
end



def score(cards)
  total = 0
  ace_bonus = 0
  cards.each do |card|
    total += get_value(card.chop).to_i
    if card.chop == 'A' && total < 10
      # puts "Ace found"
      ace_bonus = 10
    end
  end
  return total + ace_bonus
end


def get_value(card)
  case
  when ["J", "Q", "K"].include?(card)
    return 10
  when card == "A"
    return 1
  else
    return card
  end
end

def draw_a_card_player
  @player_cards << @deck.pop
  puts "Player draws #{@player_cards[-1]}"
  puts "Player score is " + score(@player_cards).to_s
  if score(@player_cards).to_s = 21

end

def draw_a_card_dealer
  @dealer_cards << @deck.pop
  puts "Dealer draws #{@dealer_cards[-1]}"
  puts "Dealer score is " + score(@dealer_cards).to_s
end

def hit_or_stand_player
  while true
    print "Hit or stand [H/S]: "
    input = gets.chomp.downcase
    case
    when input == 'h'
      draw_a_card_player
      if score(@player_cards) > 21
        puts "Player busted!"
        @player_busted = true
        break
      end
    when input == 's'
      return false
      break
    end
  end
end

def hit_or_stand_dealer
  if score(@dealer_cards) < 17
    puts "Dealer score is less than 17"

    puts "Dealer draws another card"
    draw_a_card_dealer
  end

  if score(@dealer_cards) > 21
    puts "Dealer busted!"
    @dealer_busted = true
  end


  while @dealer_busted == false
    print "Hit or stand [H/S]: "
    input = gets.chomp.downcase
    case
    when input == 'h'
      draw_a_card_dealer

      if score(@dealer_cards) > 21
        puts "Dealer busted!"
        @dealer_busted = true
        break
      end
    when input == 's'
      return true
      break
    end
  end
end


def pick_winner(player, dealer)
 if !@dealer_busted && !@player_busted
   case
    when player > dealer
      puts "The player won!"
    when player < dealer
      puts "The dealer won!"
    when player == dealer
      puts "It is a tie"
    end
  elsif @dealer_busted && !@player_busted
    puts "The player won!"
  elsif !@dealer_busted && @player_busted
    puts "The dealer won!"
  else
    puts "Game over"
  end
end



build_deck
deal_player
hit_or_stand_player
deal_dealer
hit_or_stand_dealer
pick_winner(score(@player_cards), score(@dealer_cards))


