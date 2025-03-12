"""
This module creates a Battle Tower and Battle Tower Iterator that calls certain functions from Battle and implement them
in Battle Tower and Battle Tower Iterator.
All functions, unless stated otherwise, have a constant best / worst case complexity of O(1).
"""

from __future__ import annotations

__author__ = "Code by Chew Xin Ning, Foo Kai Yan, Gan Kai Xin and Alicia Chik Wen Quek"

# Import libraries
from battle import Battle
from random_gen import RandomGen
from node import *
from linked_list import LinkedList
from abstract_list import T
from poke_team import PokeTeam


class BattleTower:
    """
    To create a Battle Tower where a randomly generated PokeTeam will battle with other multiple randomly generated
    PokeTeams

    Attributes:
        battle = Tower instance
        my_team = The team that will be fighting through the tower
        battle_mode = PokeTeam's chosen battle mode
        pokemons_in_team = PokeTeam's pokemons in the format with [1, 1, 1, 1, 1]
        poke_team_name = PokeTeam's team name
        poke_team_criteria = PokeTeam's chosen or randomly chosen criteria value
        poke_team_size = PokeTeam's team size
        remaining_lives = remaining lives of tower team 

    Methods:
        set_my_team = Set the team fighting all the other randomly generated PokeTeams in BattleTower
        generate_teams = Generate and set the randomly generated PokeTeams in BattleTower that will be fought
    """
    # Collection of teams of length n generated randomly
    generated_random_teams = LinkedList()
    # Player's team
    my_team = None
    battle = None

    def __init__(self, battle: Battle | None = None) -> None:
        """ Create tower instance.
            :param arg1: the Tower instance that will ve used for actual battle 
        """
        
        Battle.battle = battle
        self.battle_mode = None
        self.pokemons_in_team = None
        self.poke_team_name = None
        self.poke_team_criteria = None
        self.poke_team_size = None

    def set_my_team(self, team: PokeTeam) -> None:
        """ Sets the team that will fight through the tower and regenerate PokeTeam every battle, return None 
            :complexity: O(n), where n is the number of team to be generated in generate_teams method     
        """

        BattleTower.my_team = team
        self.battle_mode = team.get_battle_mode()  # 0, 1 or 2
        self.pokemons_in_team = team.get_team_numbers()  # in [1, 1, 1, 1, 1] format
        self.poke_team_name = team.get_team_name()  # a string
        self.poke_team_criteria = team.get_criterion()  # SPD, HP, LV or DEF
        self.poke_team_size = team.get_team_size()  # length of PokeTeam

        # Before every battle, both teams should regenerate
        self.my_team.regenerate_team()

    def generate_teams(self, n: int) -> None:
        """ Generate n teams that is used in battle tower, return None 
            :complexity: O(n), where n is the number of team to be generated. 
        """

        # Precondition for number of teams (n)
        if type(n) != int:
            raise TypeError(f"Please input integer for number of teams (n)!")

        # index of each team
        number_index = 0

        # Generate n random teams
        while number_index < n:
            # set team name as AI, and generate random number between 0 and 1 for battle mode
            random_team = PokeTeam.random_team(f"Team + {number_index}", RandomGen.randint(0, 1))
            # Generate random number between 2 and 10 to be number of lives
            random_team.team_lives = RandomGen.randint(2, 10)
            BattleTower.generated_random_teams.insert(number_index, random_team)

            # increment number_index for team and decrement while loop counter
            number_index += 1

    def __iter__(self) -> BattleTowerIterator:
        """ Create an iterator to iterate the teams battling """

        return BattleTowerIterator(BattleTower.my_team)  # pass team to be iterated


class BattleTowerIterator:
    """
    A full-blown iterator for class BattleTower

    Attributes:
        curr_trainer (Node[T]) = The PokeTeam that will be returned next to fight the Battle Tower

    Methods:
        avoid_duplicates = Remove currently alive trainers from battle tower who have multiple same type pokemon
        next = Perform one battle in the tower and return a tuple with result, player team, tower team,
               and remaining lives of the tower team

    """

    def __init__(self, node: Node[T]) -> None:
        """ Initialises self.current to the node given as input. """
        self.curr_trainer = node

    def __iter__(self) -> BattleTowerIterator:
        """ Returns itself, as required to be iterable. """
        return self

    def __next__(self) -> T:
        """ Returns the current item and moves to the next node.
            :raises StopIteration: if the current item does not exist (None)
        """

        if self.curr_trainer is not None:

            # Step 1: get the item to be returned
            item = self.curr_trainer.item  # get item

            # Step 2: get ready for the next call
            self.current = self.curr_trainer.next

            return item

        else:
            raise StopIteration  # if current trainer contains nothing, end iteration

    def next(self, my_iterable: BattleTowerIterator) -> tuple:
        """
        Perform one battle in the tower and return a tuple containing
        1. result of the battle,
        2. player team after the battle,
        3. tower team after the battle,
        4. remaining lives of the tower team
        """

        #  If you lose a match, the battle tower instantly finishes
        result = 0
        tower_lives = 0
        tower_team = None
        next_team = 0

        # Calculate total lives of tower teams
        for teams in range(len(BattleTower.generated_random_teams)):
            tower_lives += BattleTower.generated_random_teams[teams].team_lives

        # If player (my_team) loses or all tower teams have 0 lives, the battle ends
        while result < 2 or tower_lives == 0:
            # Once facing off against every team,
            # Repeat after removing any teams with 0 lives from the ordering
            if next_team > (len(BattleTower.generated_random_teams)-1):
                next_team = 0           # Reset to start again from first team in order

            tower_team = BattleTower.generated_random_teams[next_team]
            # Regenerate both team before battle
            BattleTower.my_team.regenerate_team()
            tower_team.regenerate_team()

            # Create Battle object
            result = Battle.battle(BattleTower.battle, BattleTower.my_team, tower_team)

            # If you (my_team) wins or draw, opposing team (tower team) loses one life, battle continue
            if result == 0 or result == 1:
                tower_team.team_lives -= 1
                tower_lives -= 1

            # Remove teams with 0 lives
            if tower_team.team_lives <= 0:
                BattleTower.generated_random_teams.remove(tower_team)

            # Continue with next team
            next_team += 1

        # Once all teams have 0 lives, your team is victorious.
        if tower_lives == 0:
            result = 1

        tuple_return = (result, BattleTower.my_team, tower_team, tower_team.team_lives)
        return tuple_return

    def avoid_duplicates(self) -> None:
        """ 
        Remove currently alive trainers from battle tower who have multiple same type pokemon
        :complexity: O(N*P), where N is the number of trainers remaining
                    in the battle tower and P is the limit on the number of pokemon per team.
        """

        # all_trainers = BattleTower.generated_random_teams_class
        while self.curr_trainer.next:  # while there is still current_trainer available

            # if current node contain the same item as next node, current node change pointer to next next node
            if self.curr_trainer == self.curr_trainer.next.item:
                self.curr_trainer.next = self.current.next.next
            else:
                self.curr_trainer = self.curr_trainer.next

    def sort_by_lives(self):
        # FIT1054, not us :p
        pass
