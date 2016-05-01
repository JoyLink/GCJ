inp = open('C-large-practice.in')
out = open('B-large-practice.out', "w")

# T = int(raw_input())
T = int(inp.readline())
for i in xrange(T):
    N = int(inp.readline())
    # N = int(raw_input())
    s = {}
    s1, s2 = [], []
    for  j in xrange(N):
        a = inp.readline().split()
        # a = raw_input().split()
        if a[0] not in s:
            s[a[0]] = [a[1]]
        else:
            if a[1] not in s[a[0]]:
                s[a[0]].append(a[1])
        if a[0] not in s1:
            s1.append(a[0])
        if a[1] not in s2:
            s2.append(a[1])
    used = [0 for j in xrange(len(s2)+1)]
    back = [-1 for j in xrange(len(s2)+1)]
    used1, used2 = set(), set()

    def find(j):
        for x in xrange(len(s2)):
            if s2[x] in s[s1[j]] and used[x] == 0:
                used[x] = 1
                if back[x] == -1 or find(back[x]):
                    back[x] = j
                    return True
        return False

    ans = 0
    for j in xrange(len(s1)):
        if find(j):
            ans += 1
            used = [0 for j in xrange(len(s2)+1)]
    print N, ans, used1, used2
    out.write("Case #"+str(i+1) + ": " + str(N - (len(s1)  + len(s2) - ans) ) +"\n")