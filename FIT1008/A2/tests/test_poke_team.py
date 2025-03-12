from poke_team import Action, Criterion, PokeTeam
from random_gen import RandomGen
from pokemon import Bulbasaur, Charizard, Charmander, Gastly, Squirtle, Eevee
from base_test import BaseTest


class TestPokeTeam(BaseTest):

    def test_random(self):
        """
        Testcase to test class method random_team
        """
        RandomGen.set_seed(123456789)
        t = PokeTeam.random_team("Cynthia", 0)
        pokemon = []
        while not t.is_empty():
            pokemon.append(t.retrieve_pokemon())
        expected_classes = [Squirtle, Gastly, Eevee, Eevee, Eevee, Eevee]
        self.assertEqual(len(pokemon), len(expected_classes))
        for p, e in zip(pokemon, expected_classes):
            self.assertIsInstance(p, e)

    def test_regen_team(self):
        """
        Testcase to test regenerate_team function
        """
        RandomGen.set_seed(123456789)
        t = PokeTeam.random_team("Cynthia", 2, team_size=4, criterion=Criterion.HP)

        # This should end, since all pokemon are fainted, slowly.
        while not t.is_empty():
            p = t.retrieve_pokemon()
            p.lose_hp(1)
            t.return_pokemon(p)

        t.regenerate_team()
        pokemon = []
        while not t.is_empty():
            pokemon.append(t.retrieve_pokemon())
        expected_classes = [Bulbasaur, Eevee, Charmander, Gastly]
        self.assertEqual(len(pokemon), len(expected_classes))
        for p, e in zip(pokemon, expected_classes):
            self.assertIsInstance(p, e)

    def test_battle_option_attack(self):
        """
        Testcase to test choose_battle_option function chosen from AI class
        This testcase test on option ALWAYS_ATTACK
        """

        t = PokeTeam("Wallace", [1, 0, 0, 0, 0], 1, PokeTeam.AI.ALWAYS_ATTACK)
        p = t.retrieve_pokemon()
        e = Eevee()
        self.assertEqual(t.choose_battle_option(p, e), Action.ATTACK)

    def test_special_mode_1(self):
        """
        Testcase to test special function special mode of battle mode 1
        """

        t = PokeTeam("Lance", [1, 1, 1, 1, 1], 1, PokeTeam.AI.ALWAYS_ATTACK)
        # C B S G E
        t.special()
        # S G E B C
        pokemon = []
        while not t.is_empty():
            pokemon.append(t.retrieve_pokemon())
        expected_classes = [Squirtle, Gastly, Eevee, Bulbasaur, Charmander]
        self.assertEqual(len(pokemon), len(expected_classes))
        for p, e in zip(pokemon, expected_classes):
            self.assertIsInstance(p, e)

    def test_string(self):
        """
        Testcase to test string representation of PokeTeam class
        """
        t = PokeTeam("Dawn", [1, 1, 1, 1, 1], 2, PokeTeam.AI.RANDOM, Criterion.DEF)
        self.assertEqual(str(t),
                         "Dawn (2): [LV. 1 Gastly: 6 HP, LV. 1 Squirtle: 11 HP, LV. 1 Bulbasaur: 13 HP, LV. 1 Eevee: 10 HP, LV. 1 Charmander: 9 HP]")

    # Extra testcase wrote by self start from here
    def test_is_empty_1(self):
        """
        Testcase to test is_empty function when PokeTeam is not empty
        """
        # When the PokeTeam is not empty, filled with pokemons
        s = PokeTeam("Sigret", [1, 1, 1, 1, 1], 1, PokeTeam.AI.SWAP_ON_SUPER_EFFECTIVE)
        self.assertEqual(s.is_empty(), False)

    def test_is_empty_2(self):
        """
        Testcase to test is_empty function when PokeTeam is empty
        """
        # When the PokeTeam is not empty
        m = PokeTeam("Momo", [1, 0, 0, 0, 0], 0, PokeTeam.AI.ALWAYS_ATTACK)  # one Charmander
        c = m.retrieve_pokemon()
        c.lose_hp(20)  # Charmander is now fainted
        m.return_pokemon(c)  # Charmander could not return to the team
        self.assertEqual(m.is_empty(), True)

    def test_is_empty_3(self):
        """
        Testcase to test is_empty function when PokeTeam is partially empty
        """
        # When the PokeTeam is partially filled with pokemons
        l = PokeTeam("Lua", [2, 1, 1, 0, 1], 2, PokeTeam.AI.RANDOM, Criterion.HP)
        self.assertEqual(l.is_empty(), False)

    def test_retrieve_pokemon_1(self):
        """
        Testcase to test retrieve_pokemon
        """
        r = PokeTeam("Roana", [0, 2, 2, 0, 1], 1, PokeTeam.AI.RANDOM)
        # B B S S E
        pokemon_r = []
        while not r.is_empty():
            pokemon_r.append(r.retrieve_pokemon())
        expected_classes = [Bulbasaur, Bulbasaur, Squirtle, Squirtle, Eevee]
        self.assertEqual(len(pokemon_r), len(expected_classes))
        r.retrieve_pokemon() # retrieve one pokemon, length of team decrease by one
        after_retrieve = [Bulbasaur, Squirtle, Squirtle, Eevee, None]
        self.assertEqual(len(pokemon_r), len(after_retrieve))

    def test_retrieve_pokemon_2(self):
        """
        Testcase to test retrieve_pokemon
        """
        b = PokeTeam("Bellona", [0, 0, 0, 5, 0], 1, PokeTeam.AI.RANDOM)
        # G G G G G
        pokemon_b = []
        while not b.is_empty():
            pokemon_b.append(b.retrieve_pokemon())
        expected_classes = [Gastly, Gastly, Gastly, Gastly, Gastly]
        self.assertEqual(len(pokemon_b), len(expected_classes))
        b.retrieve_pokemon() # retrieve one pokemon, length of team decrease by one
        after_retrieve = [Gastly, Gastly, Gastly, Gastly, None]
        self.assertEqual(len(pokemon_b), len(after_retrieve))

    def test_retrieve_pokemon_3(self):
        """
        Testcase to test retrieve_pokemon
        """
        f = PokeTeam("Flan", [0, 2, 3, 0, 0], 1, PokeTeam.AI.RANDOM)
        # B B S S S
        pokemon_f = []
        while not f.is_empty():
            pokemon_f.append(f.retrieve_pokemon())
        expected_classes = [Bulbasaur, Bulbasaur, Squirtle, Squirtle, Squirtle]
        self.assertEqual(len(pokemon_f), len(expected_classes))
        f.retrieve_pokemon() # retrieve one pokemon, length of team decrease by one
        after_retrieve = [Bulbasaur, Squirtle, Squirtle, Squirtle, None]
        self.assertEqual(len(pokemon_f), len(after_retrieve))

    def test_return_pokemon_1(self):
        """
        Testcase to test return_pokemon
        """
        v = PokeTeam("Vildred", [2, 0, 0, 2, 1], 0, PokeTeam.AI.RANDOM)
        # C C G G E
        pokemon_v = []
        for num in range(2): # load 2 Pokemons and lose hp
            # Expected: First Charmander, First Charmander -> faint
            c = v.retrieve_pokemon()
            c.lose_hp(7) # First Charmander fainted at second iteration
            pokemon_v.append(v.return_pokemon(c)) # First Charmander did not get append at second iteration

        expected_classes = [Charmander, Gastly, Gastly, Eevee]  # Pokemon that survive
        self.assertEqual(v.get_total_pokemons(), len(expected_classes))

    def test_return_pokemon_2(self):
        """
        Testcase to test return_pokemon
        """
        v = PokeTeam("Ackerman", [2, 0, 0, 2, 1], 1, PokeTeam.AI.RANDOM)
        # C C G G E
        c = v.retrieve_pokemon()  # First Charmander
        c.lose_hp(2)  # Charmander lose 2 hp
        v.return_pokemon(c) # not fainted, return to team

        expected_classes = [Charmander, Charmander, Gastly, Gastly, Eevee]  # Pokemon that survive
        self.assertEqual(v.get_total_pokemons(), len(expected_classes))

    def test_return_pokemon_3(self):
        """
        Testcase to test return_pokemon
        """
        v = PokeTeam("Mikasa", [0, 0, 0, 1, 1], 2, PokeTeam.AI.RANDOM, Criterion.DEF)
        # C C G G E
        c = v.retrieve_pokemon()  # retrieve Gastly
        c.lose_hp(12)  # Gastly lose 12 hp
        v.return_pokemon(c) # did not get return to team

        expected_classes = [Eevee]  # Pokemon that survive
        self.assertEqual(v.get_total_pokemons(), len(expected_classes))

    def test_special_mode_0(self):
        """
        Testcase to test special function special mode of battle mode 0
        """
        d = PokeTeam("Diene", [1, 1, 1, 0, 2], 0, PokeTeam.AI.RANDOM)
        # C B S E E
        d.special() # swap first and last Pokemon
        # E B S E C
        pokemon_d = []
        while not d.is_empty():
            pokemon_d.append(d.retrieve_pokemon())
        expected_classes = [Eevee, Bulbasaur, Squirtle, Eevee, Charmander]
        self.assertEqual(len(pokemon_d), len(expected_classes))
        for p, e in zip(pokemon_d, expected_classes):
            self.assertIsInstance(p, e)

    def test_special_mode_2(self):
        """
        Testcase to test special function special mode of battle mode 2
        """
        i = PokeTeam("Iseria", [0, 0, 5, 0, 0], 2, PokeTeam.AI.RANDOM, Criterion.HP)
        # S S S S S
        i.special() # sort Pokemons in team by HP 
        # S S S S S
        pokemon_i = []
        while not i.is_empty():
            pokemon_i.append(i.retrieve_pokemon())
        expected_classes = [Squirtle, Squirtle, Squirtle, Squirtle, Squirtle]
        self.assertEqual(len(pokemon_i), len(expected_classes))

        # sort by HP
        for p, e in zip(pokemon_i, expected_classes):
            self.assertIsInstance(p, e)

    def test_battle_option_random_1(self):
        """
        Testcase to test choose_battle_option function chosen from AI class
        This testcase test on option RANDOM
        """
        a = PokeTeam("Aravi", [0, 0, 0, 0, 1], 1, PokeTeam.AI.RANDOM)
        p = a.retrieve_pokemon()
        e = Eevee()
        if PokeTeam.AI.RANDOM == Action.HEAL:
            self.assertEqual(a.choose_battle_option(p, e), Action.HEAL)
        elif PokeTeam.AI.RANDOM == Action.ATTACK:
            self.assertEqual(a.choose_battle_option(p, e), Action.ATTACK)
        elif PokeTeam.AI.RANDOM == Action.SPECIAL:
            self.assertEqual(a.choose_battle_option(p, e), Action.SPECIAL)
        elif PokeTeam.AI.RANDOM == Action.SWAP:
            self.assertEqual(a.choose_battle_option(p, e), Action.SWAP)

    def test_battle_option_random_2(self):
        """
        Testcase to test choose_battle_option function chosen from AI class
        This testcase test on option RANDOM
        """

        a = PokeTeam("Aurius", [0, 0, 0, 0, 1], 1, PokeTeam.AI.RANDOM)
        p = a.retrieve_pokemon()
        e = Eevee()
        battle_option = a.choose_battle_option(p, e)

        # A list of valid battle options
        valid_battle_options = [Action.HEAL, Action.SWAP, Action.ATTACK, Action.SPECIAL]

        # First check whether the return battle option is valid
        self.assertIn(battle_option, valid_battle_options)

        # Heal should be removed from the options after my_pokemon had 3 heals
        # So if my_pokemon's heal count is >= 3 the battle option cannot be Action.HEAL
        if p.heal_count >= 3:
            self.assertNotEqual(battle_option, Action.HEAL)

    def test_battle_option_swap_effective(self):
        """
        Testcase to test choose_battle_option function chosen from AI class
        This testcase test on option SWAP_ON_SUPER_EFFECTIVE
        """
        j = PokeTeam("Jeno", [0, 0, 0, 0, 1], 1, PokeTeam.AI.SWAP_ON_SUPER_EFFECTIVE)
        p = j.retrieve_pokemon()
        e = Eevee()
        if PokeTeam.AI.SWAP_ON_SUPER_EFFECTIVE == Action.SWAP:
            self.assertEqual(j.choose_battle_option(p, e), Action.SWAP)

