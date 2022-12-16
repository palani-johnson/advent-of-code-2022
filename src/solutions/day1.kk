module day1

import src/lib

fun parse-input(input-text)
  input-text
    .split("\n\n")
    .map fn (elve)
      elve
        .split("\n")
        .map fn (cal)
          cal.trim.parse-int-default(0)
        .sum


pub fun main()
  val input = get-input("1").parse-input

  val p1 = input.maximum(0)
  println("Problem 1: " ++ p1.show)

  val p2 = input.sort.take(3).sum
  println("Problem 2: " ++ p2.show)
