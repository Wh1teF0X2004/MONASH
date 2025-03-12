""" Implementation of basic attributes and methods of Game in Game class,
    Solo Player game class and Multi-player game class.
    All functions, unless stated otherwise, have a constant best / worst case complexity of O(1).
"""

from __future__ import annotations

from player import Player
from trader import Trader, RandomTrader, RangeTrader, HardTrader
from material import Material
from cave import Cave
from food import Food
from referential_array import ArrayR
from random_gen import RandomGen


class Game:
    """ Base class for implementation of a game.

    Attributes:
        MIN_MATERIALS = class variable, constant minimum number of materials
        MAX_MATERIALS = class variable, constant maximum number of materials
        MIN_CAVES = class variable, constant minimum number of caves
        MAX_CAVES = class variable, constant maximum number of caves
        MIN_TRADERS = class variable, constant minimum number of traders
        MAX_TRADERS = class variable, constant maximum number of traders
        MIN_FOOD = class variable, constant minimum number of food
        MAX_FOOD = class variable, constant maximum number of food
        material_list = List of material owned by player
        caves_list = List of cave that player can choose to mine from
        traders_list = List of trader that player can have a trade with

    Getters:
        get_caves = Return list of cave on player's journey
        get_materials = Return materials in player's inventory
        get_traders = Return trader list for trading

    Setters:
        set_caves = Set a list of caves
        set_materials = Set a list of materials
        set_traders = Set a list of traders

    Methods:
        initialise_game = Initialise all game objects: Materials, Caves, Traders.
        initialise_with_data = Initialise material, caves and traders lists
        generate_random_materials = Generate random unique materials
        generate_random_caves = Generate random unique caves
        generate_random_traders = Generate random unique traders
        finish_day = End the game
    """

    MIN_MATERIALS = 5
    MAX_MATERIALS = 10

    MIN_CAVES = 5
    MAX_CAVES = 10

    MIN_TRADERS = 4
    MAX_TRADERS = 8

    MIN_FOOD = 2
    MAX_FOOD = 5

    def __init__(self) -> None:
        """ Initialisation, return None """
        self.materials_list = None
        self.caves_list = None
        self.traders_list = None

    def initialise_game(self) -> None:
        """ Initialise all game objects: Materials, Caves, Traders.
            :complexity: O(N) where N is the complexity for map() function """
        N_MATERIALS = RandomGen.randint(self.MIN_MATERIALS, self.MAX_MATERIALS)
        self.generate_random_materials(N_MATERIALS)
        print("Materials:\n\t", end="")
        print("\n\t".join(map(str, self.get_materials())))
        N_CAVES = RandomGen.randint(self.MIN_CAVES, self.MAX_CAVES)
        self.generate_random_caves(N_CAVES)
        print("Caves:\n\t", end="")
        print("\n\t".join(map(str, self.get_caves())))
        N_TRADERS = RandomGen.randint(self.MIN_TRADERS, self.MAX_TRADERS)
        self.generate_random_traders(N_TRADERS)
        print("Traders:\n\t", end="")
        print("\n\t".join(map(str, self.get_traders())))

    def initialise_with_data(self, materials: list[Material], caves: list[Cave], traders: list[Trader]) -> None:
        """ Initialise material, caves and traders lists """
        self.set_materials(materials)
        self.set_caves(caves)
        self.set_traders(traders)

    def set_materials(self, mats: list[Material]) -> None:
        """ Set a list of materials, return None """
        self.materials_list = mats

    def set_caves(self, caves: list[Cave]) -> None:
        """ Set a list of caves, return None """
        self.caves_list = caves

    def set_traders(self, traders: list[Trader]) -> None:
        """ Set a list of traders, return None """
        self.traders_list = traders

    def get_materials(self) -> list[Material]:
        """ Return a list of material """
        return self.materials_list

    def get_caves(self) -> list[Cave]:
        """ Return a list of cave """
        return self.caves_list

    def get_traders(self) -> list[Trader]:
        """ Return a list of trader """
        return self.traders_list

    def generate_random_materials(self, amount) -> None:
        """
        Generates <amount> random materials using Material.random_material
        Generated materials must all have different names and different mining_rates.
        (You may have to call Material.random_material more than <amount> times.)
        :complexity: Best = O(N) * O(M) when it only iterates for <amount> time,
                     where N is amount, M is complexity to check if generated material is already in the generated list,
                     Worst = O(N+R) * O(M) when there is repeated random material generated,
                     where R is the number of repeated material generated by random_material() method
        """
        counter = amount
        generated_materials = []
        while counter != 0:
            generated_mat = Material.random_material()
            if generated_mat.name not in [mat.get_material_name() for mat in generated_materials]:
                generated_materials.append(generated_mat)
                counter -= 1
            else:
                counter += 1
        self.set_materials(generated_materials)

    def generate_random_caves(self, amount) -> None:
        """
        Generates <amount> random caves using Cave.random_cave
        Generated caves must all have different names
        (You may have to call Cave.random_cave more than <amount> times.)
        :complexity: Best = O(N) * O(M) when it only iterates for <amount> time,
                     where N is amount, M is complexity to check if generated cave is already in the generated list,
                     Worst = O(N+R) * O(M) when there is repeated random cave generated,
                     where R is the number of repeated cave generated by random_cave() method
        """
        counter = amount
        generated_caves = []
        while counter != 0:
            generated_cave = Cave.random_cave(self.materials_list)
            if generated_cave.name not in [cav.get_cave_name() for cav in generated_caves]:
                generated_caves.append(generated_cave)
                counter -= 1
            else:
                counter += 1
        self.set_caves(generated_caves)

    def generate_random_traders(self, amount) -> None:
        """
        Generates <amount> random traders by selecting a random trader class
        and then calling <TraderClass>.random_trader()
        and then calling set_all_materials with some subset of the already generated materials.
        Generated traders must all have different names
        (You may have to call <TraderClass>.random_trader() more than <amount> times.)
        :complexity: Best = O(N) * O(M) * O(S) when it only iterates for <amount> time,
                     where N is amount, M is complexity to check if generated trader is already in the generated list,
                     S is the complexity for set_all_materials() method
                     Worst = O(N+R) * O(M) when there is repeated random trader generated,
                     where R is the number of repeated trader generated by random_trader() method
        """
        counter = amount
        generated_traders = []
        while counter != 0:
            generated_trader = RandomGen.random_choice([RangeTrader, RandomTrader, HardTrader]).random_trader()
            if generated_trader.name not in [tra.name for tra in generated_traders]:
                generated_trader.set_all_materials(self.materials_list)
                generated_traders.append(generated_trader)
                counter -= 1
            else:
                counter += 1
        self.set_traders(generated_traders)

    def finish_day(self) -> None:
        """
        DO NOT CHANGE
        Affects test results.
        :complexity: O(C) where C = #Cave
        """
        for cave in self.get_caves():
            if cave.quantity > 0 and RandomGen.random_chance(0.2):
                cave.remove_quantity(RandomGen.random_float() * cave.quantity)
            else:
                cave.add_quantity(round(RandomGen.random_float() * 10, 2))
            cave.quantity = round(cave.quantity, 2)


