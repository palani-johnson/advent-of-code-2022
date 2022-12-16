module day5

import src/lib
import std/text/regex

struct move
  num : int
  from : int
  to : int

alias stacks = list<list<char>>
alias moves = list<move>

fun parse-stacks(input : string) : <exn> stacks
  val lines = input
    .split("\n")
    .reverse
    .map fn (line) line.list

  val char-indexes = list(1, lines.head.unjust.length, 4)
  val stack-indexes = lines.tail.map-indexed fn (index, _) index + 1

  char-indexes.map fn (char-index)
    stack-indexes
      .map fn (stack-index)
        match (lines[stack-index].unjust)[char-index]
          Just(char) ->
            if char == ' ' then
              Nothing
            else
              Just(char)
          Nothing -> Nothing
      .concat-maybe
      .reverse

fun parse-moves(input : string) : <exn> moves
  with line <- input.trim.split("\n").map
  val [col, from, to] = line
    .split(" ")
    .map fn (str) { str.parse-int }
    .concat-maybe

  Move(col, from, to)

fun parse-input(input : string) : <exn> (stacks, moves)
  val [stacks, moves] = input.split("\n\n")

  (parse-stacks(stacks), parse-moves(moves))

fun rearrange(
  stacks : stacks,
  moves : moves,
  pickup-fn : (list<char>) -> list<char> = reverse
) : <exn> stacks
  match moves
    Cons(move, other-moves) ->
      val from-stack = stacks[move.from - 1].unjust
      val to-stack = stacks[move.to - 1].unjust

      val (moving, new-from-stack) = from-stack.split(move.num)

      stacks
        .map-indexed fn (index, stack)
          if index == move.from - 1 then
            new-from-stack
          else if index == move.to - 1 then
            moving.pickup-fn ++ to-stack
          else
            stack
        .rearrange(other-moves, pickup-fn)
    Nil -> stacks

fun show-stack-heads(stacks : stacks) : <exn> string
  stacks
    .map fn (stack) { [stack.head.unjust].string }
    .join

pub fun main()
  val (stacks, moves) = get-input("5").parse-input

  var p1 := stacks.rearrange(moves).show-stack-heads
  println("Problem 1: " ++ p1)

  var p2 := stacks.rearrange(moves, id).show-stack-heads
  println("Problem 1: " ++ p2)

