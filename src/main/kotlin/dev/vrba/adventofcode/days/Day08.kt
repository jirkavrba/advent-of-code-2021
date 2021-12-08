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

        val all = ('a'..'g')
        val sets = entry.input.map { it.toSet() }
        val solution = all.associateWith { null }.toMutableMap<Char, Char?>()

        val one = sets.first { it.size == segments[1]?.size }
        val four = sets.first { it.size == segments[4]?.size }
        val seven = sets.first { it.size == segments[7]?.size }

        // a = 7 - 1
        solution['a'] = (seven - one.intersect(seven)).first()

        val nine = sets.first { it.size == segments[9]?.size && it.intersect(four).size == 4 }
        val six = sets.first { it.size == segments[6]?.size && it.intersect(one).size == 1 }
        val zero = sets.first { it.size == segments[0]?.size && it != six && it != nine }

        // c = 8 - 6
        // f = 1 - c
        // d = 8 - 0
        // e = 8 - 9
        solution['c'] = (all - six).first()
        solution['f'] = (one - solution['c']).first()
        solution['d'] = (all - zero).first()
        solution['e'] = (all - nine).first()

        val three = sets.first { it.size == segments[3]?.size && one.intersect(it).size == 2 }

        // b = 4 - (c, d, f)
        // g = 8 - the rest
        solution['b'] = (four - three).first()
        solution['g'] = (all - setOf(solution['a'], solution['b'], solution['c'], solution['d'], solution['e'], solution['f'])).first()

        println(solution)
        println(segments)
        println(entry.output.map { output -> output.map { solution[it] }.toSet() })

        return 0
    }

    fun task2(input: List<String>): Int {
        return parseInput(input).sumOf { solve(it) }
    }
}