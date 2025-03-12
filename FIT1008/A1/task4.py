__author__ = "FOO KAI YAN 33085625"

"""
First function (insertion_sort) re-arranging the argument array given so that the elements is in an ascending order.
Second function (main) declare an array which will be passed to first function as an argument when first function is called then print the elements out.
"""

from typing import List, TypeVar

T = TypeVar('T')

def insertion_sort(the_list: List[T]): # Passing a list named the_list as an arguement
    """ Takes in one parameter (the_list)

    Parameter(s): 
        the_list, which is an array passed into the insertion_sort function from main function

    Return:
        the re-arranged array (the_list) with it's elements which is in an ascending order
    """

    length = len(the_list) # Get the number of elements in the_list and store it in the variable named length
    for i in range(1, length): # Loop the entire length of the list, starting from the second element of the_list
        key = the_list[i] # Get the next element from the_list using i as the index, key will never be the 1st element of the_list
        j = i-1 # Get the index of the element before key; if i is the next element of the_list then j is the element before i 
        while j >= 0 and key < the_list[j] : # While loop with 2 conditions to ensure j is not a negetive number and to ensure that next element from the_list is smaller than it's previous element
                the_list[j + 1] = the_list[j] # Replace the smaller value element with the larger element
                j -= 1 # Decrement j by 1
        the_list[j + 1] = key # Replace the larger value element with the smaller value element
# Basically, this function re-arranging the list so it's elements is in an ascending order

def main() -> None:
    arr = [6, -2, 7, 4, -10]
    insertion_sort(arr)
    for i in range(len(arr)):
        print (arr[i], end=" ")
    print()


main()
