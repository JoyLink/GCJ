inp = open('C-large-practice.in')
out = open('B-large-practice.out', "w")

T = int(inp.readline())
for i in xrange(T):
    N = int(inp.readline())
    sa, sb = [], []
    s = {}
    for j in xrange(N):
        a = inp.readline().split()
        a1, a2 = a[0], a[1]
        if a1 not in sa:
            sa.append(a1)
        if a2 not in sb:
            sb.append(a2)
        if a1 not in s:
            s[a1] = [a2]
        else:
            if a2 not in s[a1]:
                s[a1].append(a2)

    used = [-1 for j in xrange(len(sb)+1)]
    back = [-1 for j in xrange(len(sb)+1)]

    def find(j):
        for x in xrange(len(sb)):
            if sb[x] in s[sa[j]] and used[x] == -1:
                #who be the first got this place, let others find some others
                used[x] = j
                if back[x] == -1 or find(back[x]):
                    back[x] = j
                    return True
        return False

    ans = 0
    for j in xrange(len(sa)):
        if find(j):
            ans += 1
            #a new search
            used = [-1 for j in xrange(len(sb)+1)]
    out.write("Case #" + str(i+1) + ": " + str(N - len(sa) - len(sb) + ans ) + "\n")