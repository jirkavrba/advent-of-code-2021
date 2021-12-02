package dev.vrba.adventofcode.days

import dev.vrba.adventofcode.Resources.readResourceLines
import jdk.jfr.Name
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

@Name("Day 2")
class Day02Tests {

    private val instance = Day02()

    @Test
    @DisplayName("Part 1 example")
    fun testTask1Example() {
        val input = listOf(
            "forward 5",
            "down 5",
            "forward 8",
            "up 3",
            "down 8",
            "forward 2",
        )
        val result = instance.task1(input)

        assertEquals(150, result)
    }

    @Test
    @DisplayName("Part 1 input")
    fun testTask1Input() {
        val input = readResourceLines("day02.txt")
        val result = instance.task1(input)

        assertEquals(1813801, result)
    }

    @Test
    @DisplayName("Part 2 example")
    fun testTask2Example() {
        val input = listOf(
            "forward 5",
            "down 5",
            "forward 8",
            "up 3",
            "down 8",
            "forward 2",
        )
        val result = instance.task2(input)

        assertEquals(900, result)
    }

    @Test
    @DisplayName("Part 2 input")
    fun testTask2Input() {
        val input = readResourceLines("day02.txt")
        val result = instance.task2(input)

        assertEquals(1960569556, result)
    }
}