module get-input

import std/os/file
import std/os/path

pub fun get-input(problem: string)
  val input-path = path(".local/inputs/day" ++ problem ++ ".txt")
  read-text-file(input-path)

