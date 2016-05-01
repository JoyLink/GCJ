T = int(raw_input())

dic0 = {'Z':1, 'E':1, 'R':1, 'O':1}
dic1 = {'O':1, 'N':1, 'E': 1}
dic2 = {'T':1, 'W':1, 'O':1}
dic3 = {'T':1, 'H':1, 'R':1, 'E':2}
dic4 = {'F':1, 'O':1, 'U':1, 'R':1}
dic5 = {'F':1, 'I':1, 'V':1, 'E':1}
dic6 = {'S':1, 'I':1, 'X':1}
dic7 = {'S':1, 'E':2, 'V':1, 'N':1}
dic8 = {'E':1, 'I':1, 'G':1, 'H':1, 'T':1}
dic9 = {'N':2, 'I':1, 'E':1}



for i in xrange(T):
    s = raw_input()
    ans = []
    dic = {}
    def judge(d2):
        for d in d2:
            if d in dic and d2[d] <= dic[d]:
                continue
            else:
                return False
        for d in d2:
            dic[d] -= d2[d]
        return True

    for c in s:
        if c not in dic:
            dic[c] = 1

        else:
            dic[c] += 1
    # print dic
    while judge(dic0):
        ans.append(0)
    while judge( dic6):
        ans.append(6)
    while judge( dic8):
        ans.append(8)
    while judge( dic3):
        ans.append(3)
    while judge( dic2):
        ans.append(2)
    while judge( dic7):
        ans.append(7)
    while judge( dic5):
        ans.append(5)
    while judge( dic9):
        ans.append(9)
    while judge( dic1):
        ans.append(1)
    # print dic
    while judge( dic4):
        ans.append(4)
    # print ans


    ans.sort()
    ans = map(str, ans)

    # print dic
    # print s
    print "Case #"+str(i+1)+": " + ''.join(ans)