class SoloGame(Game):
    """ Implementation of Solo Player Game """

    def initialise_game(self) -> None:
        """ Initialise all game objects: Materials, Caves, Traders.
            :complexity: O(N) where N is the complexity for initialise_game() function in parent class """
        super().initialise_game()
        self.player = Player.random_player()
        self.player.set_materials(self.get_materials())
        self.player.set_caves(self.get_caves())
        self.player.set_traders(self.get_traders())

    def initialise_with_data(self, materials: list[Material], caves: list[Cave], traders: list[Trader], player_names: list[int], emerald_info: list[float]) -> None:
        """ Initialise material, caves and traders lists """
        super().initialise_with_data(materials, caves, traders)
        self.player = Player(player_names[0], emeralds=emerald_info[0])
        self.player.set_materials(self.get_materials())
        self.player.set_caves(self.get_caves())
        self.player.set_traders(self.get_traders())

    def simulate_day(self) -> None:
        """
        Prompt day to start with how the day should go
        :complexity: O(T*N) where T = #Traders, N is complexity for generated deal
        """
        # 1. Traders make deals
        for trader in self.traders_list:
            trader.generate_deal()
        print("Traders Deals:\n\t", end="")
        print("\n\t".join(map(str, self.get_traders())))
        # 2. Food is offered
        food_num = RandomGen.randint(self.MIN_FOOD, self.MAX_FOOD)
        foods = []
        for _ in range(food_num):
            foods.append(Food.random_food())
        print("\nFoods:\n\t", end="")
        print("\n\t".join(map(str, foods)))
        self.player.set_foods(foods)
        # 3. Select one food item to purchase
        food, balance, caves = self.player.select_food_and_caves()
        print(food, balance, caves)
        # 4. Quantites for caves is updated, some more stuff is added.
        self.verify_output_and_update_quantities(food, balance, caves)

    def verify_output_and_update_quantities(self, foods: Food | None, balances: float,
                                                caves: list[tuple[Cave, float] | None]) -> None:
        """ To verify the result and check that:
            1. Quantities are in line with what the player provided
            2. The food is purchasable
            3. The remaining balance is correct

            :complexity: O(P), where P = #Players 
        """
        result = True
        # a.Quantities are in line with what the player provided
        # Checks whether the amount of material mined exceeds the maximum available in the cave
        if caves != None:
            for cave in caves:
                if result == True:
                    result = cave[1] <= cave[0].get_quantity()

        # b.The food is purchasable
        if result == True:
            for food in self.player.foods_list:
                while result == True:
                    if food == foods:
                        result = True
                    else:
                        result = False

        # c.The remaining balance is correct
        if result == True:
            if balances != self.player.balance:
                result = False

        # d. Any other sanity checks you can think of
        # Check whether player's balance is a valid number
        if result == True:
            if self.player.balance < 0:
                result = False

        # Updates the quantities within each cave accordingly if the above validations evaluates to True
        if result == True:
            for cave in caves:
                # Remove the amount of materials mined where quantity = second element in cave tuple
                cave[0].remove_quantity(cave[1])


