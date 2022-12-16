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
  start1 <= start2 && end2 <= end1 || start2 <= start1 && end1 <= end2

fun dont-overlap(((start1, end1), (start2, end2)): section-pair) : bool
  start1 < start2 && end1 < start2 || start2 < start1 && end2 < start1

pub fun main()
  val input = get-input("4").trim.parse-input

  val p1 = input.foldl(0) fn (acc, sections)
    acc + sections.fully-overlap.int
  println("Problem 1: " ++ p1.show)

  val p2 = input.foldl(input.length) fn (acc, sections)
    acc - sections.dont-overlap.int
  println("Problem 2: " ++ p2.show)



