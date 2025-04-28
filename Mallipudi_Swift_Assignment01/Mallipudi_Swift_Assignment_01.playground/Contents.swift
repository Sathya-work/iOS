import UIKit

//*******Questions******//
// 1. In which year was the first version of the Swift programming language introduced?
// Explain why Swift is considered a modern and user-friendly programming language.
// Also, describe type safety and type inference in Swift with examples.
print("The first version of Swift was developed in 2014")
print("Swift is a modern, user-friendly programming designed for modern app development. It prioritizes safety, performance, and simplicity, making it easy to write and maintain clean, efficient code.")

print("""

Type Safety: Swift is a type-safe language, meaning it ensures you use variables with the correct data types during compile time, reducing runtime errors. For example, assigning a string to an integer variable results in a compile-time error.

var age: Int = 23
age = "Twenty-three" // we will get an error that we cannot assign a string to an integer variable

Type Inference: Swift can automatically determine the type of a variable or constant based on its assigned value, reducing the need for explicit type annotations

let name = "John" // Swift takes the type as String based on the value provided
var score = 90    // Swift takes the type as Int

This makes Swift concise while maintaining type safety.
""")

// End of question 1


// 2. Declare a constant 'pi' of type Double with the value 3.14. Write code to calculate
// the area of a circle with a radius of 10.0 units using the formula: Area = pi * radius * radius.
// Print the calculated area as shown in the sample output below:
// "The area of the circle with radius 10.0 is **** square units."
let pi : Double = 3.14;
let radius : Double = 10.0;
let area : Double = pi * radius * radius;
print("The area of the circle with radius \(radius) is \(area) square units.")

print("----------------------")
// End of question 2


// 3. Declare a variable with a value of 212°F (boiling point of water) in Fahrenheit, convert it to Celsius,
// and round it to one decimal place. Print the result in this format:
// "Temperature: 212°F is equivalent to ****°C."
let fahrenheit: Double = 212;
let celsius: Double = (fahrenheit - 32) * 5 / 9;
print("Temperature: \(fahrenheit)°F is equivalent to \(String(format: "%.1f", celsius))°C.")
print("----------------------")
// End of question 3


// 4. Write three statements about why Swift is a great language for beginners and developers.
// Display the first two statements on one line and the third statement on the next line using print statements.
print("Swift is easy to read and learn,", "and it provides robust safety features.")
print("It also offers powerful tools for modern app development.")
print("----------------------")
// End of question 4


// 5. Display the following using a single print statement:
// "Swift is an intuitive, powerful, and safe programming language designed for iOS and other Apple platforms.
// It offers modern features, concise syntax, and exceptional performance that developers love."
print("Swift is an intuitive, powerful, and safe programming language designed for iOS and other Apple platforms. \nIt offers modern features, concise syntax, and exceptional performance that developers love.")
print("----------------------")
// End of question 5


// 6. Declare two variables, num1 and num2, and assign them any two 3-digit numbers.
// Write code to calculate their product and determine how many digits the product contains.
// Print the result in this format:
// "The product of <num1> and <num2> is ****, and it has **** digits."
let num1 = 883
let num2 = 792
let product = num1 * num2
let numDigitsInProduct = String(product).count
print("The product of \(num1) and \(num2) is \(product), and it has \(numDigitsInProduct) digits.")
print("----------------------")
// End of question 6


// 7. Create a variable with the value "Swift programming is fun!".
// Count the total number of characters excluding spaces and print them as individual characters separated by "+".
// For example: "S+w+i+f+t+p+r+o+g+r+a+m+m+i+n+g+i+s+f+u+n"
var value = "Swift programming is fun!"
value.removeAll(where: { $0 == " " })
print(value.map(\.description).joined(separator: "+"))
print("----------------------")
// End of question 7


// 8. A car is traveling at a constant velocity of 20 m/s for 12 seconds.
//Calculate the total distance traveled during this time period using the formula:
//Distance = velocity × time
//Print the result in this format:
//"The car traveled a distance of **** meters."
let velocity = 20.0
let time = 12.0
let distance = velocity * time
print("The car traveled a distance of \(distance) meters.")
print("----------------------")
// End of question 8





