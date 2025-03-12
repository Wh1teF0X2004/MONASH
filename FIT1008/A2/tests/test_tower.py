from random_gen import RandomGen
from poke_team import Criterion, PokeTeam
from battle import Battle
from tower import BattleTower, BattleTowerIterator
from tests.base_test import BaseTest

class TestTower(BaseTest):

    def test_creation(self):
        RandomGen.set_seed(51234)
        bt = BattleTower(Battle(verbosity=0))
        bt.set_my_team(PokeTeam.random_team("N", 2, team_size=6, criterion=Criterion.HP))
        bt.generate_teams(4)
        # Teams have 7, 10, 10, 3 lives.
        RandomGen.set_seed(1029873918273)
        results = [
            (1, 6),
            (1, 9),
            (2, 10)
        ]
        it = iter(bt)
        for (expected_res, expected_lives), (res, me, tower, lives) in zip(results, it):
            self.assertEqual(expected_res, res, (expected_res, expected_lives))
            self.assertEqual(expected_lives, lives)

    def test_duplicates(self):
        RandomGen.set_seed(29183712400123)
    
        bt = BattleTower(Battle(verbosity=0))
        bt.set_my_team(PokeTeam.random_team("Jackson", 0, team_size=6))
        bt.generate_teams(10)

        # Team numbers before:
        # [0, 4, 1, 0, 0], 6
        # [1, 0, 2, 0, 0], 5
        # [1, 1, 0, 1, 0], 8
        # [1, 2, 1, 1, 0], 10
        # [0, 0, 2, 1, 1], 8
        # [1, 1, 3, 0, 0], 4
        # [0, 2, 0, 1, 0], 5
        # [1, 0, 0, 4, 0], 3
        # [1, 1, 1, 0, 2], 7
        # [0, 1, 1, 1, 0], 9
        it = iter(bt)
        it.avoid_duplicates()
        # Team numbers after:
        # [1, 1, 0, 1, 0], 8
        # [0, 1, 1, 1, 0], 9

        l = []
        for res, me, tower, lives in bt:
            tower.regenerate_team()
            l.append((res, lives))
        
        self.assertEqual(l, [
            (1, 7),
            (1, 8),
            (2, 7)
        ])
        
    def test_sort_lives(self):
        # 1054 only
        RandomGen.set_seed(9821309123)
    
        bt = BattleTower(Battle(verbosity=0))
        bt.set_my_team(PokeTeam.random_team("Jackson", 1, team_size=6))
        bt.generate_teams(10)

        it = iter(bt)
        # [1, 1, 3, 0, 0] 3 Name: Team 0
        # [2, 1, 0, 1, 0] 2 Name: Team 1
        # [2, 0, 0, 1, 1] 4 Name: Team 2
        # [3, 0, 1, 0, 1] 2 Name: Team 3
        # [0, 0, 2, 1, 2] 4 Name: Team 4
        # [0, 1, 0, 2, 0] 3 Name: Team 5
        # [3, 0, 2, 0, 0] 8 Name: Team 6
        # [0, 0, 2, 1, 0] 4 Name: Team 7
        # [0, 2, 1, 1, 0] 3 Name: Team 8
        # [1, 0, 1, 3, 1] 4 Name: Team 9
        RandomGen.set_seed(123)
        res, me, other_1, lives = next(it)
        it.sort_by_lives()
        # [1, 1, 3, 0, 0] 2 Name: Team 0
        # [2, 1, 0, 1, 0] 2 Name: Team 1
        # [3, 0, 1, 0, 1] 2 Name: Team 3
        # [0, 1, 0, 2, 0] 3 Name: Team 5
        # [0, 2, 1, 1, 0] 3 Name: Team 8
        # [2, 0, 0, 1, 1] 4 Name: Team 2
        # [0, 0, 2, 1, 2] 4 Name: Team 4
        # [0, 0, 2, 1, 0] 4 Name: Team 7
        # [1, 0, 1, 3, 1] 4 Name: Team 9
        # [3, 0, 2, 0, 0] 8 Name: Team 6
        res, me, other_2, lives = next(it)

        self.assertEqual(str(other_1), str(other_2))

    # Test wrote by self
    def test_set_my_team_1(self):
        """ Testcase 1 to check if set_my_team is functioning properly """
        RandomGen.set_seed(51234)
        bt_1 = BattleTower(Battle())
        bt_1.set_my_team(PokeTeam.random_team("XIN theKing", 2, team_size=6, criterion=Criterion.SPD))
        bt_1.generate_teams(4)
        # Teams have 7, 10, 10, 3 lives.
        RandomGen.set_seed(1029873918273)
        the_results = [
            (1, 6),
            (1, 9),
            (2, 10)
        ]
        iterate_bt_1 = iter(bt_1)
        for (expected_result, expected_lives), (res, me, tower, lives) in zip(the_results, iterate_bt_1):
            self.assertEqual(expected_result, res, (expected_result, expected_lives))

    def test_set_my_team_2(self):
        """ Testcase 2 to check if set_my_team is functioning properly """
        RandomGen.set_seed(51234)
        bt_2 = BattleTower(Battle())
        bt_2.set_my_team(PokeTeam.random_team("Ning theAlmighty", 1, team_size=6, criterion=Criterion.DEF))
        bt_2.generate_teams(4)
        # Teams have 7, 10, 10, 3 lives.
        RandomGen.set_seed(1029873918273)
        the_results = [
            (1, 6),
            (1, 9),
            (2, 10)
        ]
        iterate_bt_2 = iter(bt_2)
        for (expected_result, expected_lives), (res, me, tower, lives) in zip(the_results, iterate_bt_2):
            self.assertEqual(expected_result, res, (expected_result, expected_lives))

    def test_set_my_team_3(self):
        """ Testcase 3 to check if set_my_team is functioning properly """
        RandomGen.set_seed(51234)
        bt_3 = BattleTower(Battle())
        bt_3.set_my_team(PokeTeam.random_team("XinNing theSupreme", 1, team_size=6, criterion=Criterion.LV))
        bt_3.generate_teams(4)
        # Teams have 7, 10, 10, 3 lives.
        RandomGen.set_seed(1029873918273)
        the_results = [
            (1, 6),
            (1, 9),
            (2, 10)
        ]
        iterate_bt_3 = iter(bt_3)
        for (expected_result, expected_lives), (res, me, tower, lives) in zip(the_results, iterate_bt_3):
            self.assertEqual(expected_result, res, (expected_result, expected_lives))
    
    def test_generate_team_1(self):
        """ Testcase to test total number of teams generated after calling generate_team method """
        t = BattleTower(Battle())
        RandomGen.set_seed(12)
        t.generate_teams(2) # generate 2 teams
        self.assertEqual(2, len(t.generated_random_teams))

    def test_generate_team_2(self):
        """ Testcase to test total number of teams generated after calling generate_team method """
        t = BattleTower(Battle())
        RandomGen.set_seed(333)
        t.generate_teams(1) # generate 1 teams
        self.assertEqual(1, len(t.generated_random_teams))

    def test_generate_team_3(self):
        """ Testcase to test total number of teams generated after calling generate_team method """
        t = BattleTower(Battle())
        RandomGen.set_seed(999)
        t.generate_teams(5) # generate 2 teams
        self.assertEqual(5, len(t.generated_random_teams))

    def test_next_1(self):
        """ Testcase to test return result of each battle """
        RandomGen.set_seed(39393)
        bt1 = BattleTower(Battle())
        bt1.set_my_team(PokeTeam.random_team("Kaiyan Epic", 1, team_size=6, criterion=Criterion.SPD))
        it = BattleTowerIterator(bt1.my_team)
        actual = it.next(it)
        self.assertEqual(it.next(it),actual)

    def test_next_2(self):
        """ Testcase to test return result of each battle """
        RandomGen.set_seed(321321)
        bt1 = BattleTower(Battle())
        bt1.set_my_team(PokeTeam.random_team("Kaiyan Elite", 1, team_size=3, criterion=Criterion.HP))
        it = BattleTowerIterator(bt1.my_team)
        actual = it.next(it)
        self.assertEqual(it.next(it),actual)

    def test_next_3(self):
        """ Testcase to test return result of each battle """
        RandomGen.set_seed(92805)
        bt1 = BattleTower(Battle())
        bt1.set_my_team(PokeTeam.random_team("Kaiyan Legendary", 1, team_size=5, criterion=Criterion.DEF))
        it = BattleTowerIterator(bt1.my_team)
        actual = it.next(it)
        self.assertEqual(it.next(it),actual)

    def test_iter_1(self):
        """ Testcase 1 to test if __iter__ is properly functioning """
        btb1 = BattleTower(Battle())
        btb1.set_my_team(PokeTeam.random_team("XN theBEST", 0))
        i1 = BattleTowerIterator(btb1.my_team)

        iterate_1 = i1.__iter__()
        for k in iterate_1:
            self.assertEqual(next(i1), k)

    def test_iter_2(self):
        """ Testcase 2 to test if __iter__ is properly functioning """
        btb2 = BattleTower(Battle())
        btb2.set_my_team(PokeTeam.random_team("XN theHero", 1))
        i2 = BattleTowerIterator(btb2.my_team)

        iterate_2 = i2.__iter__()
        for k in iterate_2:
            self.assertEqual(next(i2), k)

    def test_iter_3(self):
        """ Testcase 3 to test if __iter__ is properly functioning """
        btb3 = BattleTower(Battle())
        btb3.set_my_team(PokeTeam.random_team("XN theHeroic", 2))
        i3 = BattleTowerIterator(btb3.my_team)

        iterate_3 = i3.__iter__()
        for k in iterate_3:
            self.assertEqual(next(i3), k)

    def avoid_duplicate_1(self):
        """ Testcase 1 to check if any generated teams have duplicate same type pokemon """
        RandomGen.set_seed(9821309123)
        ad1 = BattleTower(Battle())
        ad1.set_my_team(PokeTeam.random_team("XiN nInGgG", 0, team_size=6))
        ad1.generate_teams(7)
        it1 = iter(ad1)
        # [1, 1, 3, 0, 0] 
        # [2, 1, 0, 1, 0] 
        # [2, 0, 0, 1, 1] 
        # [3, 0, 1, 0, 1] 
        # [0, 0, 2, 1, 2] 
        # [0, 1, 0, 2, 0]  
        # [3, 0, 2, 0, 0] 
        it1.avoid_duplicates()
        # None
        lst1 = []
        for res, me, tower, lives in ad1:
            tower.regenerate_team()
            lst1.append((res, lives))

        self.assertEqual(lst2, None)

    def avoid_duplicate_2(self):
        """ Testcase 2 to check if any generated teams have duplicate same type pokemon """
        RandomGen.set_seed(9821309123)
        ad2 = BattleTower(Battle())
        ad2.set_my_team(PokeTeam.random_team("GodSupreme XinNing", 0, team_size=6))
        ad2.generate_teams(3)
        it2 = iter(ad2)
        # [1, 1, 3, 0, 0] 
        # [2, 1, 0, 1, 0] 
        # [2, 0, 0, 1, 1] 
        it2.avoid_duplicates()
        # None
        lst2 = []
        for res, me, tower, lives in ad2:
            tower.regenerate_team()
            lst1.append((res, lives))

        self.assertEqual(lst2, None)

    def avoid_duplicate_3(self):
        """ Testcase 3 to check if any generated teams have duplicate same type pokemon """
        RandomGen.set_seed(29183712400123)
        ad3 = BattleTower(Battle())
        ad3.set_my_team(PokeTeam.random_team("GodOfKnowledge XinNing", 0, team_size=6))
        ad3.generate_teams(5)
        it3 = iter(ad3)
        # [0, 4, 1, 0, 0]
        # [1, 0, 2, 0, 0]
        # [1, 1, 0, 1, 0]
        # [1, 2, 1, 1, 0]
        # [0, 0, 2, 1, 1]
        it3.avoid_duplicates()
        # [1, 1, 0, 1, 0]
        lst3 = []
        for res, me, tower, lives in ad3:
            tower.regenerate_team()
            lst3.append((res, lives))

        self.assertEqual(lst3, [1, 1, 0, 1, 0])
