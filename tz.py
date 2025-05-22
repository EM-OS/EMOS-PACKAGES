import pytz

with open("timezones.txt", "w") as f:
    for tz in pytz.all_timezones:
        f.write(tz + "\n")
