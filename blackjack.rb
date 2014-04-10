suits = ['Spades', 'Hearts', 'Diamonds', 'Clubs']
@face_value = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
# deck = suits.product(@face_value)
@deck = []
suits.each do |sut|
	@face_value.each do |card|
		@deck << [sut, card]
	end
end


@player_card = []
@dealer_card = []
@player_val_choice = 0
@first_hand = []
@second_hand = []
@card_a = []
@card_b = []
@player_answer = ' '
def shuffel some_arr
	rand_indx = 0
	temp = []
	return some_arr if some_arr.length <= 1

	#loop from 0 - length of the the array
	for i in 0..(some_arr.length - 1)
		
	  # Generate a random number between 0 and i 
		rand_indx = rand(0..i)
		
		# swap i with the location of that random number. 
		temp = some_arr[i]
		some_arr[i] = some_arr[rand_indx]
		some_arr[rand_indx] = temp	
	end
	some_arr
end
@shuffled_deck = shuffel @deck

def get_value(sm_card)
	# while sm_card[1] != 'A'
		if sm_card[1]    == '2'
			card_value = 2
		elsif sm_card[1] == '3'
			card_value = 3
		elsif sm_card[1] == '4'
			card_value = 4
		elsif sm_card[1] == '5'
			card_value = 5
		elsif sm_card[1] == '6'
			card_value = 6
		elsif sm_card[1] == '7'
			card_value = 7
		elsif sm_card[1] == '8'
			card_value = 8
		elsif sm_card[1] == '9'
			card_value = 9
		elsif sm_card[1] == '10'
			card_value = 10
		elsif sm_card[1] == 'J'
			card_value = 10
		elsif sm_card[1] == 'Q'
			card_value = 10
		elsif sm_card[1] == 'K'
			card_value = 10
		elsif sm_card[1] == 'A' && 
			check_total_value(sm_card) <=10
			card_value = 11 #get_value_A(sm_card)
		else
			card_value = 1
		end
		card_value
	# end
end

def hit 
  hits = @shuffled_deck.pop
	hits
end


# puts get_value hit
@player_card << hit
@dealer_card << hit
@player_card << hit
@dealer_card << hit

def check_total_value card_arr
	sum = 0
	card_arr.each do |x|
		sum += get_value x 
	end
	sum
end


def end_of_game player_card 

		if check_total_value(player_card) == 21 && check_total_value(@dealer_card) == 21 || check_total_value(@dealer_card) > 21 && check_total_value(player_card) > 21 ||
			check_total_value(@dealer_card) == check_total_value(player_card)
	  	puts "It's a tie!"
	  	puts "The player total points is:  #{check_total_value(player_card)}"
	  	puts "The dealers total points is:  #{check_total_value(@dealer_card)}"
	  	puts
	  	puts "Player final Cards: #{player_card.inspect}"
			puts "Dealer final Cards: #{@dealer_card.inspect}"

		elsif check_total_value(player_card) == 21 && check_total_value(@dealer_card) < 21 &&
			@player_answer == 'stay'
			puts "Blackjack!!"
			puts "The player total points is: #{check_total_value(player_card)}"
			puts "The dealers total points is:  #{check_total_value(@dealer_card)}"
			puts
			puts "Player final Cards: #{player_card.inspect}"
			puts "Dealer final Cards: #{@dealer_card.inspect}"
			
	  elsif check_total_value(@dealer_card) > check_total_value(player_card) &&
	  	check_total_value(@dealer_card) <= 21 
	  	puts "End of game. You lost."
	  	puts "The player total points is:  #{check_total_value(player_card)}"
	  	puts "The dealers total points is: #{check_total_value(@dealer_card)}"
	  	puts
	  	puts "Player final Cards: #{player_card.inspect}"
			puts "Dealer final Cards: #{@dealer_card.inspect}"
	  	
	  elsif check_total_value(player_card) > check_total_value(@dealer_card) &&
	  	check_total_value(player_card) <= 21 
	  	puts "Player wins!!"
	  	puts "The player total points is:  #{check_total_value(player_card)}"
	  	puts "The dealers total points is: #{check_total_value(@dealer_card)}"
	  	puts
	  	puts "Player final Cards: #{player_card.inspect}"
			puts "Dealer final Cards: #{@dealer_card.inspect}"
			

		elsif check_total_value(player_card) > 21 && check_total_value(@dealer_card) <= 21
			puts "Busts. You lost."
			puts "The player total point is: #{check_total_value(player_card)}"
			puts "The dealers total points is:  #{check_total_value(@dealer_card)}"
			puts
			puts "Player final Cards: #{player_card.inspect}"
			puts "Dealer final Cards: #{@dealer_card.inspect}"
			
	  elsif check_total_value(@dealer_card) > 21 && check_total_value(player_card) <= 21
			puts "Player wins!!"
			puts "The player total points is: #{check_total_value(player_card)}"
			puts "The dealers total points is:  #{check_total_value(@dealer_card)}"
			puts
	 		puts "Player final Cards: #{player_card.inspect}"
			puts "Dealer final Cards: #{@dealer_card.inspect}"
			
		end
	
