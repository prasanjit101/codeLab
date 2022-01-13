function leap_it()
    year = parse(Int64, (Base.prompt("Enter the year : ")))
    if (year % 4) == 0
        println("$year is a leap year...")
    else
        year_left = 4 - (year % 4)
        println("$year is not a leap year, you will have to wait $year_left year...")
    end
end

leap_it()