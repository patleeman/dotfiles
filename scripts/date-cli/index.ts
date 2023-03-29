#!/usr/bin/env npx ts-node

import * as chrono from "chrono-node";
import { program } from "@commander-js/extra-typings";
import { DateTime } from "luxon";

function parse_date(text: string, format: string | undefined = undefined, quickFormat: string | undefined): string | undefined {
  const date = chrono.parseDate(text);
  if (date) {
    const dt = DateTime.fromJSDate(date);
    if (quickFormat) {
      switch (quickFormat) {
        case "ts":
          return dt.toFormat("X");
        case "ymd":
          return dt.toFormat("yyyy-MM-dd");
        case "ymdhm":
          return dt.toFormat("yyyy-MM-dd hh:mm a");
        case "auto":
          // If no time element, then just output a date.
          if (dt.hour === 12 && dt.minute === 0 && dt.second === 0 && dt.millisecond === 0) {
            return dt.toFormat("yyyy-MM-dd");
          }
          return dt.toFormat("yyyy-MM-dd hh:mm a")
        default:
          throw new Error("Invalid quick format token")
      }
    }
    if (format) {
      return dt.toFormat(format);
    }
    return dt.toISO();
  }
}

function main(): void {
  program
    .name("Natural Language Date Util")
    .description("CLI that takes a string with a natural language date and outputs a formatted date string")
    .argument('<string...>', "String to parse")
    .option('-q, --quick-format <string>', "Quick format: ymd (yyyy-MM-dd), ymdhm (yyyy-MM-dd hh:mm a) , ts (X), auto (ymd or ymdhm)")
    .option("-f, --format <string>", "Provide a custom date format (https://moment.github.io/luxon/#/formatting?id=table-of-tokens)")
    .action((text: string[], options) => {
      const format = options?.format;
      const quickFormat = options?.quickFormat;
      let date: undefined | string;
      try {
        date = parse_date(text.join(" "), format, quickFormat);
      } catch (e) {
        let m = "Failed to parse date";
        if (e instanceof Error) {
          m = e.message;
        }
        process.stderr.write(m);
        process.exit(1);
      }

      if (date) {
        process.stdout.write(date);
      } else {
        process.stderr.write("Unable to parse");
        process.exit(1);
      }
    });

  program.parse();
}


main();
