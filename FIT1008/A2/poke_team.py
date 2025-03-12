"""
This module creates PokeTeams that could decide actions taken in battle.
All functions, unless stated otherwise, have a constant best / worst case complexity of O(1).
"""

from __future__ import annotations

__author__ = "Scaffold by Jackson Goerner, Code by Chew Xin Ning, Foo Kai Yan, Gan Kai Xin and Alicia Chik Wen Quek"

# Import libraries
from random_gen import RandomGen
from stack_adt import Stack, ArrayStack
from linked_list import LinkedList
from sorted_list import ListItem
from array_sorted_list import ArraySortedList
from pokemon import Eevee, Charmander, Squirtle, Bulbasaur, Charizard, Venusaur, Blastoise, Haunter, Gengar, Gastly
from referential_array import ArrayR
from enum import Enum, auto
from pokemon_base import PokemonBase


class Action(Enum):
    """ Enumerate available Action for player to take in battle """

    ATTACK = auto()
    # current pokemon on the field attacks the opposing team

    SWAP = auto()
    # current pokemon is returned to the field and another pokemon is retrieved from the team
    # (could be the same pokemon)

    HEAL = auto()
    # 3 times per battle, each team can fully heal the pokemon and clear any status effects.

    SPECIAL = auto()
    # Return your pokemon, do a special action on your team (depends on battle mode)
    # and then retrieve a new pokemon for the field.


class Criterion(Enum):
    """ Enumerate available Criterion of each Pokemon """

    SPD = auto()
    # Pokemon's speed

    HP = auto()
    # Pokemon's health point

    LV = auto()
    # Pokemon's current level

    DEF = auto()
    # Pokemon's defence


