module day4

import src/lib

alias pair = (int, int)
alias section-pair = (pair, pair)

fun parse-input(input : string) : exn list<section-pair>
  with line <- input.split("\n").map

  val [[a, b], [c, d]] = line.split(",").map fn (e)
    with n <- e.split("-").map
    n.parse-int.unjust

  ((a, b), (c, d))

fun fully-overlap(((start1, end1), (start2, end2)): section-pair) : bool
  (start1 <= start2 && end2 <= end1) || (start2 <= start1 && end1 <= end2)

fun dont-overlap(((start1, end1), (start2, end2)): section-pair) : bool
  (start1 < start2 && end1 < start2) || (start2 < start1 && end2 < start1)


pub fun main()
  val input = get-input("4").trim.parse-input

  var p1 := 0
  input.foreach fn (sections)
    p1 := p1 + int(sections.fully-overlap)

  print("Problem 1: ")
  println(p1)

  var p2 := 0
  input.foreach fn (sections)
    p2 := p2 + int(sections.dont-overlap)
  p2 := input.length - p2

  print("Problem 1: ")
  println(p2)



