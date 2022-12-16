module day6

import src/lib

fun find-dup(chars : list<char>)
  var unique := []

  chars.foreach-while fn (c)
    match unique.find fn (u) { u == c }
      Just(v) -> Just(v)
      Nothing ->
        unique := unique ++ [c]
        Nothing

fun find-marker(input : string, size : int)
  var chars-processed := size
  var to-process := input.list
  var processing := to-process.take(size)

  while { processing.length == size && processing.find-dup.bool }
    to-process := to-process.tail
    processing := to-process.take(size)
    chars-processed := chars-processed + 1

  chars-processed

pub fun main()
  val input = get-input("6").trim

  val p1 = input.find-marker(4)
  println("Problem 1: " ++ p1.show)

  val p2 = input.find-marker(14)
  println("Problem 2: " ++ p2.show)
