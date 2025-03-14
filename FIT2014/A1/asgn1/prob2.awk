# Pre-process checking
# Check if the first line is of the correct format
# Check if there is only an integer for ths first line and it must be more than 1, is positive and an integer
NR == 1 {
    if (NF != 1 || $1 <= 0 || $1 != int($1)) {
        # Print error message and quit out from the code
        print "Input file is not in the correct format."
        exit 1
    }
    numberOfVertices = $1
    # If the condition is checked to be fulfilled, go to check the second condition
    next
}

# Check if the rest of the lines in the input file are in the correct format
# Where the format will be integer1 connected to integer2 with -- as the connector
{
    if (NF != 3 || $2 != "--") {
        # Check if the number of integers and connector is correct and if the connector is '--'
        print "Input file is not in the correct format."
        exit 1
    }
    
    if ($1 <= 0 || $1 > numberOfVertices || $3 <= 0 || $3 > numberOfVertices) {
        # Check if its a positive integer and if vertex is in a valid range
        print "Input file is not in the correct format."
        exit 1
    }
    
    edges[$1 " " $3] = 1
}


# Process the input file line by line
NR == 1 {
    # Assign the value of the first line to numberOfVertices
    numberOfVertices = $1
    # Each vertex can only be colored with either Red, Black or White
    # %d is to place the number of the specific vertex
    for (i = 1; i <= numberOfVertices; i++) {
        colors = "(v" i "Red | v" i "Black | v" i "White) & "
        printf("%s", colors);
    }
}

# Done process input file 
END {
    # Generate clauses for each edge to ensure connected vertices have different colors
    for (edge in edges) {
        vertexIndices = split(edge, vertices, ",");
        vertex1 = vertices[1];
        vertex2 = vertices[2];

        colors = "(~v" vertex1 "Red | ~v" vertex2 "Red) & (~v" vertex1 "Black | ~v" vertex2 "Black) & (~v" vertex1 "White | ~v" vertex2 "White)";
        printf("%s", colors);

        if (vertex1 < numberOfVertices || vertex2 < numberOfVertices) {
            printf(" & ");
        }
    }

    # Generate clauses to ensure no two vertices share the same color
    for (i = 1; i < numberOfVertices; i++) {
        for (j = i + 1; j <= numberOfVertices; j++) {
            colors = "(~v" i "Red | ~v" j "Red) & (~v" i "Black | ~v" j "Black) & (~v" i "White | ~v" j "White)";
            printf("%s", colors);

            if (i <= numberOfVertices || j <= numberOfVertices) {
                printf(" & ");
            }
        }
    }

    # Make sure each vertex must have at least one color
    # if one vertex is colored a certain way, like Red, the other should not be colored the same way and should be Black or White
    for (i = 1; i < numberOfVertices; i++) {
        colors = "(~v" i "Red | ~v" i "Black) & (~v" i "Black | ~v" i "White) & (~v" i "Red | ~v" i "White)";
        printf("%s", colors);

        if ($1 != numberOfVertices-1) {
            result = result " & ";
        }
    }
    printf("\n");
}

