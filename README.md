<!-- PROJECT LOGO -->
<br />
<p align="center">

  <h3 align="center">Crossword Generator</h3>

  <p align="center">
    Coursework for IN3043 Functional Programming
    <br />
  </p>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project


The program reads the Grid.txt file as input and stores the values for the words in the crossword which should always be located at the bottom of the file (and separated by ";") and the crossword grid which can be of any sizes and it is mainly formed by "+" and "-" where "-" represents available spaces for the characters of words to go in.

Coming up with this program was not an easy task, as i was confused with the level of complexity expected for this project, i didn't know what idea was the worth implementing.
at the beggining i tried to implement a snake and minesweeper game but i came up with great difficulties as i tried to build and implement the Gloss Graphic Package but failed several times, this made me move to puzzles, i've found this crossword puzzle searching for advent of code challenges, I've decided to look at the sample input and output and start thinking how to implement it.

at the start the most challenging bit was thinking of iterating the grid and keeping record of the intersections where different words meets, this is where i decided to keep track of individual positions with a new data type called WordPos and Axis to traverse the grid horizontally and vertically to find and return the position of available spaces, overall i use a lot of recursion in my functions as i need to check each pos 1 by 1.
then i proceed to return string with the word filled in in 2 different list of strings.


### Built With

* [Haskell](https://www.haskell.org/)

<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running follow these simple steps.

### Prerequisites

You should have installed:
* Haskell
* Chocolatey
* Ghci

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/georgecity/fitnessApplicationFrontend.git
   ```
2. Initialise ghci console
   ```sh
   ghci
   ```
3. Load .hs file
   ```sh
   :l Crossword.hs
   ```
4. Run file
   ```sh
   main
   ```

<!-- CONTACT -->
## Contact

George Laaz - [George.Laaz-usina@city.ac.uk]()


<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements

* [City, University of London](https://www.city.ac.uk/)
* [Github README template](https://github.com/othneildrew/Best-README-Template)
