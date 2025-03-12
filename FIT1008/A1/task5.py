__author__ = "FOO KAI YAN 33085625"

"""
First function (print_combination) declare data using r which is passed from third function as an argument then call second function whilst passing arr, n, r, 0, data and 0 as an argument where 0 represents index and i.
Second function (combination_aux) print the combination of the array's elements in threes and the 3 elements being printed out are in an ascending order with every triple being printed out are different.
Third function (main) declare an array, r and n and pass it to first function as an argument when first function is called.
"""

def print_combination(arr, n, r):

    data = [0] * r
 
    combination_aux(arr, n, r, 0, data, 0)
 
def combination_aux(arr, n, r, index, data, i): # Passing 6 variables obtained from print_combination function as arguements
    """ Takes in six parameter (arr, n, r, index, data, i)

    Parameter(s): 
        arr, an array declared in main function
        n, length of the array from main function
        r, 3 which is the total number of elements printed per row and is declared in main function
        index, index of the element from data
        data, an empty array (local variable) in combination_aux function
        i, index of the element from the array declared in main function

    Return:
        the combination of the array's elements in threes and the 3 elements being printed out are in an ascending order and 
        each 3 elements being printed out is never the same
    """

    # r is the total amount of element to be printed out each time
    if (index == r): # if statement to check if the index of the element is equal to r
        for j in range(r): # 
            print(data[j], end = " ") # print an element from the array with index j ending with a space 
        print() # print the 3 elements each line then go to newline
        return # return the function
    # if the index of the element does not equal to r, go to nexr if statement
    if (i >= n): # if statement to check if i is more than or equal to n where n is the number of elements in the array named arr and in this case, i is 0
        return # return the function
 
    data[index] = arr[i] # get the current element of the array [data] using the index which is the same as array's element with the index of i
    combination_aux(arr, n, r, index + 1, 
                    data, i + 1) # call the combination_aux function again after incrementing the index and i
 
    combination_aux(arr, n, r, index, 
                    data, i + 1) # call the combination_aux function again after incrementing it
# Basically, this function prints the combination of the array's elements in threes and the 3 elements being printed out are in an ascending order and each 3 elements being printed out is never the same

def main():
    arr = [1, 2, 3, 4, 5]
    r = 3
    n = len(arr)
    print_combination(arr, n, r)

main()
