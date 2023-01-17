import requests
from PIL import Image
from io import BytesIO

# Replace with the URL of the image you want to read
image_url = 'https://www.example.com/image.jpg'

# Fetch the image and read its meta data
response = requests.get(image_url)
image = Image.open(BytesIO(response.content))
meta_data = image.getexif()

# Extract the GPS information from the meta data
gps_info = meta_data.get(34853)

# Convert the GPS information to decimal coordinates
lat, long = gps_info[2]
lat = lat[0][0] / lat[0][1] + lat[1][0] / (lat[1][1] * 60) + lat[2][0] / (lat[2][1] * 3600)
long = long[0][0] / long[0][1] + long[1][0] / (long[1][1] * 60) + long[2][0] / (long[2][1] * 3600)

print("Latitude: ", lat)
print("Longitude: ", long)
