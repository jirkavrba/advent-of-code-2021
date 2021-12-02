package dev.vrba.adventofcode.days

class Day02 {
    // TODO: Somehow figure out how to manage day descriptions

    data class Submarine(val x: Int = 0, val y: Int = 0, val aim: Int = 0) {
        fun move(x: Int, y: Int): Submarine = copy(x = this.x + x, y = this.y + y)
        fun aim(d: Int): Submarine = copy(aim = this.aim + d)
    }

    fun task1(instructions: List<String>): Int {
        val submarine = Submarine()
        val destination = instructions.fold(submarine) {
            submarine, raw ->
                val (instruction, number) = raw.split(" ")
                val distance = number.toInt()

                when (instruction) {
                    "forward" -> submarine.move(distance, 0)
                    "up" -> submarine.move(0, -distance)
                    "down" -> submarine.move(0, distance)
                    else -> throw IllegalArgumentException("Invalid instruction")
                }
        }

        return destination.x * destination.y
    }

    fun task2(instructions: List<String>): Int {
        val submarine = Submarine()
        val destination = instructions.fold(submarine) {
                submarine, raw ->
            val (instruction, number) = raw.split(" ")
            val distance = number.toInt()

            when (instruction) {
                "forward" -> submarine.move(distance, distance * submarine.aim)
                "up" -> submarine.aim(-distance)
                "down" -> submarine.aim(distance)
                else -> throw IllegalArgumentException("Invalid instruction")
            }
        }

        return destination.x * destination.y
    }
}