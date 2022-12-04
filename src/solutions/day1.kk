module day1

import src/lib

fun parse-input(input-text)
  input-text
    .split("\n\n")
    .map fn (elve)
      elve.split("\n").map fn (cal)
        cal.trim.parse-int-default(0)

fun problem1(input)
  input.map(sum).maximum(0)

fun problem2(input)
  input.map(sum).sort.take(3).sum


pub fun main()
  val input = "1".get-input.parse-input
  val p1 = input.problem1
  print("Problem 1: ")
  println(p1)

  val p2 = input.problem2
  print("Problem 2: ")
  println(p2)
