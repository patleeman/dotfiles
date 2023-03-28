#!/usr/bin/env python3
import argparse
import dateparser

def parse_date(text: str, format: str="") -> str | None:
    dt = dateparser.parse(text)
    if not dt:
        return None
    if format:
        return dt.strftime(format)
    else:
        return dt.isoformat()


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Process natural language dates")
    parser.add_argument('parse', nargs="+", help="Text to process")
    parser.add_argument('--format', nargs="?", type=str, help="Output date format, if omitted defaults to ISO8601")

    args = parser.parse_args()
    text = " ".join(args.parse)
    parsed_date = parse_date(text, args.format)
    print(parsed_date)







