def eval(xi, exp)
  ans = False
  a,b = 3
  for i in range len(exp)) :
    part = True
    for j range(len(exp[i])) :
      part = part and xi[exp[i][j]]
    ans = ans or part
  return ans