class PokeTeam():
    """ Create Pokemon team with team name, number of Pokemon in team, battle mode, ai type, criterion and criterion value
    Attributes:
        team_name(str) = Team name
        team_numbers(List[int]) = List of integer that specify how many of each pokemon types the team has
        battle_mode(int) = Battle mode of 0, 1 or 2
        ai_type(PokeTeam.AI) = AI type
        criterion(Criterion) = Criterion: SPD, HP, LV, DEF
        team_heal_count(int) = Number count a team has healed
        total_pokemon(int) = Number of total pokemon in a team
        current_poke(pokemon) = The current pokemon selected
        battle_option(Action) = Team action
        new_poke_lst(List[pokemon]) = The team list of pokemons
        index(int) = Index of the retrieve pokemons that will be use to help return in the correct position
        team_size(int) = the length of the pokemon team

    Getters:
        get_team_name = return team name
        get_team_size = return team size
        get_battle_mode = return battle mode
        get_ai_type = return AI type
        get_criterion = return selected criterion
        get_battle_option = return current battle option chosen
        get_team_numbers = return number of each individual Pokemon
        get_total_pokemons = return total number of pokemons

    Methods:
        create_team = create pokemon team
        random_team = class method to create a random PokeTeam
        full_team = check if team is full
        is_empty = check if team is empty
        return_pokemon = return a pokemon to the PokeTeam
        retrieve_pokemon = retrieve a pokemon from the a PokeTeam
        special = does special action depending on battle mode
        regenerate_team = Regenerate battle team of same battle numbers to be ready for another battle
        __str__ = Return String representation of poketeam
        choose_battle_option = AI of the pokemon decide on an action depending on the pokemon currently in the field
    """

    class AI(Enum):
        """ Enumerate available AI type """

        ALWAYS_ATTACK = auto()
        # always choose the attack option
        # call the attack func

        SWAP_ON_SUPER_EFFECTIVE = auto()
        # always select swap if the opposing pokemon's attacks are super-effective
        # (will have effective damage larger or equal to 1.5 times their attack stat). Otherwise attack.

        RANDOM = auto()
        # randomly select a valid action from Action class

        USER_INPUT = auto()
        # prompt the user for some input.

    class PokeDex(Enum):
        """ Enumerate Pokemon sorting order in PokeDex """
        Charmander = 0
        Charizard = 1
        Bulbasaur = 2
        Venusaur = 3
        Squirtle = 4
        Blastoise = 5
        Gastly = 6
        Haunter = 7
        Gengar = 8
        Eevee = 9

    def __init__(self, team_name: str, team_numbers: list[int], battle_mode: int, ai_type: PokeTeam.AI, criterion=None,
                 criterion_value=None) -> None:
        """ Creation and Initialisation of object Team
        :pre1: team name must be string type
        :pre2: team numbers must be list of integer
        :pre3: battle mode must be integer type thats either 0, 1 or 2
        :pre4: ai type must be PokeTeam.AI
        :pre5: criterion must be type Criterion or None

        :param arg1: team name
        :param arg2: team numbers that specify how many of each pokemon types the team has
        :param arg3: battle mode of 0, 1 or 2
        :param arg4: AI type
        :param arg5: criterion
        :param arg6: criterion_value
        :complexity: occur in precondition for team_numbers and battle_mode,
                     Best O(1) where first element raises the error (line 145)
                     Worst O(N) where each element did not raise error (line 145) and when battle_mode is valid (line 157),
                     where O(N) is the complexity of traversing through items in list
        """

        # Precondition for team_name
        if type(team_name) != str:
            raise TypeError(f"Please enter team name as string!")
        else:
            self.team_name = team_name # accept valid input

        # Precondition for team_numbers
        if type(team_numbers) != list:
            raise TypeError(f"Please enter team number as a list of integers!")
        else:
            total_count = 0 # use to keep tab of number of pokemons
            for num in team_numbers:
                if type(num) != int:
                    raise TypeError(f"Please enter team number as list of integers!")
                total_count += num
                if total_count > 6:
                    raise ValueError(f'Please do not select more than 6 pokemon!')

            self.team_numbers = team_numbers # accept valid input

        # Precondition for battle_mode
        if type(battle_mode) != int:
            raise TypeError(f"Please enter battle_mode as integer!")
        elif battle_mode not in [0, 1, 2]:
            raise ValueError(f"Invalid battle mode! Please choose from 0, 1 or 2 :D")
        else:
            self.battle_mode = battle_mode # accept valid input

        # Precondition for ai_type
        if type(ai_type) != PokeTeam.AI:
            raise TypeError(f"Please enter ALWAYS_ATTACK or SWAP_ON_SUPER_EFFECTIVE or RANDOM or USER_INPUT!")
        else:
            self.ai_type = ai_type # accept valid input

        # Precondition for criterion
        if criterion == None:
            self.criterion = criterion # accept valid input
        elif type(criterion) != Criterion:
            raise TypeError(f"Please enter Criterion.SPD or Criterion.HP or Criterion.LV or Criterion.DEF!")
        else:
            self.criterion = criterion # accept valid input

        self.team_heal_count = 0
        self.total_pokemon = 0
        self.current_poke = None
        self.battle_option = None
        self.new_poke_lst = LinkedList()
        self.index = 0
        self.create_team() # call method that create Pokemon team
        self.team_size = len(self.new_poke_lst)
        self.team_lives = 0

    def create_team(self):
        """ Create Pokemon team
        :complexity: Best O(N) if battle mode is not 2,
                     Worst O(N * m) if battle mode is 2 where it had to sort the list according to criterion in descending order,
                     where O(N) is the complexity of len(list) and comparison is O(m)
        """
        # Make actual pokemon team with ArraySortedList
        pokemon_team = ArraySortedList(6)

        # Call Pokemon into Pokemon Team and Sort pokemons from team_numbers according to PokeDex order.
        # for loop to take in consideration of more than 1 of same pokemon
        # Get Charmander
        for char in range(self.team_numbers[0]):
            pokemon_team.add(ListItem(Charmander(), PokeTeam.PokeDex.Charmander.value))

        # Get Bulbasaur
        for bulb in range(self.team_numbers[1]):
            pokemon_team.add(ListItem(Bulbasaur(), PokeTeam.PokeDex.Bulbasaur.value))

        # Get Squirtle
        for squirt in range(self.team_numbers[2]):
            pokemon_team.add(ListItem(Squirtle(), PokeTeam.PokeDex.Squirtle.value))

        # Get Gastly
        for gast in range(self.team_numbers[3]):
            pokemon_team.add(ListItem(Gastly(), PokeTeam.PokeDex.Gastly.value))

        # Get Eevee
        for eev in range(self.team_numbers[4]):
            pokemon_team.add(ListItem(Eevee(), PokeTeam.PokeDex.Eevee.value))

        # Have new_poke_lst with object in the right key value
        for i in range(len(pokemon_team)):
            self.new_poke_lst.insert(i, pokemon_team[i].value)
            self.total_pokemon += 1

        # Sorting the pokemons team according to criterion when battle mode is 2
        team_length = len(self.new_poke_lst)
        temp_lst = ArrayR(team_length) # to store pokemons temporarily
        if self.battle_mode == 2:
            criterion_value = self.criterion.value
            if criterion_value == 1:  # if criterion_value is Criterion.SPD
                # place pokemons in temporary list
                for n in range(team_length):
                    temp_lst[n] = self.new_poke_lst[n]

                # sort the pokemons according to pokemons speed
                for i in range(team_length):
                     for j in range(i+1, team_length):
                         if (temp_lst[i].get_speed()< temp_lst[j].get_speed()):
                             temp = temp_lst[i]
                             temp_lst[i] = temp_lst[j]
                             temp_lst[j] = temp

                # place the sorted pokemons to new_poke_lst
                for y in range(team_length):
                    self.new_poke_lst[y] = temp_lst[y]

            elif criterion_value == 2:  # if criterion_value is Criterion.HP
                # place pokemons in temporary list
                for n in range(team_length):
                    temp_lst[n] = self.new_poke_lst[n]

                # sort the pokemons according to pokemons hp
                for i in range(team_length):
                     for j in range(i+1, team_length):
                         if (temp_lst[i].get_hp() < temp_lst[j].get_hp()):
                             temp = temp_lst[i]
                             temp_lst[i] = temp_lst[j]
                             temp_lst[j] = temp

                # place the sorted pokemons to new_poke_lst
                for y in range(team_length):
                    self.new_poke_lst[y] = temp_lst[y]

            elif criterion_value == 3:  # if criterion_value is Criterion.LV
                # place pokemons in temporary list
                for n in range(team_length):
                    temp_lst[n] = self.new_poke_lst[n]

                # sort the pokemons according to pokemons level
                for i in range(team_length):
                     for j in range(i+1, team_length):
                         if (temp_lst[i].get_level()< temp_lst[j].get_level()):
                             temp = temp_lst[i]
                             temp_lst[i] = temp_lst[j]
                             temp_lst[j] = temp

                # place the sorted pokemons to new_poke_lst
                for y in range(team_length):
                    self.new_poke_lst[y] = temp_lst[y]

            elif criterion_value == 4:  # if criterion_value is Criterion.DEF
                # place pokemons in temporary list
                for n in range(team_length):
                    temp_lst[n] = self.new_poke_lst[n]

                # sort the pokemons according to pokemons defence
                for i in range(team_length):
                     for j in range(i+1, team_length):
                         if (temp_lst[i].get_defence()< temp_lst[j].get_defence()):
                             temp = temp_lst[i]
                             temp_lst[i] = temp_lst[j]
                             temp_lst[j] = temp

                # place the sorted pokemons to new_poke_lst
                for y in range(team_length):
                    self.new_poke_lst[y] = temp_lst[y]

    def get_team_name(self) -> str:
        """ Get Pokemon team name, return a String """
        return self.team_name

    def get_team_size(self) -> int:
        """ Get Pokemon team size, return integer """
        return self.team_size

    def get_battle_mode(self) -> int:
        """ Get battle mode chosen by player, return integer """
        return self.battle_mode

    def get_ai_type(self) -> PokeTeam.AI:
        """ Get AI type, return a AI type """
        return self.ai_type

    def get_criterion(self) -> str:
        """ Get selected criterion, return a String """
        return self.criterion

    def get_battle_option(self) -> Action:
        """ Get current battle option, return an Action """
        return self.battle_option

    def get_team_numbers(self) -> list:
        """ Get number of each individual Pokemon, return a list """
        return self.team_numbers

    def get_total_pokemons(self) -> int:
        """ Get current number of Pokemon remaining in the team, return integer """
        return self.total_pokemon

    @classmethod
    def random_team(cls, team_name: str, battle_mode: int, team_size=None, ai_mode=None, **kwargs) -> PokeTeam:
        """ Class method to create a random PokeTeam, return PokeTeam instance 
        :complexity: Best = Worst = O(N),
                     where O(N) is the complexity of len(list)"""
        # have variables assign with appropriate value
        team_name = team_name
        battle_mode = battle_mode
        team_number = [] # To hold number of each type of pokemon
        ai_type = ai_mode

        team_numbers_in_array = ArrayR(6) # use to calculate numbers for each pokemon type
        random_num_lst = ArraySortedList(6) # Array: hold random generated number
        poke_num = ArrayR(6)  # List that hold the number of each pokemon type e.g [1,1,0,0,2]

        # If no team size is specified, 
        # generate a team size of between half of the pokemon limit and the pokemon limit.
        if team_size is None:
            team_size = RandomGen.randint(3, 6)
            
        # Add 0 and team_size to first and last index
        random_num_lst.add(ListItem(0, 0))  # Add 0 to first index
        random_num_lst.add(ListItem(team_size, 6))  # Add team_size to last index
        
        # Generate 4 random numbers to be added to random_num_lst
        for num in range(4):
            random_generated_num = RandomGen.randint(0, team_size)
            random_num_lst.add(ListItem(random_generated_num, random_generated_num))
        
        # Have the random_num_lst value to be added to team_numbers_in_array, which will be use to calculate
        # the number for each pokemon type
        team_length = len(random_num_lst)
        for elem in range(team_length):
            team_numbers_in_array[elem] = random_num_lst[elem].value
        
        # Calculate the numbers for each pokemon and append it in poke_num
        length = len(team_numbers_in_array) - 1
        for all_elem in range(length):
            calculation = team_numbers_in_array[all_elem + 1] - team_numbers_in_array[all_elem]
            poke_num[all_elem] = calculation

        # Have the element in poke_num append in team_number
        for i in range(len(poke_num) - 1):
            team_number.append(poke_num[i])

        # If no AI mode is specified, the PokeTeam should pick options at random
        if ai_type is None:
            ai_type = PokeTeam.AI.RANDOM

        # Return PokeTeam instance
        return PokeTeam(team_name, team_number, battle_mode, ai_type, **kwargs)

    def full_team(self) -> bool:
        """ True if team is full, return Boolean """
        return self.team_size == len(self.new_poke_lst)

    def is_empty(self) -> bool:
        """ True if team is empty, return Boolean """
        return len(self.new_poke_lst) == 0

    def return_pokemon(self, poke: PokemonBase) -> None:
        """ Return a pokemon to the PokeTeam, return None """
        if poke.is_fainted():
            pass
        else:
            if self.full_team() is False:
                # returns the pokemon to the front of the team, having everyone shuffle down.
                if self.battle_mode == 0:
                    self.new_poke_lst.insert(0,poke)
                    self.total_pokemon += 1  # Add 1 to the total number of pokemon

                # returns the pokemon to the end of the team, having everyone stay where they are.
                elif self.battle_mode == 1:
                    self.new_poke_lst.insert(len(self.new_poke_lst), poke)
                    self.total_pokemon += 1  # Add 1 to the total number of pokemon

                # return the pokemon to their correct position within the ordering of the team.
                elif self.battle_mode == 2: # not entirely sure
                    self.new_poke_lst.insert(self.index, poke)
                    self.total_pokemon += 1  # Add 1 to the total number of pokemon

    def retrieve_pokemon(self) -> PokemonBase | None:
        """ Retrieve a pokemon from the a PokeTeam, return a pokemon or None """
        # If the team is empty, return None.
        if self.is_empty():
            retrieve_poke = None
        else:
            retrieve_poke = self.new_poke_lst[0]
            self.total_pokemon -= 1 # minus 1 to the total number of pokemon
            self.index = self.new_poke_lst.index(retrieve_poke)
            index = self.new_poke_lst.index(retrieve_poke)
            self.new_poke_lst.delete_at_index(index)
        return retrieve_poke

    def special(self) -> None:  
        """ Special mode of each battle mode, return None 
        :complexity: Best O(1) if battle mode is 0,
                     worst O(N) if battle mode is not 0,
                     where O(N) is the complexity of len(list)
        """
        # Perform Special operation on the team.
        pokemons = self.new_poke_lst  # new_poke_lst is supposed to be the pokemons in the team
        length = len(self.new_poke_lst)
        if self.battle_mode == 0:
            # Swap first and last pokemon on the team
            pokemons[0], pokemons[length - 1] = pokemons[length - 1], pokemons[0]
            self.new_poke_lst = pokemons

        elif self.battle_mode == 1:
            # Swap fist and second half of the team, first half is reverse order (reverse queue)
            # Get middle index
            mid = length // 2

            # temp_lst use to swap
            first_temp_lst = ArrayStack(mid)
            second_temp_lst = LinkedList()

            for i in range(mid):  # get the first half of pokemons
                first_temp_lst.push(pokemons[i])

            index = 0
            for i in range(mid, length):  # get the second half of pokemons
                second_temp_lst.insert(index, pokemons[i])
                index += 1

            for i in range(mid + 1, length):  # append the reverse order of first half of pokemons to second_temp_lst
                second_temp_lst.insert(i, first_temp_lst.pop())

            self.new_poke_lst = second_temp_lst

        elif self.battle_mode == 2:
            # Reverse sorting order
            temp_lst = ArrayStack(length)
            # have the pokemons push into stack
            for i in range(length):
                temp_lst.push(pokemons[i])

            # pop the pokemons into self.new_poke_lst
            self.new_poke_lst.clear()
            for i in range(length):
                self.new_poke_lst.insert(i, temp_lst.pop())

    def regenerate_team(self) -> None:
        """ Regenerate battle team of same battle numbers to be ready for another battle, return None """
        # Completely rebuild the team based on team numbers
        # clear the old team
        self.new_poke_lst.clear()
        # Generate team by calling create_team method
        self.create_team()

    def __str__(self) -> str:
        """ Return String representation, return String """
        return f"{self.team_name} ({self.battle_mode}): {self.new_poke_lst}"

    def choose_battle_option(self, my_pokemon: PokemonBase, their_pokemon: PokemonBase) -> Action:
        """ AI of the pokemon decide on an action depending on the pokemon currently in the field, return an Action 
        :complexity: Best O(1) if input_by_user is valid at the first try and the first element in the list,
                     worst O(N) if input_by_user is not valid at the first try and not the first element in the list,
                     where O(N) is the complexity of traversing through item in the list and iterattion of while loop
        """
        # The AI of the pokemon.
        my_team_ai = self.ai_type
        if my_team_ai.value == 1:  # If my_team_ai is ALWAYS_ATTACK then return ATTACK action
            self.battle_option = Action.ATTACK

        if my_team_ai.value == 2:  # If my_team_ai is SWAP_ON_SUPER_EFFECTIVE then return SWAP action
            # Always select swap if the opposing pokemon's attacks are super-effective 
            # (will have effective damage larger or equal to 1.5 times their attack stat)
            # Will otherwise attack.
            if their_pokemon.effective_attack(my_pokemon) >= (1.5 * their_pokemon.get_attack_damage()):
                self.battle_option = Action.SWAP
            else:
                self.battle_option = Action.ATTACK

        actions_lst = list(Action)
        if my_team_ai.value == 3:  # If my_team_ai is RANDOM then return randomly chosen action
            # If pokemon health count reach to 3, then Action HEAL is remove from list
            if my_pokemon.heal_count >= 3:  # Heal count from pokemon base
                actions_lst.remove(Action.HEAL)
            self.battle_option = actions_lst[RandomGen.randint(0, len(actions_lst) - 1)]

        if my_team_ai.value == 4:  # if my_team_ai is USER_INPUT then return action chosen by user
            # Prompt the user for some input, if input not valid, prompt again.
            valid = False
            while valid is False:
                input_by_user = int(input("1. ATTACK\n2. SWAP\n3. HEAL\n4. SPECIAL\nPlease choose an action (int): "))
                if input_by_user in [1, 2, 3, 4]:
                    self.battle_option = Action(input_by_user)
                    valid = True
                else:
                    valid = False
        return self.battle_option


    def leaderboard_team(cls):
        pass
