module day3

import src/lib

fun parse-input(input : string)
  input.split("\n").map fn (line)
    line.list.map fn (c)
      val n = c.int - 96
      if n.is-pos then n
      else n + 58

fun find-dup(lists : list<list<int>>, match-stack: list<int> = [])
  match lists
    Cons(head, tail) ->
      head.find-maybe fn (h)
        tail.find-dup(match-stack ++ [h])
    Nil ->
      match match-stack.head
        Nothing -> Nothing
        Just(a) ->
          if match-stack.all fn (v)
            v == a
          then Just(a)
          else Nothing

fun make-group(xs : list<a>, n : int) : div list<list<a>>
  val (group, rest) = xs.split(n)

  if rest.length < n then [group]
  else [group] ++ rest.make-group(n)


pub fun main()
  val input = get-input("3").trim.parse-input

  val p1 = input
    .map fn (chars)
      chars.make-group(chars.length / 2).find-dup
    .concat-maybe
    .sum
  print("Problem 1: ")
  println(p1)

  val p2 = input
    .make-group(3)
    .map fn (group)
      find-dup(group)
    .concat-maybe
    .sum
  print("Problem 2: ")
  println(p2)
