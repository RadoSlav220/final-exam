import Data.List

main::IO()
main = do
  print $ annotate db [evaluation, purity] == [ ("scheme", [ ("macros", "true"), ("typing", "dynamic"), ("evaluation", "strict") ] ), ("haskell", [ ("evaluation", "lazy"), ("pure", "true"), ("typing", "static") ] ),("c++", [ ("evaluation", "strict"), ("macros", "true") ] ) ]


db = [("scheme", [("typing", "dynamic"), ("evaluation", "strict")]), ("haskell", [("typing", "static")]), ("c++", [])]
evaluation "scheme" = [("evaluation", "strict"), ("macros", "true")]
evaluation "haskell" = [("evaluation", "lazy")]
evaluation "c++" = evaluation "scheme"
purity lang = if lang == "haskell" then [("pure", "true")] else []

addIfNew x l = if elem x l then l else (x:l)

annotate db annotators = map
  (\(item, labels) -> (item, foldr addIfNew labels (concatMap (\annotator -> annotator item) annotators))) db
