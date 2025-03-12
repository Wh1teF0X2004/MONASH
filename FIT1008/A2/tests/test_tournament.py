from random_gen import RandomGen
from tournament import Tournament
from battle import Battle
from tests.base_test import BaseTest

class TestTournament(BaseTest):

    def test_creation(self):
        t = Tournament(Battle(verbosity=0))
        t.set_battle_mode(1)
        self.assertRaises(ValueError, lambda: t.start_tournament("Roark Gardenia + Maylene Crasher_Wake + + + Fantina Byron + Candice Volkner + + +"))
        t.start_tournament("Roark Gardenia + Maylene Crasher_Wake + Fantina Byron + + + Candice Volkner + +")

    def test_random(self):
        RandomGen.set_seed(123456)
        t = Tournament(Battle(verbosity=0))
        t.set_battle_mode(0)
        t.start_tournament("Roark Gardenia + Maylene Crasher_Wake + Fantina Byron + + + Candice Volkner + +")

        team1, team2, res = t.advance_tournament() # Roark vs Gardenia
        self.assertEqual(res, 1)
        self.assertTrue(str(team1).startswith("Roark"))
        self.assertTrue(str(team2).startswith("Gardenia"))

        team1, team2, res = t.advance_tournament() # Maylene vs Crasher_Wake
        self.assertEqual(res, 1)
        self.assertTrue(str(team1).startswith("Maylene"))
        self.assertTrue(str(team2).startswith("Crasher_Wake"))

        team1, team2, res = t.advance_tournament() # Fantina vs Byron
        self.assertEqual(res, 1)
        self.assertTrue(str(team1).startswith("Fantina"))
        self.assertTrue(str(team2).startswith("Byron"))

        team1, team2, res = t.advance_tournament() # Maylene vs Fantina
        self.assertEqual(res, 2)
        self.assertTrue(str(team1).startswith("Maylene"))
        self.assertTrue(str(team2).startswith("Fantina"))

        team1, team2, res = t.advance_tournament() # Roark vs Fantina
        self.assertEqual(res, 1)
        self.assertTrue(str(team1).startswith("Roark"))
        self.assertTrue(str(team2).startswith("Fantina"))

        team1, team2, res = t.advance_tournament() # Candice vs Volkner
        self.assertEqual(res, 1)
        self.assertTrue(str(team1).startswith("Candice"))
        self.assertTrue(str(team2).startswith("Volkner"))

        team1, team2, res = t.advance_tournament() # Roark vs Candice
        self.assertEqual(res, 2)
        self.assertTrue(str(team1).startswith("Roark"))
        self.assertTrue(str(team2).startswith("Candice"))

    def test_metas(self):
        RandomGen.set_seed(123456)
        t = Tournament(Battle(verbosity=0))
        t.set_battle_mode(0)
        t.start_tournament("Roark Gardenia + Maylene Crasher_Wake + Fantina Byron + + + Candice Volkner + +")
        l = t.linked_list_with_metas()
        # Roark = [0, 2, 1, 1, 1]
        # Garderia = [0, 0, 2, 0, 1]
        # Maylene = [6, 0, 0, 0, 0]
        # Crasher_Wake = [0, 2, 0, 1, 0]
        # Fantina = [0, 0, 1, 1, 1]
        # Byron = [0, 2, 0, 0, 1]
        # Candice = [2, 2, 1, 0, 0]
        # Volkner = [0, 5, 0, 0, 0]
        expected = [
            [],
            [],
            ['FIRE'], # Roark Fantina do not have Fire types, but Maylene does (lost to Fantina)
            ['GRASS'], # Maylene Fantina do not have Grass types, but Byron/Crasher_Wake does (lost to Fantina/Maylene)
            [],
            [],
            [],
        ]
        for x in range(len(l)):
            team1, team2, types = l[x]
            self.assertEqual(expected[x], types)

    def test_battle_mode_1(self):
        """ Testcase to test set_battle_mode when it is set to 0 """
        s = Tournament(Battle(verbosity=0))
        s.battle_mode = 0
        self.assertEqual(0,s.get_battle_mode())

    def test_battle_mode_2(self):
        """ Testcase to test set_battle_mode when it is set to 1 """
        q = Tournament(Battle(verbosity=0))
        q.battle_mode = 1
        self.assertEqual(1,q.get_battle_mode())

    def test_battle_mode_3(self):
        """ Testcase to test set_battle_mode when it is set to 2 """
        r = Tournament(Battle(verbosity=0))
        r.battle_mode = 2
        self.assertEqual(2,r.get_battle_mode())

    def test_valid_tournament_1(self):
        """ Testcase to test is_valid_tournament for tournament_str that is passed in """
        a = Tournament()
        # should be False as there is only one player in first match
        self.assertFalse(
            a.is_valid_tournament("Roark + Maylene Crasher_Wake + Fantina Byron + + + Candice Volkner + +"))

    def test_valid_tournament_2(self):
        """ Testcase to test is_valid_tournament for tournament_str that is passed in """
        b = Tournament()
        # should be False as there is no player in first match
        self.assertFalse(
            b.is_valid_tournament("+ Maylene Crasher_Wake +"))

    def test_valid_tournament_3(self):
        """ Testcase to test is_valid_tournament for tournament_str that is passed in """
        c = Tournament()
        # should be False as there are three players in second match
        self.assertFalse(
            c.is_valid_tournament("Levi Ackerman + + Miya Atsuma Legend + Fantina + + + Candice + +"))

    def test_num_of_games_1(self):
        """ Testcase to test number of games for each tournament_str """
        t = Tournament()
        t.count_number_of_games("Pizza Pineapple + +")
        self.assertEqual(2, t.total_matches)

    def test_num_of_games_2(self):
        """ Testcase to test number of games for each tournament_str """
        t = Tournament()
        t.count_number_of_games("Yasimola Abahaba +")
        self.assertEqual(1, t.total_matches)

    def test_num_of_games_3(self):
        """ Testcase to test number of games for each tournament_str """
        t = Tournament()
        t.count_number_of_games("Naruto Kakashi + + +")
        self.assertEqual(3, t.total_matches)

    def test_start_tournament_1(self):
        """ Testcase to test number of tournaments for each tournament_str """
        t = Tournament()
        t.set_battle_mode(1)
        t.start_tournament("Jack Jackson +")
        self.assertEqual(len(t.all_teams), 1)

    def test_start_tournament_2(self):
        """ Testcase to test number of tournaments for each tournament_str """
        t = Tournament()
        t.set_battle_mode(0)
        t.start_tournament("Emma Watson + Jill Kenny + +")
        self.assertEqual(len(t.all_teams), 3)

    def test_start_tournament_3(self):
        """ Testcase to test number of tournaments for each tournament_str """
        t = Tournament()
        t.set_battle_mode(1)
        t.start_tournament("Elise theGreat + Alicia theBest + +")
        self.assertEqual(len(t.all_teams), 3)

    def test_advance_tournament_1(self):
        """ Testcase to test battle of the tournament, following the order of the previously given tournament string """
        t = Tournament(Battle(verbosity=3))
        t.set_battle_mode(1)
        t.start_tournament("XinNing theOK +")
        team1, team2, res = t.advance_tournament()  # XinNing's Team, theOK's Team
        self.assertEqual(team1, "XinNing")
        self.assertEqual(team2, "theOK")

    def test_advance_tournament_2(self):
        """ Testcase to test battle of the tournament, following the order of the previously given tournament string """
        t = Tournament(Battle(verbosity=3))
        t.set_battle_mode(0)
        t.start_tournament("KaiYan theQueen +")
        team1, team2, res = t.advance_tournament()  # KaiYan's Team, theQueen's Team
        self.assertEqual(team1, "KaiYan")
        self.assertEqual(team2, "theQueen")

    def test_advance_tournament_3(self):
        """ Testcase to test battle of the tournament, following the order of the previously given tournament string """
        t = Tournament(Battle(verbosity=3))
        t.set_battle_mode(0)
        t.start_tournament("GoodTeam NiceTeam +")
        team1, team2, res = t.advance_tournament()  # GoodTeam's Team, NiceTeam's Team
        self.assertEqual(team1, "GoodTeam")
        self.assertEqual(team2, "NiceTeam")

    def test_linked_list_of_games_1(self):
        """ Testcase to test return result of the battle """
        RandomGen.set_seed(666)
        t = Tournament(Battle(verbosity=0))
        t.set_battle_mode(0)
        t.start_tournament("abc def +")
        g = t.linked_list_of_games()
        self.assertEqual(g,("abc","def"))

    def test_linked_list_of_games_2(self):
        """ Testcase to test return result of the battle """
        RandomGen.set_seed(555)
        t = Tournament(Battle(verbosity=0))
        t.set_battle_mode(0)
        t.start_tournament(":)) ((: +")
        g = t.linked_list_of_games()
        self.assertEqual(g, (":))", "((:"))

    def test_linked_list_of_games_3(self):
        """ Testcase to test return result of the battle """
        RandomGen.set_seed(123)
        t = Tournament(Battle(verbosity=0))
        t.set_battle_mode(0)
        t.start_tournament("Alex Rider +")
        g = t.linked_list_of_games()
        self.assertEqual(g, ("Alex", "Rider"))

    def test_meta_1(self):
        """ Testcase to test return tuple for each match of the tournament"""
        RandomGen.set_seed(123456)
        t = Tournament(Battle(verbosity=0))
        t.set_battle_mode(1)
        t.start_tournament("Arbiter Vildred + Spectre Tenebria + Commander Pavel + + + Mort theDragon + +")
        l = t.linked_list_with_metas()
        # Arbiter = [0, 2, 1, 1, 1]
        # Vildred = [0, 0, 2, 0, 1]
        # Spectre = [6, 0, 0, 0, 0]
        # Tenebria = [0, 2, 0, 1, 0]
        # Commander = [0, 0, 1, 1, 1]
        # Pavel = [0, 2, 0, 0, 1]
        # Mort = [2, 2, 1, 0, 0]
        # theDragon = [0, 5, 0, 0, 0]
        expected = [
            [],
            [],
            ['FIRE'],  # Arbiter Commander do not have Fire types, but Spectre does (lost to Commander)
            ['GRASS'],
            # Spectre Commander do not have Grass types, but Pavel/Tenebria does (lost to Commander/Spectre)
            [],
            [],
            [],
        ]
        for x in range(len(l)):
            team1, team2, types = l[x]
            self.assertEqual(expected[x], types)

    def test_meta_2(self):
        """ Testcase to test return tuple for each match of the tournament"""
        RandomGen.set_seed(123456)
        t = Tournament(Battle(verbosity=0))
        t.set_battle_mode(2)
        t.start_tournament("Violet Kayron + Sigret Destina + Moon Balmond + + + Granger Lesley + +")
        l = t.linked_list_with_metas()
        # Violet = [0, 2, 1, 1, 1]
        # Kayron = [0, 0, 2, 0, 1]
        # Sigret = [6, 0, 0, 0, 0]
        # Destina = [0, 2, 0, 1, 0]
        # Moon = [0, 0, 1, 1, 1]
        # Balmond = [0, 2, 0, 0, 1]
        # Granger = [2, 2, 1, 0, 0]
        # Lesley = [0, 5, 0, 0, 0]
        expected = [
            [],
            [],
            ['FIRE'],  # Violet Moon do not have Fire types, but Sigret does (lost to Moon)
            ['GRASS'],
            # Sigret Moon do not have Grass types, but Balmond/Destina does (lost to Moon/Sigret)
            [],
            [],
            [],
        ]
        for x in range(len(l)):
            team1, team2, types = l[x]
            self.assertEqual(expected[x], types)

    def test_balance(self):
        # 1054
        t = Tournament()
        self.assertFalse(t.is_balanced_tournament("Roark Gardenia + Maylene Crasher_Wake + Fantina Byron + + + Candice Volkner + +"))