end



def get_player_opt
	@player_answer= gets.downcase.chomp
	
	while check_total_value(@player_card) < 21 &&
		check_total_value(@player_card) != 21
		if @player_answer == 'hit'
			@player_card << hit
			puts @player_card.inspect
			puts @dealer_card.inspect
     #  puts "This is player total #{check_total_value(@player_card)}"
	    # puts "This is dealer total #{check_total_value(@dealer_card)}"
      puts "Your options: 'Hit', 'Stay', or 'Quit' : to exit."
			print "> "
			@player_answer= gets.downcase.chomp
		elsif @player_answer == 'stay'
			until check_total_value(@dealer_card) >= 17
	    	@dealer_card << hit
		  end
		  end_of_game @player_card
		  break
		elsif @player_answer == 'split'
			until check_total_value(@dealer_card) >= 17
	    	@dealer_card << hit
			end
			split_card 
			break
		elsif @player_answer == 'quit'
			exit
		else
			puts "'#{@player_answer}' is not an options?"
			puts "Your options: 'Hit', 'Stay', or 'Quit' : to exit."
			print "> "
			puts get_player_opt
		end
	end
	end_of_game @player_card
end

def init_opt
		@player_card.each do 
		@card_a  = @player_card[0]
		@card_b  = @player_card[1]
		if @card_a[1] == @card_b[1] 
			puts "what would you like to do?"
			puts "Your options: 'Hit', 'Stay', 'Split' or 'Quit' : to exit."
			print "> "
			break
		else
			puts "what would you like to do?"
			puts "Your options: 'Hit', 'Stay', or 'Quit' : to exit."
			print "> "
			break
		end
	end
	# puts @second_hand[1]
	get_player_opt
end

def split_card 
		@player_card.each do
		  @card_a  = @player_card[0]
			@card_b  = @player_card[1]
			if @card_a[1] == @card_b[1] 
		  	@first_hand << @player_card[0]
			  @second_hand << @player_card[1]
				@first_hand << hit
				@second_hand << hit
				puts "This is your first hand #{@first_hand.inspect}"
				puts "This is your second hand #{@second_hand.inspect}"
		 	  break
			else
				puts "'#{@player_answer}' is not an options?"
				puts "Your options: 'Hit', 'Stay', or 'Quit' : to exit."
				print "> "
				puts get_player_opt
				break
			end
		end
puts 
puts "First hand result:"
end_of_game(@first_hand)
puts 
puts "Second hand result:"
end_of_game(@second_hand)
# puts @first_hand.inspect 
# puts @second_hand.inspect 
exit
end


welcome = "Welcome To Blackjack"
puts welcome.center(65)	
puts 'Ace will be count as 1 if your total cards value is'
puts ' greater than 10. Else, it will be count as 11.'
puts 'Split option is available and will show up as an option'
puts " when your initial two cards string values are identical. "
puts " Example: 'A' =='A', 'K'=='K', and '8'=='8'."
puts
puts "Player Cards: #{@player_card.inspect}"
puts "Dealer Cards: #{@dealer_card.inspect}"
init_opt #get_player_opt