class MultiplayerGame(Game):
    """ Implementation of Multi-player Game. """

    MIN_PLAYERS = 2
    MAX_PLAYERS = 5

    def __init__(self) -> None:
        """ Initialisation, return None """
        super().__init__()
        self.players = []

    def initialise_game(self) -> None:
        """ Initialise all game objects: Materials, Caves, Traders.
            :complexity: O(N) where N is the complexity for initialise_game() function in parent class """
        super().initialise_game()
        N_PLAYERS = RandomGen.randint(self.MIN_PLAYERS, self.MAX_PLAYERS)
        self.generate_random_players(N_PLAYERS)
        for player in self.players:
            player.set_materials(self.get_materials())
            player.set_caves(self.get_caves())
            player.set_traders(self.get_traders())
        print("Players:\n\t", end="")
        print("\n\t".join(map(str, self.players)))

    def generate_random_players(self, amount) -> None:
        """
        Generate <amount> random players. Don't need anything unique, but you can do so if you'd like
        :complexity: O(N), where N is <amount>
        """
        counter = amount
        while counter != 0:
            generated_players = Player.random_player()
            self.players.append(generated_players)
            counter -= 1

    def initialise_with_data(self, materials: list[Material], caves: list[Cave], traders: list[Trader], player_names: list[int], emerald_info: list[float]) -> None:
        """ Initialise material, caves and traders lists """
        super().initialise_with_data(materials, caves, traders)
        for player, emerald in zip(player_names, emerald_info):
            self.players.append(Player(player, emeralds=emerald))
            self.players[-1].set_materials(self.get_materials())
            self.players[-1].set_caves(self.get_caves())
            self.players[-1].set_traders(self.get_traders())
        print("Players:\n\t", end="")
        print("\n\t".join(map(str, self.players)))

    def simulate_day(self) -> None:
        """
        Prompt day to start with how the day should go
        :complexity: O(T*N) where T = #Traders, N is complexity for generated deal
        """
        # 1. Traders make deals
        for trader in self.traders_list:
            trader.generate_deal()
        print("Traders Deals:\n\t", end="")
        print("\n\t".join(map(str, self.get_traders())))
        # 2. Food is offered
        offered_food = Food.random_food()
        print(f"\nFoods:\n\t{offered_food}")
        # 3. Each player selects a cave - The game does this instead.
        foods, balances, caves = self.select_for_players(offered_food)
        # 4. Quantites for caves is updated, some more stuff is added.
        self.verify_output_and_update_quantities(foods, balances, caves)

    def select_for_players(self, food: Food) -> tuple[list[Food | None], list[float], list[tuple[Cave, float] | None]]:
        """
        Select a cave for players depending on their food and balances
        Return tuple of a list of food or None, list of float numbers and list of tuple of cave or None
        :complexity: O(P*C), where P = #Players, C = Caves 
        """
        each_player_food = []
        each_player_balance = []
        each_player_cave = []
        for player in self.players:
            player.foods_list = [food]
            each_player_food.append(Player.select_food_and_caves(player)[0])
            each_player_balance.append(Player.select_food_and_caves(player)[1])
            for cave in Player.select_food_and_caves(player)[2]:
                each_player_cave.append(cave)

        return (each_player_food, each_player_balance, each_player_cave)

    def verify_output_and_update_quantities(self, foods: Food | None, balances: float,
                                            caves: list[tuple[Cave, float] | None]) -> None:
        """ To verify the result and check that:
            1. Quantities are in line with what the player provided
            2. The food is purchasable
            3. The remaining balance is correct

            :complexity: O(P), where P = #Players 
        """
        result = True

        # a.Quantities are in line with what the player provided
        # Checks whether the amount of material mined exceeds the maximum available in the cave
        if caves != None:
            for cave in caves:
                if result == True:
                    result = cave[1] <= cave[0].get_quantity()

        for players in self.players:
            # b.The food is purchasable
            if result == True:
                for food in players.get_chosen_food():
                    while result == True:
                        if food == foods:
                            result = True
                        else:
                            result = False

            # c.The remaining balance is correct
            if result == True:
                if balances != players.balance:
                    result = False

            # d. Any other sanity checks you can think of
            # Check whether player's balance is a valid number
            if result == True:
                if players.balance < 0:
                    result = False

        # Updates the quantities within each cave accordingly
        if result == True:
            if caves is not None:
                for cave in caves:
                    # Remove the amount of materials mined where quantity = second element in cave tuple
                    cave[0].remove_quantity(cave[1])

if __name__ == "__main__":
    r = RandomGen.seed  # Change this to set a fixed seed.
    RandomGen.set_seed(r)
    print(r)

    g = SoloGame()
    g.initialise_game()

    g.simulate_day()
    g.finish_day()

    g.simulate_day()
    g.finish_day()

