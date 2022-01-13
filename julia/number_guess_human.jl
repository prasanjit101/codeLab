# Number Guessing Game in Julia

function play_number_guess_human()

    total_numbers = 25 

    target_number = rand(1:total_numbers)
    guess = 0

    # While the number has not been guessed, keep prompting the player to guess
    while guess != target_number
        print("Guess a number between 1 and $total_numbers: ")
        guess = parse(Int64, readline())
        # If we are within +/-3 of the target, give a hint
        if abs(target_number - guess) <= 3 && target_number != guess
            print("\nYou are close!\n")
        end
    end

    print("Great! you got it!")
end

play_number_guess_human()