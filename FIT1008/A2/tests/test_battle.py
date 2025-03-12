from random_gen import RandomGen
from battle import Battle
from poke_team import Criterion, PokeTeam
from pokemon import Charizard, Charmander, Eevee, Gastly, Squirtle, Venusaur, Bulbasaur
from tests.base_test import BaseTest

class TestBattle(BaseTest):

    def test_basic_battle(self):
        RandomGen.set_seed(1337)
        team1 = PokeTeam("Ash", [1, 1, 1, 0, 0], 0, PokeTeam.AI.ALWAYS_ATTACK)
        team2 = PokeTeam("Gary", [0, 0, 0, 0, 3], 0, PokeTeam.AI.ALWAYS_ATTACK)
        b = Battle(verbosity=0)
        res = b.battle(team1, team2)
        self.assertEqual(res, 1)
        self.assertTrue(team2.is_empty())
        remaining = []
        while not team1.is_empty():
            remaining.append(team1.retrieve_pokemon())
        self.assertEqual(len(remaining), 2)
        self.assertEqual(remaining[0].get_hp(), 1)
        self.assertIsInstance(remaining[0], Venusaur)
        self.assertEqual(remaining[1].get_hp(), 11)
        self.assertIsInstance(remaining[1], Squirtle)

    def test_complicated_battle(self):
        RandomGen.set_seed(192837465)
        team1 = PokeTeam("Brock", [1, 1, 1, 1, 1], 2, PokeTeam.AI.SWAP_ON_SUPER_EFFECTIVE, criterion=Criterion.HP)
        team2 = PokeTeam("Misty", [0, 0, 0, 3, 3], 2, PokeTeam.AI.SWAP_ON_SUPER_EFFECTIVE, criterion=Criterion.SPD)
        b = Battle(verbosity=0)
        res = b.battle(team1, team2)
        self.assertEqual(res, 1)
        remaining = []
        while not team1.is_empty():
            remaining.append(team1.retrieve_pokemon())
        self.assertEqual(len(remaining), 2)
        self.assertEqual(remaining[0].get_hp(), 11)
        self.assertIsInstance(remaining[0], Charizard)
        self.assertEqual(remaining[1].get_hp(), 6)
        self.assertIsInstance(remaining[1], Gastly)

    def test_battle_1(self):
        """ Testcase to test battling between two teams and check stats of remaining Pokemons """
        RandomGen.set_seed(33229749)
        team1 = PokeTeam("SuperKaiyan", [2, 1, 1, 1, 1], 1, PokeTeam.AI.SWAP_ON_SUPER_EFFECTIVE, criterion=Criterion.HP)
        team2 = PokeTeam("OmgKaiyan", [0, 0, 0, 3, 3], 1, PokeTeam.AI.SWAP_ON_SUPER_EFFECTIVE, criterion=Criterion.SPD)
        b = Battle(verbosity=0)
        res = b.battle(team1, team2)
        self.assertEqual(res, 1)
        remaining = []
        while not team1.is_empty():
            remaining.append(team1.retrieve_pokemon())
        self.assertEqual(len(remaining), 2)
        self.assertEqual(remaining[0].get_hp(), 6)
        self.assertIsInstance(remaining[0], Gastly)
        self.assertEqual(remaining[1].get_hp(), 10)
        self.assertIsInstance(remaining[1], Eevee)

    def test_battle_2(self):
        """ Testcase to test battling between two teams and check stats of remaining Pokemons """
        RandomGen.set_seed(7172901)
        team1 = PokeTeam("Kaiyan DoubleKill", [3, 1, 0, 0, 1], 0, PokeTeam.AI.SWAP_ON_SUPER_EFFECTIVE, criterion=Criterion.HP)
        team2 = PokeTeam("Kaiyan TripleKill", [1, 1, 0, 1, 1], 0, PokeTeam.AI.SWAP_ON_SUPER_EFFECTIVE, criterion=Criterion.SPD)
        b = Battle(verbosity=0)
        res = b.battle(team1, team2)
        self.assertEqual(res, 1)
        remaining = []
        while not team1.is_empty():
            remaining.append(team1.retrieve_pokemon())
        self.assertEqual(len(remaining), 2)
        self.assertEqual(remaining[0].get_hp(), 13)
        self.assertIsInstance(remaining[0], Bulbasaur)
        self.assertEqual(remaining[1].get_hp(), 10)
        self.assertIsInstance(remaining[1], Eevee)

    def test_battle_3(self):
        """ Testcase to test battling between two teams and check stats of remaining Pokemons """
        RandomGen.set_seed(2902129102)
        team1 = PokeTeam("Kaiyan MegaKill", [2, 2, 0, 1, 1], 2, PokeTeam.AI.SWAP_ON_SUPER_EFFECTIVE, criterion=Criterion.HP)
        team2 = PokeTeam("Kaiyan Godlike", [1, 1, 1, 1, 1], 2, PokeTeam.AI.SWAP_ON_SUPER_EFFECTIVE, criterion=Criterion.SPD)
        b = Battle(verbosity=0)
        res = b.battle(team1, team2)
        self.assertEqual(res, 1)
        remaining = []
        while not team1.is_empty():
            remaining.append(team1.retrieve_pokemon())
        self.assertEqual(len(remaining), 2)
        self.assertEqual(remaining[0].get_hp(), 9)
        self.assertIsInstance(remaining[0], Charmander)
        self.assertEqual(remaining[1].get_hp(), 6)
        self.assertIsInstance(remaining[1], Gastly)
