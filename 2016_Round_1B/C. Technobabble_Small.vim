inp = open('C-large-practice.in')
out = open('B-large-practice.out', "w")

T = int(inp.readline())

for i in xrange(T):
    N = int(inp.readline())
    c1, c2 = [], []
    s1, s2 = set(), set()
    for j in xrange(N):
        a = inp.readline().split()
        c1.append(a[0])
        c2.append(a[1])
        s1.add(a[0])
        s2.add(a[1])
    end = (1<<N)
    def get(j) :
        ss1, ss2 = set(), set()
        for c in xrange(N):
            if (j >> c) % 2 == 1:
                ss1.add(c1[c])
                ss2.add(c2[c])
        return (len(ss1), len(ss2))

    def cnt(j):
        ans = 0
        for c in xrange(N):
            if (j >> c) % 2 == 1:
                ans += 1
        return ans

    a = 9999999999
    j == 1
    while j < end:

        if get(j) == (len(s1), len(s2)):
            a = min(a, cnt(j))
        j += 1
    # print a, N
    # out.write("Case #"+str(i+1)+": " +str(N-a) + "\n")
    print "Case #"+str(i+1)+": " +str(N-a)