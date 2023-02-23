from faker import Faker
import random
import os
import colorama
from colorama import Fore, Style

# Developer: SirCryptic (NullSecurityTeam)
# Info: Fake-Person Generator 1.0

ethnicities = ["African American", "Asian", "Hispanic", "Native American", "Pacific Islander", "White"]
superheroes = ["Spider-Man", "Iron Man", "Captain America", "Wonder Woman", "Superman", "Batman", "Black Panther", "Thor", "The Flash", "Aquaman"]

fake = Faker()
os.system('cls' if os.name == 'nt' else 'clear')
# initialize colorama
colorama.init()

banner = f'''
{Fore.BLUE} ____ ____ _  _ ____   ___  ____ ____ ____ ____ __ _
 |--- |--| |-:_ |===   |--' |=== |--< ==== [__] | \\|
   ____ ____ __ _ ____ ____ ____ ___ ____ ____      
   |__, |=== | \\| |=== |--< |--|  |  [__] |--<      
             Developer:{Fore.GREEN}SirCryptic{Style.RESET_ALL}'''

print(banner)

titles = [("Personal Information:", Fore.YELLOW), 
          ("Employment Information:", Fore.BLUE), 
          ("Educational Information:", Fore.CYAN), 
          ("Financial Information:", Fore.MAGENTA), 
          ("Favorites:", Fore.GREEN),
          ("Online Information:", Fore.RED)]

top_line = "-----------------------------------------------------------------"
bottom_line = "-----------------------------------------------------------------"

