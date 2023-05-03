# Requires ical-buddy to be installed
import sys
import subprocess
import datetime

# Symbol to mark each calendar event
BULLET = "📅"

# Run icalBuddy calendars to get a list of calendars
CALENDAR_UIDS = [
    "27F9112A-B256-4EE3-887A-D3510B7FBA74",
    "D81A0E95-A2A0-43ED-8B98-28A2518FF6C5"
]


def get_availability(
        days: int,
        minimum_meeting_duration_min: int = 30,
        day_start_time: str = "08:00",
        day_end_time: str = "18:00"):
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
    # print("Executing: ", " ".join(CMD))

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

    # Go through and figure out the occupied time periods by merging events
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

    # Grab the time between the occupied periods to figure
    # out what times are open
    open_periods = {}
    for day in occupied_periods:
        day_open_periods = []
        counter = 0
        while counter < len(occupied_periods[day]):
            period = occupied_periods[day][counter]
            start_period = period[0]
            end_period = period[1]

            if counter == 0:
                start = datetime.datetime.fromisoformat(
                    f"{day} {day_start_time}")
                if start < start_period:
                    day_open_periods.append(
                        (start, start_period, start_period - start))

            if counter == len(occupied_periods[day]) - 1:
                end = datetime.datetime.fromisoformat(f"{day} {day_end_time}")
                if end > end_period:
                    day_open_periods.append(
                        (end_period, end, end - end_period))
                counter += 1
                continue

            end_period = period[1]
            next_start = occupied_periods[day][counter + 1][0]
            day_open_periods.append(
                (end_period, next_start, next_start - end_period))

            counter += 1

        open_periods[day] = day_open_periods

    output = []
    for day in open_periods:
        day_output = []
        day_obj = datetime.datetime.strptime(day, "%Y-%m-%d")
        day_output.append(f"\n{day_obj.strftime('%a %b %-d, %Y')}: ")
        for period in open_periods[day]:
            seconds = period[2].total_seconds()
            time_delta_string = []
            hours = int(seconds // 3600)
            if hours:
                time_delta_string.append(f"{hours}h")

            minutes = int((seconds % 3600) // 60)
            if minutes:
                time_delta_string.append(f"{minutes}m")

            if seconds >= minimum_meeting_duration_min * 60:
                start_period = period[0].strftime('%I:%M %p')
                end_period = period[1].strftime('%I:%M %p')
                delta_string = ' '.join(time_delta_string)
                day_output.append(
                    f"- {start_period} - {end_period} ({delta_string})")

        if len(day_output) > 1:
            output += day_output

    return "\n".join(output)


if __name__ == "__main__":
    args = sys.argv
    days = 0
    if len(args) > 1:
        days = int(args[1])

    minimum_meeting_duration_min = 30
    if len(args) > 2:
        minimum_meeting_duration_min = int(args[2])

    print(get_availability(days, minimum_meeting_duration_min))
