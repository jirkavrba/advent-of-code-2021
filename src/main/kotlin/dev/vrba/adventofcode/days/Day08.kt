package dev.vrba.adventofcode.days

class Day08 {

    data class Entry(val input: List<String>, val output: List<String>)

    private val segments = mapOf(
        0 to setOf('a', 'b', 'c', 'e', 'f', 'g'),
        1 to setOf('c', 'f'),
        2 to setOf('a', 'c', 'd', 'e', 'g'),
        3 to setOf('a', 'c', 'd', 'f', 'g'),
        4 to setOf('b', 'c', 'd', 'f'),
        5 to setOf('a', 'b', 'd', 'f', 'g'),
        6 to setOf('a', 'b', 'd', 'e', 'f', 'g'),
        7 to setOf('a', 'c', 'f'),
        8 to setOf('a', 'b', 'c', 'd', 'e', 'f', 'g'),
        9 to setOf('a', 'b', 'c', 'd', 'f', 'g'),
    )

    private fun parseInput(entries: List<String>): List<Entry> {
        return entries.map {
            val (input, output) = it.split("|")
                .map { part ->
                    part
                        .trim()
                        .split("\\s+".toRegex())
                }

            Entry(input, output)
        }
    }

    fun task1(input: List<String>): Int {
        val lengths = setOf(1, 4, 7, 8).map { segments[it]?.size }

        return parseInput(input)
            .map { it.output }
            .flatten()
            .count { it.length in lengths }
    }

    private fun solve(entry: Entry): Int {
        // Yo this is some seriously ugly-ass shit code
        val sets = entry.input.map { it.toSet() }

        // Those number sets can be determined by length
        val one = sets.first { it.size == 2 }
        val four = sets.first { it.size == 4 }
        val seven = sets.first { it.size == 3 }
        val eight = sets.first { it.size == 7 }

        val solution = eight.associateWith { null }.toMutableMap<Char, Char?>()

        solution['a'] = (seven - one).first()

        val nine = sets.first { it.size == 6 && it.intersect(four).size == segments[4]?.size }
        val six = sets.first { it.size == 6 && it.intersect(seven).size == 2 }
        val zero = sets.first { it.size == 6 && it != nine && it != six }

        solution['e'] = (eight - nine).first()
        solution['d'] = (eight - zero).first()
        solution['c'] = (eight - six).first()
        solution['f'] = (one - solution['c']).first()
        solution['b'] = (four - solution['c'] - solution['d'] - solution['f']).first()
        solution['g'] = (eight - solution.values.toSet()).first()

        val lookup = segments.map { (k, v) -> v.sorted().joinToString("") to k }.toMap()
        val translation = solution.map { (k, v) -> v to k }.toMap()
        val translated = entry.output
            .map { output -> output.map { translation[it] }.sortedBy { it }.joinToString("") }
            .mapNotNull { lookup[it] }
            .joinToString("")
            .toInt()

        return translated
    }

    fun task2(input: List<String>): Int {
        return parseInput(input).sumOf { solve(it) }
    }
}