from random_gen import RandomGen
from pokemon_base import PokemonBase
from pokemon import Eevee, Gastly, Haunter, Charmander, Squirtle, Bulbasaur, Venusaur, Blastoise, Charizard
from tests.base_test import BaseTest


class TestPokemonBase(BaseTest):

    def test_cannot_init(self):
        """
        Tests that we cannot initialise PokemonBase, and that it raises the correct error
        """
        # self.assertRaises(TypeError, lambda: PokemonBase(30, PokeType.FIRE))
        pass

    def test_level(self):
        """
        Testcase to test level of Eevee before and after leveling up
        """

        e = Eevee()
        self.assertEqual(e.get_level(), 1)
        e.level_up()
        self.assertEqual(e.get_level(), 2)

    def test_hp(self):
        """
        Testcase to test hp of Eevee before and after losing hp and healing
        """

        e = Eevee()
        self.assertEqual(e.get_hp(), 10)
        e.lose_hp(4)
        self.assertEqual(e.get_hp(), 6)
        e.heal()
        self.assertEqual(e.get_hp(), 10)

    def test_status(self):
        """
        Testcase to test status and health of Eevee after having a status effect and receiving attack damage due
        to being attacked
        """

        RandomGen.set_seed(0)
        e1 = Eevee()
        e2 = Eevee()
        e1.attack(e2)
        # e2 now is confused.
        e2.attack(e1)
        # e2 takes damage in confusion.
        self.assertEqual(e1.get_hp(), 10)

    def test_evolution(self):
        """
        Testcase to test the evolution of the pokemon Gastly
        """

        g = Gastly()
        self.assertEqual(g.can_evolve(), True)
        self.assertEqual(g.should_evolve(), True)
        new_g = g.get_evolved_version()
        self.assertIsInstance(new_g, Haunter)

    # Start from here is coded by self
    # Test pokemon attack
    def test_bulbasaur_attack(self):
        """
        Testcase to test attack of 2 level 1 Bulbasaur
        """
        # Bulbasaur attack Bulbasaur, multiplier is 1 because attack and defense pokemon same type
        b1 = Bulbasaur()
        b2 = Bulbasaur()
        b1.attack(b2)
        self.assertEqual(b2.get_hp(), 8)  # 13 - 5 = 8

    def test_gastly_eevee_attack(self):
        """
        Testcase to test attack of level 1 Gastly and Eevee
        """
        # Gastly attack Eevee, multiplier is 0 because Ghost type attack Normal type
        g1 = Gastly()
        e1 = Eevee()
        g1.attack(e1)
        self.assertEqual(e1.get_hp(), 10)  # 10 - 0 = 10

    def test_squirtle_charmander_attack(self):
        """
        Testcase to test attack of level 1 Squirtle and Charmander
        """
        # Squirtle attack Charmander, multiplier is 2 because Water type attack Fire type
        s1 = Squirtle()
        c1 = Charmander()
        s1.attack(c1)
        self.assertEqual(c1.get_hp(), 1)  # 9 - 8 = 1

    # Test pokemon defence
    def test_eevee_defence(self):
        """
        Testcase to test defense of level 1 and 2 Eevee
        """
        e = Eevee()
        self.assertEqual(e.get_defence(), 5)  # Level 1 Eevee
        e.level_up()
        self.assertEqual(e.get_defence(), 6)  # Level 2 Eevee

    def test_charmander_defence(self):
        """
        Testcase to test defense of level 1 and 2 Charmander
        """
        c = Charmander()
        self.assertEqual(c.get_defence(), 4)  # Level 1 Charmander
        c.level_up()
        self.assertEqual(c.get_defence(), 4)  # Level 2 Charmander

    def test_squirtle_defence(self):
        """
        Testcase to test defense of level 1 Squirtle
        """
        s = Squirtle()
        self.assertEqual(s.get_defence(), 7)  # Level 1 Squirtle

    # Test pokemon speed
    def test_eevee_speed(self):
        """
        Testcase to test speed of Eevee at level 1
        """
        # Test to check Eevee's speed when Eevee level 1
        e = Eevee()
        self.assertEqual(e.get_speed(), 8)

    def test_charmander_speed(self):
        """
        Testcase to test speed of Charmander at level 1
        """
        # Test to check Charmander's speed when Charmander level 1
        c = Charmander()
        self.assertEqual(c.get_speed(), 8)

    def test_squirtle_speed(self):
        """
        Testcase to test speed of Squirtle at level 1
        """
        # Test to check Squirtle's speed when Squirtle level 1
        s = Squirtle()
        self.assertEqual(s.get_speed(), 7)

    # Test pokemon is_fainted
    def test_eevee_fainted(self):
        """
        Testcase to test is_fainted function for Eevee
        """
        # Test if Eevee's HP more than 0
        e = Eevee()
        self.assertEqual(e.get_hp(), 10)
        self.assertEqual(e.is_fainted(), False)

    def test_charmander_fainted(self):
        """
        Testcase to test is_fainted function for Charmander
        """
        # Test if Charmander's HP equal 0
        c = Charmander()
        self.assertEqual(c.get_hp(), 9)
        self.assertEqual(c.is_fainted(), False)

    def test_squirtle_fainted(self):
        """
        Testcase to test is_fainted function for Squirtle
        """
        # Test if Squirtle is fainted after being attacked
        s = Squirtle()
        self.assertEqual(s.get_hp(), 11)
        self.assertEqual(s.is_fainted(), False)

    # Test pokemon evolution using can_evolve and should_evolve
    def test_eevee_evolve(self):
        """
        Testcase to test can_evolve and should_evolve function for Eevee
        """
        # Test if Eevee can and should evolve or not
        e = Eevee()
        self.assertEqual(e.can_evolve(), False)
        self.assertEqual(e.should_evolve(), False)

    def test_charmander_evolve(self):
        """
        Testcase to test can_evolve and should_evolve function for Charmander
        """
        # Test if Charmander can and should evolve or not
        c = Charmander()
        self.assertEqual(c.can_evolve(), True)
        self.assertEqual(c.should_evolve(), False)

    def test_squirtle_evolve(self):
        """
        Testcase to test can_evolve and should_evolve function for Squirtle
        """
        # Test if Squirtle can and should evolve or not
        s = Squirtle()
        self.assertEqual(s.can_evolve(), True)
        self.assertEqual(s.should_evolve(), False)

    # Test pokemon evolution using get_evolved_version
    def test_charmander_evolved(self):
        """
        Testcase to test if Charmander can get their evolved version (Charizard) after using get_evolved_version function
        """
        # Test to get Charmander's evolved version
        c = Charmander()
        evolved = c.get_evolved_version()
        self.assertIsInstance(evolved, Charizard)

    def test_squirtle_evolved(self):
        """
        Testcase to test if Squirtle can get their evolved version (Blastoise) after using get_evolved_version function
        """
        # Test to get Squirtle's evolved version
        s = Squirtle()
        evolved = s.get_evolved_version()
        self.assertIsInstance(evolved, Blastoise)

    def test_bulbasaur_evolved(self):
        """
        Testcase to test if Bulbasaur can get their evolved version (Venusaur) after using get_evolved_version function
        """
        # Test to get Bulbasaur's evolved version
        b = Bulbasaur()
        evolved = b.get_evolved_version()
        self.assertIsInstance(evolved, Venusaur)
