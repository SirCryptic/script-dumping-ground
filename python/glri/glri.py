import requests
from PIL import Image
from io import BytesIO
import reverse_geocoder as rg

# Developer: SirCryptic (NullSecurityTeam)
# Info: glri 1.0
#This code will perform a reverse image search on Google and then use reverse geocoding to determine the location of the image.

# Replace with the URL of the image you want to read
image_url = input("Enter Image URL ")

# Fetch the image and read its meta data
response = requests.get(image_url)
try:
    image = Image.open(BytesIO(response.content))
    meta_data = image.getexif()

    # Extract the GPS information from the meta data
    gps_info = meta_data.get(34853)

    if gps_info is not None:
        # Convert the GPS information to decimal coordinates
        lat, long = gps_info[2]
        lat = lat[0][0] / lat[0][1] + lat[1][0] / (lat[1][1] * 60) + lat[2][0] / (lat[2][1] * 3600)
        long = long[0][0] / long[0][1] + long[1][0] / (long[1][1] * 60) + long[2][0] / (long[2][1] * 3600)

        # Print the latitude and longitude
        print("Latitude: ", lat)
        print("Longitude: ", long)

        # Perform a reverse image search and geolocate the image
        search_url = "https://www.google.com/searchbyimage?&image_url=" + image_url
        headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36'}
        search_response = requests.get(search_url, headers=headers)

        # Extract the location information from the search results
        location = None
        if search_response.status_code == 200:
            start = search_response.text.find('<div class="fMghp">') + len('<div class="fMghp">')
            end = search_response.text.find('</div>', start)
            location = search_response.text[start:end]
        
        if location is not None:
            # Print the location information
            print("Location: ", location)

            # Perform a reverse geocode lookup on the latitude and longitude
            results = rg.search((lat, long))
            print("Address: ", results[0]['name'], results[0]['admin1'], results[0]['cc'])
        else:
            print("Location information not found in reverse image search results.")
    else:
        print("GPS information not found in image metadata.")
except:
    print("An error occurred while processing the image.")