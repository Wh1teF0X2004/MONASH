"""
This module splits total amount of PokeTeams into half and winner of each half will battle against each other using
 functions from Battle to get the absolute winner of all the PokeTeams in the tournament.
All functions, unless stated otherwise, have a constant best / worst case complexity of O(1).
"""

# Import libraries
from __future__ import annotations
from poke_team import PokeTeam
from battle import Battle
from linked_list import LinkedList
from linked_queue import LinkQueue

__author__ = "Scaffold by Jackson Goerner, Code by Chew Xin Ning, Foo Kai Yan, Gan Kai Xin and Alicia Chik Wen Quek"


class Tournament:
    """ To create a tournament, where randomly generated PokeTeams face off against one another in a tournament
         based on a string describing the draw

        Attributes:
            battle = Battle instance
            total_plus = Keep count the total number of tournament match
            all_teams = All the generated teams
            all_teams_name = All the tournament teams' name obtained from tournament_str
            tournament_str = The tournament string provided by user
            battle_mode = Battle mode for each tournament match
            current_tournament_match = Keep count on the current tournament match

        Methods:
            set_battle_mode = Set the battle mode for all randomly generated teams
            is_valid_tournament = Check if the tournament_str passed represents a valid tournament.
            start_tournament = Generates teams based on the tournament_str
            advance_tournament = Simulates one battle of the tournament, following the order of given tournament_str
            linked_list_of_games = A linked list, containing a tuple for each match of the tournament
            linked_list_with_metas = A Linked list containing list of strings representing PokeTypes which are not
                                     present in either PokeTeam
    """

    # For example, ("Roark Gardenia + Maylene Crasher_Wake + + Fantina Bryon + + + Candice Volkner + +")
    # where "+" represent a game, and the remaining player from the upper bracket will play off against
    # the remaining player from the lower bracket

    def __init__(self, battle: Battle | None = None) -> None:
        """ Initialisation of tournament class, return None

            :param arg1: battle instance
            :complexity:
        """

        self.total_matches = 0  # Instance variable to keep count the total number of games
        self.all_teams = LinkedList()  # Instance variable to keep all the generated teams
        self.all_teams_name = LinkQueue()  # Instance variable to keep all the generated teams name
        self.tournament_str = None  # Instance variable to keep the given tournament_str
        self.battle_mode = None  # Instance variable to keep the battle_mode
        self.current_tournament_match = -1  # Instance variable to keep count on the current tournament match
        self.battle = battle
        self.player1 = None
        self.player2 = None
        if self.battle is None:
            # Create new Battle instance if given None
            self.battle = Battle()
        # battle instance can be passed in, which all tournament games will be run with.

    def get_battle_mode(self) -> int:
        """ Return battle mode of the team """
        return self.battle_mode

    def set_battle_mode(self, battle_mode: int) -> None:
        """ Set the battle mode for all randomly generated teams, return None """
        # Called before start_tournament
        self.battle_mode = battle_mode

    def is_valid_tournament(self, tournament_str: str) -> bool:
        """ Check if the tournament_str passed represents a valid tournament, return boolean """

        tournament_team_name = LinkQueue()
        for item in tournament_str:
            if item == "+":
                try:
                    # try to serve first and second elem in queue
                    self.player1 = tournament_team_name.serve()
                    self.player2 = tournament_team_name.serve()
                    # start battle
                    self.advance_tournament() # start tournament

                except Exception:
                    # ignore StopIteration
                    pass

                else:
                    # tournament_team_name should be cleared if it's a valid tournament
                    if tournament_team_name.is_empty():
                        return True
                    return False
            else:
                # append string item into tournament_team_name
                tournament_team_name.append(item)
                self.all_teams_name.append(item)

    def is_balanced_tournament(self, tournament_str: str) -> bool:
        # FIT1054
        pass

    def start_tournament(self, tournament_str: str) -> None:
        """ Generates teams based on the tournament_str, return None """
        # This method is user facing
        if type(tournament_str) != str:
            raise TypeError(f"Please enter tournament_str as string!")
        else:
            self.tournament_str = tournament_str

        matches = self.tournament_str.split(" + ")

        # Generate teams based on names in each_poke_team
        for team_name in matches:
            new_team = PokeTeam.random_team(team_name, self.battle_mode)

            # insert new_team into team
            self.all_teams.insert(len(self.all_teams), new_team)

    # Extra method to count the total number of games
    def count_number_of_games(self, tournament_str: str) -> None:
        """
        Count the total number of + in the given tournament_str which is equivalent to the total number of games,
        return None
        """

        each_element = tournament_str.split(" ")
        for elem in each_element:
            if elem == "+":
                self.total_matches += 1

    def advance_tournament(self) -> tuple[PokeTeam, PokeTeam, int] | None:
        """
        Simulates one battle of the tournament, following the order of given tournament_str,
        return tuple or None

        :complexity: O((B+P) * T), where T is the number of tournament battles, B is the time
                    complexity of running a battle, and P is the number of pokemon in the party
        """
        # (Each + represents a game, and each game is simulated from left to right).
        # tuple_next_tournament_battle = tuple(PokeTeam, PokeTeam, self.battle_mode)
        if self.total_matches is not 0:
            # Decrement by 1 everytime this method is called
            # To keep track on each tournament battle being held
            self.total_matches -= 1

            self.current_tournament_match += 1
            tournament_team_name_1 = self.all_teams_name[0]
            tournament_poke_team_1 = PokeTeam.random_team(tournament_team_name_1, self.battle_mode)

            self.current_tournament_match += 1
            tournament_team_name_2 = self.all_teams_name[1]
            tournament_poke_team_2 = PokeTeam.random_team(tournament_team_name_2, self.battle_mode)
            tuple_next_tournament_battle = (tournament_poke_team_1, tournament_poke_team_2, self.battle_mode)

            return tuple_next_tournament_battle
        # If no games are remaining, None should be returned.
        else:
            return None

    def linked_list_of_games(self) -> LinkedList[tuple[PokeTeam, PokeTeam]]:
        """ A linked list, containing a tuple for each match of the tournament, return LinkedList """
        # Returns a linked list, containing a tuple for each match of the tournament
        tuple_tournament_matches = LinkedList()
        while True:
            result = self.advance_tournament()
            if result is None:
                break
            tuple_tournament_matches.insert(0, (result[0], result[1]))
        return tuple_tournament_matches

    def linked_list_with_metas(self) -> LinkedList[tuple[PokeTeam, PokeTeam, list[str]]]:
        """ A Linked list containing list of strings representing PokeTypes which,
            for the particular battle listed, are not present in either PokeTeam, but were
            represented by some other PokeTeam, which if they hadn’t lost any of their matches,
            would be playing this match, return LinkedList

            :complexity: O(M*(B+P)), where M is the total number of matches played, B is all the battles
                        and P is the limit on the number of pokemon per team.
        """
        # Returns a linked list, containing a tuple for each match of the
        # tournament, in the same order as linked_list_of_games does. Additionally in the tuple
        # is a list of strings representing PokeTypes which, for the particular battle listed, are
        # not present in either PokeTeam, but were represented by some other PokeTeam,
        # which if they hadn’t lost any of their matches, would be playing this match.

        # You can use a tuple/list for the output, but for intermediate calculations please use another ADT.
        result = LinkedList() # LinkedList with min capacity of 1
        result.insert(0,(self.player1,self.player2))

        return result

    def flip_tournament(self, tournament_list: LinkedList[tuple[PokeTeam, PokeTeam]], team1: PokeTeam,
                        team2: PokeTeam) -> None:
        # FIT1054
        pass
