"""
This module is where the battle logic is implemented so the basic battling between 2 PokeTeams can be conducted.
All functions, unless stated otherwise, have a constant best / worst case complexity of O(1).
"""

from __future__ import annotations

__author__ = "Scaffold by Jackson Goerner, Code by Chew Xin Ning, Foo Kai Yan, Gan Kai Xin and Alicia Chik Wen Quek"

# Import libraries
from random_gen import RandomGen
from poke_team import Action, PokeTeam, Criterion
from print_screen import print_game_screen
from pokemon_base import PokemonBase
from pokemon import *

class Battle:
    """Battle class where battle logic is implemented
    Attributes:
        winner = The winner of the battle
        verbosity(int) = An optional switch to possibly enable more printing / logging while battling
        team1_poke_team(PokeTeam) = Team 1 pokemon team
        team2_poke_team(PokeTeam) = Team 2 pokemon team
        team1_poke(PokemonBase) = Team 1 retrieved pokemon
        team2_poke(PokemonBase) = Team 2 retrieved pokemon

    Getters:
        get_winner = Return the winner of the 2 battling PokeTeams
        get_team1_poke_team = Return PokeTeam of team 1
        get_team2_poke_team = Return PokeTeam of team 2
        get_team1_poke = Return retrieved pokemon from team 1's PokeTeam
        get_team2_poke = Return retrieved pokemon from team 2's PokeTeam

    Methods:
        battle = Actual battle between team1 and team2 where the winner or draw will be decided
        determine_winner = Determine the outcome between the 2 battling teams: draw, team 1's win or team 2's win
        handle_action = Handle the actions process chosen by each battling team from Action class
        select_current_poke = Retrieve team's current pokemon chosen to battle
        fainted_check = Check a pokemons' state and determine the next step
    """

    def __init__(self, verbosity=0) -> None:
        """ Initialised Battle class """
        self.winner = None
        self.verbosity = verbosity
        self.team1_poke_team = None
        self.team2_poke_team = None
        self.team1_poke = None
        self.team2_poke = None

    def get_winner(self) -> str:
        """ Get the winner of the 2 battling PokeTeams, return string """
        return self.winner

    def get_team1_poke_team(self) -> PokeTeam:
        """ Get the PokeTeam of team 1 """
        return self.team1_poke_team

    def get_team2_poke_team(self) -> PokeTeam:
        """ Get the PokeTeam of team 2 """
        return self.team2_poke_team

    def get_team1_poke(self) -> PokemonBase:
        """ Get the pokemon from team 1's PokeTeam """
        return self.team1_poke

    def get_team2_poke(self) -> PokemonBase:
        """ Get the pokemon from team 2's PokeTeam """
        return self.team2_poke

    def battle(self, team1: PokeTeam, team2: PokeTeam) -> int:
        """
        The actual battle between team1 and team2 where the winner or draw will be decided,
        return integer
        :complexity: Best O(1) when choose_battle_option() method is called and when self.winner != None,
                     Worst O(Comp== * N) when choose_battle_option() method is called and 
                     fainted_check method is called with worst case scenerio
                     where O(Comp==) is the complexity for string comparison,
                     O(N) is the complexity of traversing through item in list
        """
        self.team1_poke_team = team1  # Player 1
        self.team2_poke_team = team2  # Player 2

        # Each PokeTeam retrieving a pokemon to send to the field
        self.team1_poke = self.select_current_poke(self.team1_poke_team)
        self.team2_poke = self.select_current_poke(self.team2_poke_team)

        # Set battle option (Action) of both teams
        # team 1
        self.team1_poke_team.battle_option = self.team1_poke_team.choose_battle_option(self.team1_poke, self.team2_poke)
        # team 2
        self.team2_poke_team.battle_option = self.team2_poke_team.choose_battle_option(self.team2_poke, self.team1_poke)

        # 1,2,3: Handle action for each team
        self.handle_action(self.team1_poke_team, self.team2_poke_team)

        # Continue only if self.winner not determined
        if self.winner == None:
            self.handle_action(self.team2_poke_team, self.team1_poke_team)

            if self.winner == None:
                # 4: Attack process when both pokemon attacking
                if (self.team1_poke_team.get_battle_option() == Action.ATTACK) and (self.team2_poke_team.get_battle_option() == Action.ATTACK):
                    # Faster speed attack first, the defend poke will attack next if it is not fainted
                    # if team1 pokemon is faster than team2 pokemon, team1 pokemon attack
                    if self.team1_poke.get_speed() > self.team2_poke.get_speed():
                        self.team1_poke.attack(self.team2_poke)
                        if self.team2_poke.is_fainted() is False: # The defend poke will attack next if it is not fainted
                            self.team2_poke.attack(self.team1_poke)

                    # if team2 pokemon is faster than team1 pokemon, team2 pokemon attack
                    elif(self.team2_poke.get_speed() > self.team1_poke.get_speed()):
                        self.team2_poke.attack(self.team1_poke)
                        if self.team1_poke.is_fainted() is False: # The defend poke will attack next if it is not fainted
                            self.team1_poke.attack(self.team2_poke)

                    # If same speed, both attack each other regardless, but team 1 attack first
                    elif(self.team1_poke.get_speed() == self.team2_poke.get_speed()):
                        self.team1_poke.attack(self.team2_poke)
                        self.team2_poke.attack(self.team1_poke)

                # 5: If both still alive, lose 1 HP
                if (self.team1_poke.get_hp() > 0) and (self.team2_poke.get_hp() > 0):
                    self.team1_poke.lose_hp(1)
                    self.team2_poke.lose_hp(1)

                # 6, 7, 8: Check both teams whether team_poke is fainted and carry out operations.
                self.fainted_check(self.team1_poke_team, self.team2_poke_team)
                if self.winner == None:
                    self.fainted_check(self.team2_poke_team, self.team1_poke_team)

        # Lastly, determine and return winner
        self.determine_winner()
        return self.winner

    def determine_winner(self) -> None:
        """
        Determine the winner between the 2 battling teams, return None
        0 = draw
        1 = team 1's win
        2 = team 2's win
        """
        # Return 0 for draw, 1 and 2 when team 1 or team 2 wins respectively
        if self.winner == "draw":
            self.winner = 0
        elif self.winner == self.team1_poke_team:
            self.winner = 1
        elif self.winner == self.team2_poke_team:
            self.winner = 2
        else:
            # team 2 wins if team 1 is empty
            if self.team1_poke_team.is_empty():
                self.winner = 2
            # team 1 wins if team 1 is empty
            elif self.team2_poke_team.is_empty():
                self.winner = 1
            # Continue battle if no winner
            else:
                self.battle(self.team1_poke_team, self.team2_poke_team)

    def handle_action(self, poke_team: PokeTeam, opposing_team: PokeTeam) -> None:
        """
        Handle the actions chosen by each battling team from Action class,
        return None
        """
        # 1: SWAP actions
        if poke_team.get_battle_option() == Action.SWAP:
            # The current pokemon is returned to the field and another pokemon is retrieved
            # from the team
            poke_team.return_pokemon(poke_team.current_poke)
            poke_team.current_poke = poke_team.retrieve_pokemon()


        # 2: SPECIAL actions
        elif poke_team.get_battle_option() == Action.SPECIAL:
            # Return current pokemon, do a special action on team
            # and then retrieve a new pokemon for the field.
            poke_team.return_pokemon(poke_team.current_poke)
            poke_team.special()
            poke_team.current_poke = poke_team.retrieve_pokemon()

        # 3: HEAL actions
        elif poke_team.get_battle_option() == Action.HEAL:
            # Lose battle if requested to heal after being healed 3 times
            if poke_team.team_heal_count >= 3:
                self.winner = opposing_team
            else:
                # Call heal method to heal because their heal_count not pass 3
                poke_team.current_poke.heal()
                poke_team.team_heal_count += 1

        # 4: ATTACK action
        elif poke_team.get_battle_option() == Action.ATTACK:
            poke_team.current_poke.attack(opposing_team.current_poke)


    def select_current_poke(self, poke_team: PokeTeam) -> PokemonBase:
        """ Select players' current pokemon chosen to battle, return a pokemon """
        # Retrieve battling pokemon from each team as selected_pokes
        poke_team.current_poke = poke_team.retrieve_pokemon()
        return poke_team.current_poke

    def fainted_check(self, poke_team: PokeTeam, opposing_team: PokeTeam) -> None:
        """
        Check a pokemons' state, return None
        If fainted, opposing team's pokemon level up
        If not fainted, check if pokemon is eligible to evolve or not and evolve if eligible
        Decide on the winner if either team have any more pokemon to use for battling
        :complexity: Best O(1) if pokemon fainted,
                     Worst O(Comp== * N) if pokemon did not faint then can_evolve() is called,
                     where O(Comp==) is the complexity for string comparison,
                     O(N) is the complexity of traversing through item in list
        """
        # 6: If one pokemon has fainted and the other has not, the remaining pokemon level up
        if poke_team.current_poke.is_fainted():
            opposing_team.current_poke.level_up()

        # 7: If pokemon have not fainted and can evolve, they evolve
        else:
            if poke_team.current_poke.can_evolve() is True:
                poke_team.current_poke.get_evolved_version()

        # 8: Fainted pokemon are returned and a new pokemon is retrieved from the team.
        # If no pokemon can be retrieved (the team is empty), then the opposing player wins.
        # If both teams are empty, the result is a draw.
        if poke_team.current_poke.is_fainted():
            poke_team.return_pokemon(poke_team.current_poke)
            if poke_team.is_empty():
                self.winner = opposing_team
            elif poke_team.is_empty() and opposing_team.is_empty():
                self.winner = "draw"
            elif poke_team.is_empty() is False:
                poke_team.current_poke = poke_team.retrieve_pokemon()


if __name__ == "__main__":
    b = Battle(verbosity=3)
    RandomGen.set_seed(16)
    t1 = PokeTeam.random_team("Cynthia", 0, criterion=Criterion.SPD)
    t1.ai_type = PokeTeam.AI.USER_INPUT
    t2 = PokeTeam.random_team("Barry", 1)
    print(b.battle(t1, t2))
    print(t1.battle_option, t2.battle_option)
