module day2

import src/lib

fun unwrap-maybe(maybe-val)
  match maybe-val
    Just(a) -> a


fun parse-input(input-text)
  input-text
    .split("\n")
    .map fn (round)
      val r = round.split(" ")

      (r[0].unwrap-maybe, r[1].unwrap-maybe)

fun calc-p1-score((op, me) : (string, string))
  match me
    "X" -> 1 + (
      match op
        "C" -> 6
        "A" -> 3
        "B" -> 0
    )
    "Y" -> 2 + (
      match op
        "A" -> 6
        "B" -> 3
        "C" -> 0
    )
    "Z" -> 3 + (
      match op
        "B" -> 6
        "C" -> 3
        "A" -> 0
    )


fun calc-p2-score((op, outcome) : (string, string))
  val outcome-score = match outcome
    "X" -> 0
    "Y" -> 3
    "Z" -> 6

  val hand-score = match (op, outcome)
    ("A", "X") -> 3
    ("A", "Y") -> 1
    ("A", "Z") -> 2
    ("B", "X") -> 1
    ("B", "Y") -> 2
    ("B", "Z") -> 3
    ("C", "X") -> 2
    ("C", "Y") -> 3
    ("C", "Z") -> 1

  scoroutcome-scoree + hand-score



pub fun main()
  val input = get-input("2").trim.parse-input
  val p1 = input.map(calc-p1-score).sum
  print("Problem 1: ")
  println(p1)

  val p2 = input.map(calc-p2-score).sum
  print("Problem 2: ")
  println(p2)
