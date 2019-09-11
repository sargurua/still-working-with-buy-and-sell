def update_prices
    response_string = RestClient.get('https://api.nomics.com/v1/currencies/ticker?key=879800e3c81677c7f61fa01735a96e2e&ids=BTC,ETH,XRP,BCH,LTC&interval=1d,30d&convert=USD')
    response_hash = JSON.parse(response_string)
    Currency.all.each do |db_currency|
        response_hash.each do |currency|
            if currency["name"] == db_currency.name
                db_currency.price = currency["price"]
                db_currency.save
            end
        end
    end
end

def find_by_name(name)
    update_prices
    currency_obj = Currency.all.find_all{|currency| currency.name == name}
    show_price(currency_obj)
end

def show_price(currency_obj)
    currency_obj.each do |currency|
        puts "#{currency.name} : $#{currency.price.round(2)}"
    end
end

def welcome
    prompt = TTY::Prompt.new
    update_prices
    puts "Welcome to Cryptocurrency Simulator"
    puts "*" * 30
    have_account = prompt.select("Do you have an account already?") do |menu|
        menu.choice 'Sign In', "Sign-In"
        menu.choice 'Create New Account', "New Account"
    end
    puts have_account
    if have_account == "Sign-In"
        sign_in
    else
        create_account
    end
end


def sign_in
    puts "Enter your username"
    i = gets.chomp
    if (User.all.find_by{|user| user.name = name})
end
end

def create_account
end