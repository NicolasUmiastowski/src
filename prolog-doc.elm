[(1,2),(2,3),(2,4),(3,4),(4,5),(5,6),(5,7),(6,7),(7,8),(8,9)] pathlist 1
removeshortcut
[(5,7),(2,4)] removeshortcut    2


[(2,4),(5,7)]  removeshortcut    2
[(1,2),(2,3),(3,4),(4,5),(5,6),(6,7),(7,8)] pathlist 1
valuestoreplace
[(1,2),(4,5),(7,8)] valuestoreplace 3


[(1,2),(4,5) ,(7,8)] valuestoreplace 3
[(2,4),(5,7)] removeshortcut 2
insertshortcuts
[(1,2),(2,4),(4,5),(5,7),(7,8)] insertshortcuts 4


--------recursive---------
Fromlasttofirst [(1,2),(2,3) (3,0),(2,4),(3,4),(4,5)]  
                List.append [(1,2),(2,3)] (fromlasttofirst [(3,0),(2,4),(3,4),(4,5)])
=> [(1,2),(2,3)]
                                          List.append [] (fromlasttofirst [(3,4) (4,5)])
=> []
                                                          List.append [(3,4) (4,5)] (fromlasttofirst [])
=> [(3,4), (4,5)]                                   
                                                                                    []
=> []
==> [(1,2),(2,3), (3,4), (4,5)]                                                        


--------------shortpath tail recursive -------------
pathlist = [(1,2),(2,3),(3,4),(4,5)]
shortvalue = [(2,4)]

--shortpath [(2,3),(3,4),(4,5)] ([] ++ [(1,2)])
shortpath [(2,3),(3,4),(4,5)] [(1,2)]

--shortpath [(3,4),(4,5)] ([(1,2)] ++ [])
shortpath [(3,4),(4,5)] [(1,2)]

--shortpath [(4,5)] ([(1,2)] ++ [])
shortpath [(4,5)] [(1,2)]

--shortpath [] ([(1,2)] ++ [(4,5)])
shortpath [] [(1,2),(2,4)]

[(1,2),(2,4)]
(List.filter (\(c,d) ->  
             (c >= a && d <= b )  ) pathlist)
 
valuestoreplace
  shortvalue = [(2,4),(5,7)]
  pathlist = [(1,2),(2,3),(3,4),(4,5),(5,6),(6,7),(8,9)]
  accum = []

valuestoreplace
  (2,4)                                       "shortvalue"
  [(1,2),(2,3),(3,4),(4,5),(5,6),(6,7),(8,9)] "pathlist"
  [(5,7)]                                      "tl"
  [] ++ [(2,3),(3,4)]                          "accum"

valuestoreplace
  (5,7)                                       "shortvalue"
  [(1,2),(2,3),(3,4),(4,5),(5,6),(6,7),(8,9)]  "pathlist"
  []                                           "tl"
  [(2,3),(3,4)] ++ [(5,6),(6,7)]               "accum"

valuestoreplace
  []                                           "shortvalue"
  [(2,3),(3,4),(5,6),(6,7)]                    "accum"
 
