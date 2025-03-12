""" Implementation of an iterator for generating prime numbers using the concept of Sieve of Eratosthenes.
    All functions, unless stated otherwise, have a constant best / worst case complexity of O(1).
"""

from __future__ import annotations

__author__ = "Gan Kai Xin, Alicia Quek, Chew Xin Ning, Foo Kai Yan"
__docformat__ = 'reStructuredText'


class LargestPrimeIterator():
    """ Implement iterator for generating prime numbers using upper bound and factor

        Attributes:
            upper_bound: prime number generated must not exceed upper bound defined
            factor: to compute the upper bound for next prime number generation
            p: prime number to be computed
    """

    def __init__(self, upper_bound, factor) -> None:
        """ Initialisation """
        self.upper_bound = upper_bound
        self.factor = factor
        self.p = 0
        
    def __iter__(self) -> LargestPrimeIterator:
        """ Returns itself, as required to be iterable. """
        return self

    def __next__(self) -> int:
        """ Compute and return the largest prime number
            that is strictly less than the current value of the upper bound.
            :complexity: O(N^2) where N is the total number of element in (upper bound - 2)
        """

        # Create a list of consecutive integers from 2 through upper bound
        number_list = []
        for i in range(2, self.upper_bound):
            number_list.append(i)

        # Mark all the numbers which are divisible by 2 and are greater than or equal to the square of it
        # Continue moving to the next unmarked number and mark all the numbers which are multiples of it and are greater than or equal to the square of it
        n = 0
        marked = []

        for elem in range(len(number_list)):
            for num in range(len(number_list)):
                if (number_list[num] % number_list[n] == 0) and (number_list[num] >= number_list[n] ** 2):  # check conditions
                    if number_list[num] not in marked:  # to ensure only unique number being append
                        marked.append(number_list[num])

            # go to next number
            n += 1
        
        # Convert into set to find the difference (the number that is not marked)
        self.p = max(set(number_list) - set(marked))
        
        # Update upper bound
        self.upper_bound = self.p * self.factor

        # Return the largest prime number
        return self.p


if __name__ == "__main__":
    my_iter = LargestPrimeIterator(6, 2)
    print(next(my_iter))  # 5
    print(next(my_iter))  # 7
    print(next(my_iter))  # 13