for title, color in titles:
    colored_top_line = f"{color}{top_line}{Style.RESET_ALL}"
    colored_title = f"{color}{title}{Style.RESET_ALL}"
    colored_bottom_line = f"{color}{bottom_line}{Style.RESET_ALL}"

    print(colored_top_line)
    print(colored_title)
    print(colored_bottom_line)

    # Personal Information
    if title == "Personal Information:":
        print('Name: ', fake.name())
        print('Date of Birth: ', fake.date_of_birth(minimum_age=18, maximum_age=65))
        print('Address: ', fake.address())
        print('City: ', fake.city())
        print('State: ', fake.state_abbr())
        print('Zip Code: ', fake.zipcode())
        print('Country: ', fake.country())
        print("Gender:", fake.random_element(elements=('Male', 'Female')))
        print("Ethnicity:", random.choice(ethnicities))
        print("Religion:", fake.random_element(elements=('Christianity', 'Islam', 'Judaism', 'Buddhism', 'Hinduism', 'Athiest')))
        print("Marital status:", fake.random_element(elements=('Single', 'Married', 'Divorced', 'Widowed')))
        print("Number of children:", fake.random_int(min=0, max=5))
        print("Parent's names:", fake.name() + " and " + fake.name())
        print("Nationality:", fake.country())
        print("Passport number:", fake.random_number(digits=9))
        print('Height: ', fake.random_int(min=150, max=200))
        print('Weight: ', fake.random_int(min=50, max=100))
        print('Blood Type: ', fake.random_element(elements=('A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-')))
        print('Social Security Number: ', fake.ssn())
        print('Favorite Color: ', fake.color_name())
        print('Hobby: ', fake.random_element(elements=('reading', 'swimming', 'traveling', 'cooking', 'painting')))
        print('Favorite Hobby: ', fake.random_element(elements=('reading', 'swimming', 'traveling', 'cooking', 'painting')))
        print('Phone Number: ', fake.phone_number())
    # Employment Information
    elif title == "Employment Information:":
        print("Work experience:", fake.random_int(min=0, max=30), "years")
        print("Work history:", fake.job())
        print("Job duties:", fake.bs())
        print("Salary:", fake.random_int(min=20000, max=1000000))
        print("Benefits:", fake.bs())
        print("Retirement plan:", fake.random_element(elements=('401k', 'IRA', 'Pension')))
        print('Employment Status: ', fake.random_element(elements=('employed', 'unemployed', 'self-employed')))
        print('Job Title: ', fake.job())
        print('Job Description: ', fake.bs())
        print('Company: ', fake.company())
    # Educational Information
    elif title == "Educational Information:":
        print("GPA:", fake.pyfloat(left_digits=1, right_digits=2, positive=True, min_value=1, max_value=4))
        print("High school attended:", fake.company())
        print("High school graduation year:", fake.random_int(min=2000, max=2022))
        print("Certifications:", fake.bs())
        print("Awards and honors:", fake.bs())
        print("Extracurricular activities:", fake.bs())
        print('University: ', fake.random_element(elements=('Harvard University', 'Stanford University', 'Massachusetts Institute of Technology', 'California Institute of Technology', 'University of Cambridge')))
        print('Course of Study: ', fake.random_element(elements=('Computer Science', 'Engineering', 'Business Administration', 'Medicine', 'Law')))
        print('Graduation Year: ', fake.random_int(min=2022, max=2030))
        print('Degree: ', fake.random_element(elements=('Computer Science', 'Engineering', 'Business Administration', 'Medicine', 'Law')))
    # Financial Information
    elif title == "Financial Information:":
        print("Net worth:", fake.random_int(min=100000, max=1000000000))
        print("Assets:", fake.bs())
        print("Liabilities:", fake.bs())
        print("Investments:", fake.bs())
        print("Savings account balance:", fake.random_int(min=0, max=1000000))
        print("Checking account balance:", fake.random_int(min=0, max=1000000))
        print("Mortgage information:", fake.bs())
        print('Credit Card: ', fake.credit_card_number())
        print('Expiration Date: ', fake.credit_card_expire(start='now', end='+10y', date_format='%m/%y'))
        print('Card Security Code (CVV): ', fake.credit_card_security_code())
        print('Credit Score: ', fake.random_int(min=500, max=850))
        print('Monthly Income: ', fake.random_int(min=1000, max=10000))
        print('IBAN:', fake.iban())
    # Favorites
    elif title == "Favorites:":
        print("Favorite vacation destination:", fake.city() + ", " + fake.country())
        print("Favorite type of cuisine:", fake.random_element(elements=('Italian', 'Mexican', 'Chinese', 'Japanese', 'Indian')))
        print("Favorite restaurant:", fake.company())
        print("Favorite hobby:", fake.random_element(elements=('Reading', 'Sports', 'Cooking', 'Traveling', 'Art')))
        print("Favorite TV show character:", fake.name())
        print("Favorite movie character:", fake.name())
        print("Favorite book character:", fake.name())
        print("Favorite superhero:", fake.random_element(elements=superheroes))
        print("Favorite video game:", fake.random_element(elements=('Fortnite', 'Minecraft', 'World of Warcraft', 'Call of Duty', 'Grand Theft Auto')))
        print("Favorite board game:", fake.random_element(elements=('Monopoly', 'Risk', 'Settlers of Catan', 'Scrabble', 'Clue')))
        print("Favorite musical instrument:", fake.random_element(elements=('Guitar', 'Piano', 'Drums', 'Violin', 'Saxophone')))
        print("Favorite singer/band:", fake.random_element(elements=('The Beatles', 'Queen', 'Led Zeppelin', 'Pink Floyd', 'The Rolling Stones')))
        print("Favorite song:", fake.catch_phrase())
        print("Favorite album:", fake.bs())
        print('Favorite Food: ', fake.random_element(elements=('pizza', 'sushi', 'burger', 'taco', 'pasta')))
        print('Pet Name: ', fake.first_name())
        print('Pet Species: ', fake.random_element(elements=('dog', 'cat', 'fish', 'bird', 'hamster')))
        print('Car Make: ', fake.random_element(elements=('Toyota', 'Ford', 'Honda', 'Chevrolet', 'Nissan')))
        print('Car Model: ', fake.random_element(elements=('Camry', 'Fusion', 'Civic', 'Malibu', 'Altima')))
        print('Vehicle Type: ', fake.random_element(elements=('sedan', 'SUV', 'pickup truck', 'convertible', 'motorcycle')))
        print('Favorite Music Genre: ', fake.random_element(elements=('Rock', 'Pop', 'Hip Hop', 'Jazz', 'Classical')))
        print('Favorite Movie Genre: ', fake.random_element(elements=('Action', 'Comedy', 'Drama', 'Horror', 'Science Fiction')))
        print('Favorite Book Genre: ', fake.random_element(elements=('Mystery', 'Romance', 'Science Fiction', 'Thriller', 'Fantasy')))
        print('Favorite Sport: ', fake.random_element(elements=('soccer', 'basketball', 'football', 'tennis', 'swimming')))
        print('Favorite Animal: ', fake.random_element(elements=('lion', 'penguin', 'elephant', 'koala', 'giraffe')))
        print('Favorite TV Show: ', fake.random_element(elements=('Game of Thrones', 'Friends', 'Breaking Bad', 'The Office', 'Stranger Things')))
        print('Favorite TV Network: ', fake.random_element(elements=('HBO', 'Netflix', 'Amazon Prime', 'Disney+', 'Hulu')))
        print('Favorite Streaming Service: ', fake.random_element(elements=('Spotify', 'Apple Music', 'Tidal', 'Pandora', 'Amazon Music')))
        print('Favorite Movie: ', fake.random_element(elements=('The Godfather', 'Titanic', 'Avatar', 'Star Wars', 'Jurassic Park')))
        print('Favorite Social Media Platform: ', fake.random_element(elements=('Facebook', 'Instagram', 'Twitter', 'TikTok', 'Snapchat')))
        print('Favorite Beverage: ', fake.random_element(elements=('coffee', 'tea', 'soda', 'juice', 'beer')))
        print('Favorite Snack: ', fake.random_element(elements=('chips', 'popcorn', 'candy', 'nuts', 'fruit')))
        print('Favorite Artist: ', fake.random_element(elements=('Beyoncé', 'Taylor Swift', 'Drake', 'Ariana Grande', 'Ed Sheeran')))
        print('Favorite Actor: ', fake.random_element(elements=('Tom Hanks', 'Leonardo DiCaprio', 'Meryl Streep', 'Denzel Washington', 'Emma Stone')))
        print('Favorite Actress: ', fake.random_element(elements=('Emma Watson', 'Jennifer Lawrence', 'Sandra Bullock', 'Scarlett Johansson', 'Viola Davis')))
    # Online Information
    elif title == "Online Information:":
        print('Username: ', fake.user_name())
        print('Email: ', fake.email())
        print('Password: ', fake.password(length=12, special_chars=True, digits=True, upper_case=True, lower_case=True))
        print('Domain Name: ', fake.domain_name())
        print('URL: ', fake.url())
        print('IPv4 Address: ', fake.ipv4())
        print('IPv6 Address: ', fake.ipv6())
        print('User Agent:', fake.user_agent())
        print('ISBN: ', fake.isbn13())