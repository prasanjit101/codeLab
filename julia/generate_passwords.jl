# Generate Passwords in Julia
using Random
using ProgressBars

function generate_passwords()
    NumOfPasswords = parse(Int64, Base.prompt("Enter number of passwords you want to generate: "))
    password_length = parse(Int64, Base.prompt("Enter the length of the password : "))

    # empty  array
    password_list = []

    #  a progress bar to see how close we are to being done
    for i in ProgressBar(1:NumOfPasswords)
        push!(password_list, randstring(password_length))
        sleep(0.2) 
    end
    
    # Loop through each password one by one
    for password in password_list
        print("\n", password)
    end
end

generate_passwords()