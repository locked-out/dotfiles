#!/usr/bin/env python

import json
import requests
import datetime
import bisect

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
    return (temp+"°").ljust(3)


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


data['text'] = WEATHER_CODES[weather['current_condition'][0]['weatherCode']] + \
    " "+weather['current_condition'][0]['FeelsLikeC']+"°C"

data['tooltip'] = f"<b>{weather['current_condition'][0]['weatherDesc'][0]['value']} {weather['current_condition'][0]['temp_C']}°C</b>\n"
data['tooltip'] += f"Feels like: {weather['current_condition'][0]['FeelsLikeC']}°C\n"
data['tooltip'] += f"Wind: {weather['current_condition'][0]['windspeedKmph']}Km/h\n"
data['tooltip'] += f"Humidity: {weather['current_condition'][0]['humidity']}%\n"


def temp_to_colour(temperature : int):
    '''
    Colours:
        white
    7
        #8aadf4 
    13
        #eed49f
    21
        #f5a97f
    27
        #ee99a0
    33
        #ed8796
    '''
    breakpoints = [7, 13, 21, 27, 33]
    colour_bands = [
        "white",
        "#8aadf4",
        "#eed49f",
        "#f5a97f",
        "#ee99a0",
        "#ed8796"
    ]
    
    band_no = bisect.bisect_left(breakpoints, temperature)
    colour_band = colour_bands[band_no]
    return colour_band

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
