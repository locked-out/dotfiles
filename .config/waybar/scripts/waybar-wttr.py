#!/usr/bin/env python

import json
import requests
import datetime
import bisect
import textwrap

WEATHER_CODES = {
    '113': '☀️',
    '116': '⛅️',
    '119': '☁️',
    '122': '☁️',
    '143': '🌫',
    '176': '🌦',
    '179': '🌧',
    '182': '🌧',
    '185': '🌧',
    '200': '⛈',
    '227': '🌨',
    '230': '❄️',
    '248': '🌫',
    '260': '🌫',
    '263': '🌦',
    '266': '🌦',
    '281': '🌧',
    '284': '🌧',
    '293': '🌦',
    '296': '🌦',
    '299': '🌧',
    '302': '🌧',
    '305': '🌧',
    '308': '🌧',
    '311': '🌧',
    '314': '🌧',
    '317': '🌧',
    '320': '🌨',
    '323': '🌨',
    '326': '🌨',
    '329': '❄️',
    '332': '❄️',
    '335': '❄️',
    '338': '❄️',
    '350': '🌧',
    '353': '🌦',
    '356': '🌧',
    '359': '🌧',
    '362': '🌧',
    '365': '🌧',
    '368': '🌨',
    '371': '❄️',
    '374': '🌧',
    '377': '🌧',
    '386': '⛈',
    '389': '🌩',
    '392': '⛈',
    '395': '❄️'
}

CHANCE_ICONS = [
    "󰪞",
    "󰪟",
    "󰪠",
    "󰪡",
    "󰪢",
    "󰪣",
    "󰪤",
    "󰪥"
]

data = {}


weather = requests.get("https://wttr.in/?format=j1").json()

# with open("/home/ollie/.config/waybar/weather.json", "w") as f:
#     json.dump(weather, f, indent=2)

def format_time(time : str):
    hour = int(int(time)/100)
    if hour == 0:
        hour = "12 PM"
    elif hour > 12:
        hour -= 12
        hour = str(hour) + ' PM'
    else:
        hour = str(hour) + ' AM'
    return hour.rjust(5)


def format_temp(temp : str):
    return (temp+"°").rjust(3)


def format_chances(hour : dict):
    chances = {
        "chanceoffog": "Fog",
        "chanceoffrost": "Frost",
        "chanceofovercast": "Overcast",
        "chanceofrain": "Rain",
        "chanceofsnow": "Snow",
        # "chanceofsunshine": "Sunshine",
        "chanceofthunder": "Thunder",
        "chanceofwindy": "Wind"
    }

    conditions = []
    for event in chances.keys():
        chance = int(hour[event]) 
        if chance > 0:
            chanceicon = CHANCE_ICONS[chance * (len(CHANCE_ICONS) - 1) // 100]
            conditions.append(chances[event]+" "+chanceicon)
    return ", ".join(conditions)

def format_span(string:str, **kwargs):
    style = " ".join(f"{k}='{v}'" for k, v in kwargs.items())
    return f"<span {style}>{string}</span>"

def hex_to_colours(hex : str) -> list[int]:
    colours = textwrap.wrap(hex[1::], 2)
    return [int(i, 16) for i in colours]
def colours_to_hex(colours : list[int]) -> str:
    s = "#" + "".join([f'{i:x}' for i in colours])
    return s
    
def colour_blend(from_colour : str, to_colour : str, ratio : float) -> str:
    from_colours = hex_to_colours(from_colour)
    to_colours = hex_to_colours(to_colour)

    blended_colours = []

    for from_channel, to_channel in zip(from_colours, to_colours):
        blended_channel = int(from_channel + (to_channel - from_channel) * ratio)
        blended_colours.append(blended_channel)

    return colours_to_hex(blended_colours)

def temp_to_colour(temperature : int):
    '''
    Colours:
    6   white
    9   #b4befe
    12  #8aadf4 
    15  #74c7ec 	
    17  #89dceb
    19  #94e2d5
    23  #a6e3a1
    25  #f9e2af
    27  #fab387
 	30  #eba0ac
 	35  #f38ba8 	
    '''
    keyframes = [6,9,12,15,17,19,23,25,27,30,35]
    colour_bands = [
        "#ffffff",
        "#b4befe",
        "#8aadf4",
        "#74c7ec",	
        "#89dceb",
        "#94e2d5",
        "#a6e3a1",
        "#f9e2af",
        "#fab387",
 	    "#eba0ac",
 	    "#f38ba8"	
    ]
    if temperature <= keyframes[0]:
        return colour_bands[0]
    if temperature >= keyframes[-1]:
        return colour_bands[-1]

    # Will return the index where temperature could be correctly inserted in the sorted keyframes
    # keyframes[index] < temperature where index ∈ [0, band_no) 
    band_no = bisect.bisect_left(keyframes, temperature)

    # Check the temperature doesnt match a keyframe
    if temperature == keyframes[band_no]:
        return colour_bands[band_no]

    # The two relevant keyframes are located at `band_no - 1` and `band_no`

    ratio = (temperature - keyframes[band_no-1])/(keyframes[band_no]-keyframes[band_no-1])
    colour = colour_blend(colour_bands[band_no-1], colour_bands[band_no], ratio)

    return colour

now_temp = weather['current_condition'][0]['FeelsLikeC']
data['text'] = WEATHER_CODES[weather['current_condition'][0]['weatherCode']] + \
    " "+ format_span(now_temp+"°C", color=temp_to_colour(int(now_temp)), weight="bold")

data['tooltip'] = f"<b>{weather['current_condition'][0]['weatherDesc'][0]['value']} {weather['current_condition'][0]['temp_C']}°C</b>\n"
data['tooltip'] += f"Feels like: {weather['current_condition'][0]['FeelsLikeC']}°C\n"
data['tooltip'] += f"Wind: {weather['current_condition'][0]['windspeedKmph']}Km/h\n"
data['tooltip'] += f"Humidity: {weather['current_condition'][0]['humidity']}%\n"



days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

for i, day in enumerate(weather['weather']):
    thisdate = datetime.date.fromisoformat(day['date'])
    data['tooltip'] += f"\n<b>"
    if i == 0:
        data['tooltip'] += "Today, "
    elif i == 1:
        data['tooltip'] += "Tomorrow, "
    

    data['tooltip'] += f"{days[thisdate.weekday()]}</b> "
    data['tooltip'] += format_span(f"{day['mintempC']}° ", weight="bold", color=temp_to_colour(int(day['mintempC'])))
    data['tooltip'] += format_span(f"{day['maxtempC']}° ", weight="bold", color=temp_to_colour(int(day['maxtempC'])))
    # data['tooltip'] += f"🌅 {day['astronomy'][0]['sunrise']} 🌇 {day['astronomy'][0]['sunset']}"
    data['tooltip'] += "\n"
    for hour in day['hourly']:
        blackout = False
        if i == 0:
            if int(hour['time'])/100 < datetime.datetime.now().hour-2:
                blackout = True
      
        hour_temp = hour['FeelsLikeC']
        line = f"{format_time(hour['time'])} {WEATHER_CODES[hour['weatherCode']]} {format_span(format_temp(hour_temp), color=temp_to_colour(int(hour_temp)))} {hour['weatherDesc'][0]['value']}"
        chances = format_chances(hour)
        if chances:
            styling = {"style":"italic"}
            if not blackout:
                styling["color"]="#cdd6f4"
            line += ' ' + format_span(chances,**styling)
        line += "\n"
       
        if blackout:
            line = format_span(line, color="#7f849c")


        data['tooltip'] += line

print(json.dumps(data))
