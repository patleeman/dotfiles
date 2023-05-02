# Requires ical-buddy to be installed
import sys
import subprocess
import datetime
from pprint import pprint

BULLET = "📅"

# Run icalBuddy calendars to get a list of calendars

CALENDAR_UIDS = [
    "27F9112A-B256-4EE3-887A-D3510B7FBA74",
    "D81A0E95-A2A0-43ED-8B98-28A2518FF6C5"
]

DAY_START = datetime.time(hour=8)
DAY_END = datetime.time(hour=18)


def get_availability(days: int):
    # Customize the CLI command
    CMD = [
        "icalBuddy",
        "-iep datetime,title",
        "-df %Y-%m-%d",
        "-tf %H:%M:%S",
        "-nrd",
        "-ea",
        f"-b {BULLET}",
        f"-ic {','.join(CALENDAR_UIDS)}",
        f"eventsToday+{days}"
    ]
    print("Executing: ", " ".join(CMD))

    # Run the command and check it completed
    completed = subprocess.run(
        " ".join(CMD), shell=True, capture_output=True, text=True)
    completed.check_returncode()
    results = completed.stdout.split("\n")

    # Generate a list of events from icalbuddy output
    events = {}
    count = 0
    while count < len(results):
        line = results[count]
        if line.startswith(BULLET):
            title = line.replace(BULLET, "")
            # Grab the next line which contains the date time
            next_line = results[count + 1]
            date_and_time = next_line.split(" at ")
            date_str = date_and_time[0].strip()
            time_str = date_and_time[1].strip()
            time_from, time_to = time_str.split(" - ")

            event_start = datetime.datetime.fromisoformat(
                f"{date_str} {time_from}")
            event_end = datetime.datetime.fromisoformat(
                f"{date_str} {time_to}")
            event = {
                "title": title,
                "start": event_start,
                "end": event_end
            }

            if date_str not in events:
                events[date_str] = []

            events[date_str].append(event)

        count += 2

    # Go through and figure out the occupied time periods
    occupied_periods = {}
    for day in events:
        events[day].sort(key=lambda d: d.get("start"))
        occupied = []
        for event in events[day]:
            start = event.get('start')
            end = event.get('end')
            if len(occupied) == 0:
                occupied.append((start, end))
                continue

            if start <= occupied[-1][1]:
                last_item = occupied.pop()
                occupied.append((last_item[0], end))
                continue

            occupied.append((start, end))

        occupied_periods[day] = occupied

    print(occupied_periods)
    return events


if __name__ == "__main__":
    args = sys.argv
    days = 0
    if len(args) > 1:
        days = int(args[1])
    get_availability(days)
