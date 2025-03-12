from pokemon import Venusaur, Eevee, Haunter, Charmander, Squirtle, Blastoise
from tests.base_test import BaseTest


class TestPokemon(BaseTest):
    """
    Class to test difference pokemon using different functions
    """

    def test_venusaur_stats(self):
        """
        Testcase to test Venusaur stats
        """

        v = Venusaur()
        self.assertEqual(v.get_hp(), 21)
        self.assertEqual(v.get_level(), 2)
        self.assertEqual(v.get_attack_damage(), 5)
        self.assertEqual(v.get_speed(), 4)
        self.assertEqual(v.get_defence(), 10)
        v.level_up()
        v.level_up()
        v.level_up()
        self.assertEqual(v.get_hp(), 22)
        self.assertEqual(v.get_level(), 5)
        self.assertEqual(v.get_attack_damage(), 5)
        self.assertEqual(v.get_speed(), 5)
        self.assertEqual(v.get_defence(), 10)
        v.lose_hp(5)

        self.assertEqual(str(v), "LV. 5 Venusaur: 17 HP")

    # additional testcase
    def test_eevee_stats(self):
        """
        Testcase to test Eevee stats
        """

        e = Eevee()
        self.assertEqual(e.get_hp(), 10)
        self.assertEqual(e.get_level(), 1)
        self.assertEqual(e.get_attack_damage(), 7)
        self.assertEqual(e.get_speed(), 8)
        self.assertEqual(e.get_defence(), 5)
        e.level_up() # levelled up and change stats accordingly
        self.assertEqual(e.get_hp(), 10)
        self.assertEqual(e.get_level(), 2)
        self.assertEqual(e.get_attack_damage(), 8)
        self.assertEqual(e.get_speed(), 9)
        self.assertEqual(e.get_defence(), 6)
        e.lose_hp(7)
        self.assertEqual(str(e), "LV. 2 Eevee: 3 HP")

    def test_haunter_stats(self):
        """
        Testcase to test Haunter stats
        """

        h = Haunter()
        self.assertEqual(h.get_hp(), 9)
        self.assertEqual(h.get_level(), 1)
        self.assertEqual(h.get_attack_damage(), 8)
        self.assertEqual(h.get_speed(), 6)
        self.assertEqual(h.get_defence(), 6)
        h.level_up() # levelled up and change stats accordingly
        self.assertEqual(h.get_hp(), 10)
        self.assertEqual(h.get_level(), 2)
        self.assertEqual(h.get_attack_damage(), 8)
        self.assertEqual(h.get_speed(), 6)
        self.assertEqual(h.get_defence(), 6)
        h.lose_hp(7)
        self.assertEqual(str(h), "LV. 2 Haunter: 3 HP")

    def test_blastoise_stats(self):
        """
        Testcase to test Blastoise stats
        """

        b = Blastoise()
        self.assertEqual(b.get_hp(), 21)
        self.assertEqual(b.get_level(), 3)
        self.assertEqual(b.get_attack_damage(), 9)
        self.assertEqual(b.get_speed(), 10)
        self.assertEqual(b.get_defence(), 11)
        b.level_up()
        b.level_up()
        # levelled up and change stats accordingly 
        self.assertEqual(b.get_hp(), 25)
        self.assertEqual(b.get_level(), 5)
        self.assertEqual(b.get_attack_damage(), 10)
        self.assertEqual(b.get_speed(), 10)
        self.assertEqual(b.get_defence(), 13)
        b.lose_hp(14)
        self.assertEqual(str(b), "LV. 5 Blastoise: 11 HP")
