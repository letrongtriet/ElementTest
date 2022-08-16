import Darwin
import Foundation

print("Example syntax: \n")
print("======================")
print("swift run ElementTest 16:10")
print("======================")
print("\n")

// We drop the first argument, which is the script execution path.
let arguments: [String] = Array(CommandLine.arguments.dropFirst())

// First, we need to get the input HH:mm
guard let hourAndMinute = arguments.first else {
    print("Invalid input simulated time, please try again")
    print("Example syntax: \n")
    print("======================")
    print("swift run ElementTest 16:10")
    print("======================")
    print("\n")
    exit(EXIT_FAILURE)
}

let hourAndMinuteComponents = hourAndMinute.components(separatedBy: ":")
guard let inputHour = hourAndMinuteComponents[safe: 0],
      let simulatedHour = Int(inputHour),
      var inputMinute = hourAndMinuteComponents[safe: 1],
      let simulatedMinute = Int(inputMinute)
else {
    print("Invalid input simulated time, please try again")
    print("Example syntax: \n")
    print("======================")
    print("swift run ElementTest 16:10")
    print("======================")
    print("\n")
    exit(EXIT_FAILURE)
}

// Try to pretty print
if inputMinute == "0" {
    inputMinute = "00"
}

// Second, we need to get the input.txt content
let standardInput: FileHandle = .standardInput
guard let fileContent = String(data: standardInput.availableData, encoding: .utf8) else {
    print("Config file cannot be read or found")
    print("Example syntax: \n")
    print("======================")
    print("swift run ElementTest 16:10")
    print("======================")
    print("\n")
    exit(EXIT_FAILURE)
}
let inputs = fileContent.components(separatedBy: "\n")

// Third, this is our output
var outputs = [String]()

for input in inputs {
    let minuteHourAndJobNameComponents = input.components(separatedBy: " ")
    guard let minute = minuteHourAndJobNameComponents[safe: 0],
          let hour = minuteHourAndJobNameComponents[safe: 1],
          let jobName = minuteHourAndJobNameComponents[safe: 2] else {
        print("Invalid config for \(input)")
        continue
    }

    var currentDayValue = "today"

    let currentHourValue = hour
    let currentMinuteValue = minute
    let defaultMinuteValue = "00"

    if let hourIntegerValue = Int(currentHourValue),
       Int(currentMinuteValue) != nil {
        if hourIntegerValue < simulatedHour {
            currentDayValue = "tomorrow"
        }
        outputs.append("\(currentHourValue):\(currentMinuteValue) \(currentDayValue) - \(jobName)")
        continue
    }else if let hourIntegerValue = Int(currentHourValue) {
        if hourIntegerValue < simulatedHour {
            currentDayValue = "tomorrow"
        }
        outputs.append("\(currentHourValue):\(defaultMinuteValue) \(currentDayValue) - \(jobName)")
        continue
    }else if let minuteIntegerValue = Int(currentMinuteValue) {
        var toPrintHour = inputHour
        if minuteIntegerValue < simulatedMinute {
            toPrintHour = "\(simulatedHour + 1)"
        }
        outputs.append("\(toPrintHour):\(currentMinuteValue) \(currentDayValue) - \(jobName)")
        continue
    } else {
        outputs.append("\(inputHour):\(inputMinute) \(currentDayValue) - \(jobName)")
        continue
    }
}

print("Your config \n")
print(fileContent)
print("\n")

print("Your simulated time \n")
print("\(inputHour):\(inputMinute)")
print("\n")

let toPrint = outputs.joined(separator: "\n")
print("Here is your outputs \n")
print(toPrint)
print("\n")

