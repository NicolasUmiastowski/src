-----
(1,2), (2,3), (2,5), (3,4), (4,5), (5,6)
fromlasttofirst --done--
(a,b), (c,d) => b = c
(1,2), (2,3),(3,4), (4,5), (5,6)  
-----
(1,2), (2,3), (2,5), (3,4), (4,5), (5,6)
listfilter --done--
(a,b), (c,d) => b = d && a /= c  
(2,5) 
-----
 shortvalue  fromlastofirst
 (2,5)       (1,2), (2,3),(3,4), (4,5), (5,6)
shortpath1
(a,b), (c,d), (e,f)  => d = e || b = c
(1,2), (3,4)), (5,6) 

 shortvalue  fromlastofirst
 [(2,5)]       [(1,2),(3,4),(5,6)]
shortpath2
[(a,b)] :: [(c,d)] :: tl => if (c /= b) then ([(a,b)] :: shortvalue :: tl)
[(1,2),(2,5),(5,6)]

-----
 fromlasttofirst
listlength
5
-----
 shortpath
listlength
3
-----
 listlength listlength
min
 shortpath   

--------------refactoring 10-04-2017-------------------
 [(2,4)] -> [(1,2),(2,3),(3,4),(4,5)]
 -> [(1,2),(2,4),(4,5)]
shortpath3
[(1,2),(2,4),(4,5)]

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

shortpath [(2,3),(3,4),(4,5)] [(2,4)] ([] ++ [(1,2)])
shortpath [(2,3),(3,4),(4,5)] [(2,4)] [(1,2)]

shortpath [(3,4),(4,5)] [(2,4)] ([(1,2)] ++ [])
shortpath [(3,4),(4,5)] [(2,4)] [(1,2)]

shortpath [(4,5)] [(2,4)] ([(1,2)] ++ [])
shortpath [(4,5)] [(2,4)] [(1,2)]

shortpath [] [(2,4)] ([(1,2)] ++ [(4,5)])
shortpath [] [(2,4)] [(1,2),(2,4)]

[(1,2),(2,4)]