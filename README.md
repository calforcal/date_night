# Date Night - A Binary Search Tree

### The Problem
<p>You're working for a movie streaming service that is compiling 'Suggested Movies' for its users. Each Movie has its title, and also a score between 1 and 100. You've been tasked with creating a storage system to read, write, and destroy the 'Suggested Movies' that are given to you.</p>

### The Solution
<p>Since we'll need to access these movies quickly, and the files being retrieved could be quite large - we've built a Binary Search Tree. BST's are a fundamental data structure that are extremely useful when handling larger datasets and information is needed to be retrieved quickly.</p>

## Repo Installation
In your terminal run the following commands to clone the repositories:
          
    git clone git@github.com:calforcal/date_night.git

**Ruby Version**

    ruby 3.2.2

**Installing the Gems Locally**

     bundle install

**Testing the Repositories**

#### To run the full test suite:

<p> **Coverage should be at 100%** </p>

     bundle exec rspec

## BST Functionality

### Initialize a Tree

<details close>

    tree = BinarySearchTree.new

</details>

### Insert

<p>The insert method takes a score, and a movie title - which is used to create a new node within the tree. If the node is inserted, the return value is the level at which the node was inserted.</p>

<details close>

    Input: tree.insert(61, "Max Keebler's Big Move")
      Output: # => 0
    Input: tree.insert(16, "Sharknado")
      Output: # => 1
    Input: tree.insert(92, "Eras Tour the Movie")
      Output: # => 1
    Input: tree.insert(50, "Dunkirk")
      Output: # => 2


                            Tree Shape
                                61
                               /  \
                             16    92
                               \
                                50

</details>

### Include?

<details close>

    Input: tree.include?(61)
      Output: # => true

    Input: tree.include?(100)
      Output: # => false

</details>

### Depth Of

<details close>

    Input: tree.depth_of(61)
      Output: # => 0

    Input: tree.depth_of(50)
      Output: # => 2

                            Tree Shape
              Level: 0          61
                               /  \
              Level: 1       16    92
                               \
              Level: 2          50

</details>

### Max and Min

<details close>

    Input: tree.max
      Output: # => { "Eras Tour the Movie" =>92 }

    Input: tree.min
      Output: # => { "Sharknado" =>16 }

</details>

### Sort

<details close>

    Input: tree.sort
      Output:
              [{ "Sharknado"=>16 },
               { "Dunkirk"=>50 },
               { "Max Keebler's Big Move"=>61 },
               { "Eras Tour the Movie"=>92 }]

</details>

### Load

<details close>

    # movies.txt sample format:
      34, Hannibal Buress: Comedy Camisado
      63, Meet My Valentine
      22, Experimenter
      84, French Dirty
      41, Love
      10, I Love You Phillip Morris



    Input: tree.load('movies.txt')
      Output: # => 6

                            Tree Shape
                                34
                               /  \
                             22    63
                            /  \     \
                          10    41    84

</details>

<br>
<br>

## Assuming these inputs for the enclosed inputs for the remainder of the examples

<details close>

    tree.insert(98, "Animals United")
    tree.insert(58, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")
    tree.insert(93, "Bill & Ted's Excellent Adventure")
    tree.insert(86, "Charlie's Angels")
    tree.insert(38, "Charlie's Country")
    tree.insert(69, "Collateral Damage")

                            Tree Shape
                                98
                               /  \
                              58    
                            /    \
                           /      \
                         36        93
                           \       /
                            38   86
                                /
                               69  

</details>

### Health

<details close>

    Input: tree.health(0)
      Output: [[98, 7, 100]]
    Input: tree.health(1)
      Output: [[58, 6, 85]]
    Input: tree.health(2)
      Output: [[36, 2, 28], [93, 3, 42]]

</details>

### Leaves

<details close>

    Input: tree.leaves
      Output: 2

</details>

### Height

<details close>

    Input: tree.height
      Output: 4

</details>

### Delete

<details close>

    Input: tree.delete(38)
      Output: 38

</details>