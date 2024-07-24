## ft_turing

Informations de base : https://www.liafa.jussieu.fr/~carton/Enseignement/Complexite/MasterInfo/Cours/turing.html

Pour simuler une machine : https://turingmachine.io/

Machine de Turing universelle : https://fr.wikipedia.org/wiki/Machine_de_Turing_universelle, https://www.geeksforgeeks.org/universal-turing-machine/, https://people.cs.uchicago.edu/~simon/OLD/COURSES/CS311/UTM.pdf, https://www.youtube.com/watch?v=P66h8D5Lkwk

https://github.com/AdonisEnProvence/Turing/blob/master/docs/technical.md#universal-turing-machine-tools utile ?

<<<<<<< HEAD
Time complexity : https://nikhilsardana.github.io/lectures/complexity.pdf, https://www.sciencedirect.com/science/article/pii/S0304397515006623

Haskell : https://hackage.haskell.org/package/CheatSheet-1.11/src/CheatSheet.pdf, https://www.youtube.com/watch?v=Vgu82wiiZ90&list=PLe7Ei6viL6jGp1Rfu0dil1JH1SHk9bgDV, https://learnyouahaskell.com/chapters, https://downloads.haskell.org/ghc/latest/docs/libraries/, https://hoogle.haskell.org/
=======
## haskell

https://learnyouahaskell.com/chapters

To install haskell :

- curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
- restart terminal
- cabal init --interactive (si environnement pas encore cree)
- apt-get install libgmp-dev (pour license GMP)

## OCaml

https://ocaml.org/docs/

## Nico to do

- sauvegarder chaque etat de la [machine, bande] pour detecter un blocage de type boucle infini
- detecter quand on est sur la partie infinie de la bande, si la machine est dans le meme etat que l'etape precedente, alors il y a blocage
- reussir faire un affichage qui s'adapte a toute bande possible
>>>>>>> haskell
